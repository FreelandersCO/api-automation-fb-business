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
        self.database = DatabaseOperation()
        my_app_id = task_data.app_id
        my_app_secret = task_data.app_secret
        my_access_token = task_data.access_token
        business_id = task_data.business_id
        since=task_data.since
        until=task_data.until
        period=task_data.period
        since=since.strftime('%Y-%m-%d')
        until=until.strftime('%Y-%m-%d')
        # Start the connection to the facebook API
        FacebookAdsApi.init(my_app_id, my_app_secret, my_access_token)

        dateDelta = datetime.datetime.now() - datetime.timedelta(days=1)
        deltaHyphen = dateDelta.strftime('%Y-%m-%d')

         #Construct the params of time
        if not period:
            params = {
                'level':'ad',
                'time_range': {
                    'since': since,
                    'until': until,
                }
            }
        else:
            params = {
                'level':'ad',
                'date_preset': period
            }
        
        # To keep track of rows added to file
        rows = 0
        data = {}
        data['ads'] = []

        # Get Fields from data base 
        fields = self.database.select('field','type_configuration','ad')
        fields_list = []

        for field in fields:
            if (field.active == 'Y'):
                fields_list.append(field.name_field)

        del fields 
        # Get Breakdowns from data base
        #if()
        breakdowns = self.database.select('breakdown')
        breakdown_list = []

        for breakdown in breakdowns:
            if (breakdown.active == 'Y'):
                breakdown_list.append(breakdown)
        del breakdowns

        # Get field for insights from data base 
        ad_insights = self.database.select('field','type_configuration','ad-insight')
        ad_insights_fields_list = []

        for ad_insights in ad_insights:
            if (ad_insights.active == 'Y'):
                ad_insights_fields_list.append(ad_insights.name_field)
        del ad_insights

        #Iterate through the accounts

        # for account in accounts:
            # Create an addaccount object from the adaccount id to make it possible to get insights
        account_id = account_id
        tempaccount = AdAccount("act_"+account_id)
       
        ads = tempaccount.get_ads(
            params=params,
            fields=fields_list
        )
                
        for ad in ads:
            ad_data = {
                'read':'N',
                'date_consult': datetime.datetime.now().strftime('%Y-%m-%d %X'),
                'id_platform': 1
            }
            for field in fields_list:
                if(field in ad):
                    if (field == 'id'):
                        ad_data['ad_id'] = ad[field]
                    else :
                        ad_data[field] = ad[field] 
            del ad
            self.database.insert('ad',ad_data)            
            ad_object = Ad(ad_data['ad_id'])
            if(task_data.breakdown == 'Y') :
                # Get insight for each breakdown
                for breakdown in breakdown_list:
                    breakdown_names_list = breakdown.name.split(',')
                    #Construct the params of time 
                    
                    #Get Date Start And End
                    
                    if not period:
                        params_ad = {
                            'level':'ad',
                            'time_range': {
                                'since': since,
                                'until': until
                            },
                            'breakdowns': breakdown_names_list,
                            'time_increment': task_data.increment
                        }
                    else:
                        params = {
                            'level':'ad',
                            'date_preset': period,
                            'time_increment': task_data.increment
                        }               

                    breakdown_insights_list =  ad_object.get_insights(
                        params = params_ad,
                        fields = ad_insights_fields_list
                    )
                    if(len(breakdown_insights_list)>0):
                        for breakdown_insight in breakdown_insights_list:
                            breakdown_value = ""
                            for breakdown_name in breakdown_names_list :
                                if (breakdown_name in breakdown_insight):
                                        breakdown_value = breakdown_value + breakdown_insight[breakdown_name] + ","
                            
                            breakdown_insights_data = {
                                'id_breakdown_configuration': breakdown.id_breakdown_configuration,
                                'breakdown_name': breakdown.name,
                                'breakdown_value': breakdown_value,
                                'ad_id': ad_data['ad_id'],
                                'level_insight': 'ad',
                                'time_increment': task_data.increment
                            }

                            for ad_insights_field in ad_insights_fields_list:
                                if (ad_insights_field in breakdown_insight):
                                    breakdown_insights_data[ad_insights_field] = breakdown_insight[ad_insights_field]
                            
                            self.database.insert('insight',breakdown_insights_data)
                            del breakdown_insights_data
            else :
                insights_list =  ad_object.get_insights(
                    params = params,
                    fields = ad_insights_fields_list
                    )
                if(len(insights_list)>0):
                    for insight in insights_list:
                        insights_data = {
                            'ad_id': ad_data['ad_id'],
                            'level_insight':'ad',
                            'time_increment': task_data.increment
                        }
                    for ad_insights_field in ad_insights_fields_list:
                        if (ad_insights_field in insight):
                            insights_data[ad_insights_field] = superSerialize(insight[ad_insights_field])
                    insights_data['date_consult'] = datetime.datetime.now().strftime('%Y-%m-%d %X')
                    self.database.insert('insight',insights_data)
                    del insights_data                         
                
            #Check if you reached 75% of the limit, if yes then back-off for 5 minutes (put this chunk in your
            if (check_limit(account_id,my_access_token)>75):
                print('75% Rate Limit Reached. Cooling Time 5 Minutes. '+ account_id)
                logging.debug('75% Rate Limit Reached. Cooling Time 5 Minutes.')
                time.sleep(300)
                print('Cooling finish.'+ account_id)