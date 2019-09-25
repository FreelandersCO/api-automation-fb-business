# Import system necesary library
import datetime , sys, json, os, argparse, logging, time
import requests as rq

#Import Helpers
from helpers import getDates , periodToDays , check_limit , superSerialize

from datab import DatabaseOperation

# Import all the facebook mumbo jumbo
from facebook_business.api import FacebookAdsApi
from facebook_business.adobjects.adsinsights import AdsInsights
from facebook_business.adobjects.adaccount import AdAccount
from facebook_business.adobjects.business import Business
from facebook_business.adobjects.adset import AdSet

from multiprocessing.pool import ThreadPool


class Adset(object):
    def __init__(self,task_data,account_id):
        super(Adset).__init__()
        print('Run Adset')
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
                'level':'adset',
                'time_range': {
                    'since': since,
                    'until': until,
                },
                'time_increment': task_data.increment
            }
        else:
            params = {
                'level':'adset',
                'date_preset': str(period),
                'time_increment': task_data.increment
            }

        # Get all ad accounts on the business account
        # accounts = self.database.select('account','id_task', id_task)

        # Get Fields Configuration
        fields = self.database.select('field','type_configuration','adset')
        fieldsList = []
        rows = 0
        for field in fields:
            if (field.active == 'Y'):
                fieldsList.append(field.name_field)

        del fields
        adset_insights= self.database.select('field','type_configuration','adset-insight')
        adset_insight_fields_list = []
        for adset_insight in adset_insights:
            if (adset_insight.active == 'Y'):
                adset_insight_fields_list.append(adset_insight.name_field)
                rows = rows +1
        del adset_insight

        # To keep track of rows added to file
        rows = 0

        #Iterate through the adaccounts
        # for account in accounts:
        # Create an addaccount object from the adaccount id to make it possible to get insights
        account_id = account_id
        tempaccount = AdAccount("act_"+account_id)

        # Grab insight info for all camp in the adaccount
        adsets = tempaccount.get_ad_sets(
            params = params,
            fields = fieldsList
        )
        for adset in adsets:
            
            data_adset = {
                'id_platform': 1
            }
            for field in fieldsList:
                if(field in adset):
                    if (field == 'id'):
                        data_adset['adset_id'] = adset[field]
                    else :
                        if(field == 'targeting'):
                            data_adset[field] = superSerialize(adset[field])
                        else:
                            data_adset[field] = adset[field]

                        
            rows = rows + 1
            #Save in data base
            self.database.insert('adset',data_adset)
            #Get insight
            adset_object = AdSet(data_adset['adset_id'])
            insights_list =  adset_object.get_insights(
                params = params,
                fields = adset_insight_fields_list
            )
            if(len(insights_list)>0):
                for insight in insights_list:
                    insights_data = {
                        'adset_id': data_adset['adset_id'],
                        'level_insight':'adset',
                        'time_increment': task_data.increment
                    }
                    for adset_insight_field in adset_insight_fields_list:
                        if (adset_insight_field in insight):
                            # insights_data[adset_insight_field] = superSerialize(insight[adset_insight_field])
                            insights_data[adset_insight_field] = insight[adset_insight_field]
                    
                    self.database.insert('insight',insights_data)
                    del insights_data
                #Check if you reached 75% of the limit, if yes then back-off for 5 minutes (put this chunk in your 'for ad is ads' loop, every 100-200 iterations)
                if (check_limit(account_id,my_access_token)>75):
                    print('75% Rate Limit Reached. Cooling Time 5 Minutes. '+ account_id)
                    logging.debug('75% Rate Limit Reached. Cooling Time 5 Minutes.')
                    time.sleep(300)
                    print('Cooling finish.'+ account_id)
        