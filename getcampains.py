# This program downloads all relevent Facebook traffic info as a json file
# This program requires info from the Facebook Ads API: https://github.com/facebook/facebook-python-ads-sdk

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
from facebook_business.adobjects.campaign import Campaign

from multiprocessing.pool import ThreadPool


class Campain(object):
    def __init__(self,task_data,account_id):
        super(Campain).__init__()
        self.database = DatabaseOperation()
        print('Running Campains')
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

        # Get Fields Configuration
        fields = self.database.select('field','type_configuration','campaing')
        fields_list = []
        fields_list_names = []

        for field in fields:
            if (field.active == 'Y'):
                fields_list.append(field)
                fields_list_names.append(field.name_field)

        del fields

        # Get field for insights from data base 
        campaing_insights = self.database.select('field','type_configuration','campaing-insight')
        campaing_insights_fields_list = []
        campaing_insights_fields_names = []
        for campaing_insights in campaing_insights:
            if (campaing_insights.active == 'Y'):
                campaing_insights_fields_list.append(campaing_insights)
                campaing_insights_fields_names.append(campaing_insights.name_field)
        del campaing_insights

        #Construct the params of time
        if not period:
            params = {
                'level':'campaign',
                'time_range': {
                    'since': since,
                    'until': until,
                }
            }
        else:
            params = {
                'level':'campaign',
                'date_preset': period
            }
        # Grab insight info for all camp in the adaccount
        camps = AdAccount('act_'+account_id).get_campaigns(
            fields=fields_list_names,
            params=params
        )
        
        for camp in camps:
            campaing_data = {
                'id_platform': 1
            }
            for field in fields_list:
                if(field.name_field in camp):
                    if(field.serialize == 'Y'):
                            campaing_data[field.name_field] = superSerialize(camp[field.name_field])
                    else:
                        campaing_data[field.name_field] = camp[field.name_field]

            try:
                self.database.insert('campaing',campaing_data)
                del campaing_data 
            except:
                del campaing_data 
        
        params['time_increment'] = task_data.increment
        insights_list =  AdAccount('act_'+account_id).get_insights(
            params = params,
            fields = campaing_insights_fields_names
        )
        if(len(insights_list)>0):
            for insight in insights_list:
                insights_data = {
                    'level_insight':'campaign',
                    'time_increment': task_data.increment
                }
                for campaing_insights_field in campaing_insights_fields_list:
                    if (campaing_insights_field.name_field in insight):
                        if(campaing_insights_field.serialize == 'Y'):
                            insights_data[campaing_insights_field.name_field] = superSerialize(insight[campaing_insights_field.name_field])
                        else:
                            insights_data[campaing_insights_field.name_field] = insight[campaing_insights_field.name_field]
                try:
                    self.database.insert('insight',insights_data)
                    del insights_data 
                except:
                    print('falla')            
                    del insights_data
        
            #Check if you reached 75% of the limit, if yes then back-off for 5 minutes (put this chunk in your 'for ad is ads' loop, every 100-200 iterations)
            if (check_limit(account_id,my_access_token)>75):
                print('75% Rate Limit Reached. Cooling Time 5 Minutes.'+ account_id)
                logging.debug('75% Rate Limit Reached. Cooling Time 5 Minutes.')
                time.sleep(300)
                print('Cooling finish.'+ account_id)
