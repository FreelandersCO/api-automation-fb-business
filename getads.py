# Import system necesary library
import datetime , sys, json, os, argparse, logging, time
import requests as rq

#Import Helpers
from helpers import getDates, periodToDays , check_limit, superSerialize

from datab import DatabaseOperation

# Import all the facebook mumbo jumbo
from facebook_business.api import FacebookAdsApi
from facebook_business.adobjects.adsinsights import AdsInsights
from facebook_business.adobjects.adaccount import AdAccount
from facebook_business.adobjects.business import Business
from facebook_business.adobjects.ad import Ad

from multiprocessing.pool import ThreadPool

class Ads(object):
    def __init__(self,task_data,account_id):
        super(Ads).__init__()
        print('Running AD')
        self.database = DatabaseOperation()
        my_app_id = task_data.app_id
        my_app_secret = task_data.app_secret
        my_access_token = task_data.access_token
        since=task_data.since
        until=task_data.until
        period=task_data.period
        since=since.strftime('%Y-%m-%d')
        until=until.strftime('%Y-%m-%d')
        # Start the connection to the facebook API
        FacebookAdsApi.init(my_app_id, my_app_secret, my_access_token)
        
        # Arma la lista para llenar la tabla AD
        fields = self.database.select('field','type_configuration','ad')
        ad_field_list = []

        for field in fields:
            if (field.active == 'Y'):
                ad_field_list.append(field.name_field)

        # Arma la lista para llenar la tabla de insight
        fields = self.database.select('field','type_configuration','ad-insight')
        ad_field_insight_list = []

        for field in fields:
            if (field.active == 'Y'):
                ad_field_insight_list.append(field.name_field)

        del fields 
        # Merge de las 2 listas
        ad_field_insight_list =  ad_field_insight_list + ad_field_list
        # Define los parametros para el llamado
        if not period:
            params_ad = {
                'level':'ad',
                'time_range': {
                    'since': since,
                    'until': until
                },
                'time_increment': task_data.increment
            }
        else:
            params_ad = {
                'level':'ad',
                'date_preset': period,
                'time_increment': task_data.increment
            }
        
        # Arma el diccionrio de Breakdowns si está activo
        if(task_data.breakdown == 'Y') :
            breakdowns = self.database.select('breakdown')
            breakdown_names = []
            breakdown_list = []

            for breakdown in breakdowns:
                if (breakdown.active == 'Y'):
                    breakdown_names.append(breakdown.name)
                    breakdown_list.append(breakdown)
            del breakdowns
            params_ad['breakdowns'] = breakdown_names

        # Hace el llamado
        try:
            data_list =  AdAccount("act_"+account_id).get_insights(
                params = params_ad,
                fields = ad_field_insight_list
            )
        except:
            data_list = []

        if(len(data_list)>0):
            # Recorre el llamado
            for data_single in data_list:
                # data para la tabla ad
                ad_data = {
                    'read':'N',
                    'id_platform': 1
                }
                # Extrae los datos para la tabla AD
                for ad_field in ad_field_list:
                    if(ad_field in data_single):
                        ad_data[ad_field] = data_single[ad_field]
                # Inserta en la tabla add
                try:
                    self.database.insert('ad',ad_data)
                    ad_id = ad_data['ad_id']
                    del ad_data 
                except:
                    ad_id = ad_data['ad_id']
                
                # Extrae los datos para la tabla Insight
                if(task_data.breakdown == 'Y') :
                    #Datos con breakdown
                    ad_field_insight_list = ad_field_insight_list + breakdown_names
                # Datos Estaticos
                insights_data = {
                    'ad_id': ad_id,
                    'level_insight':'ad',
                    'time_increment': task_data.increment
                }
                # Extrae los datos para la tabla Insight
                for ad_field_insight in ad_field_insight_list:
                    if(ad_field_insight in data_single):
                        if ad_field_insight == 'relevance_score':
                            insights_data[ad_field_insight] = superSerialize(data_single[ad_field_insight])
                        else:
                            insights_data[ad_field_insight] = data_single[ad_field_insight]

                # Inserta los datos para la tabla Insight
                try:
                    self.database.insert('insight',insights_data)
                    del insights_data 
                except:
                    print('falla')
                #Check if you reached 75% of the limit, if yes then back-off for 5 minutes (put this chunk in your 'for ad is ads' loop, every 100-200 iterations)
                if (check_limit(account_id,my_access_token)>75):
                    print('75% Rate Limit Reached. Cooling Time 5 Minutes.'+ account_id)
                    logging.debug('75% Rate Limit Reached. Cooling Time 5 Minutes.')
                    time.sleep(300)
                    print('Cooling finish.'+ account_id)


                #print('Dato', data_single['ad_name'], data_single['reach'] , data_single['date_start'], data_single['date_stop'])
            

        

        