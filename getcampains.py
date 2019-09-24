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
        my_app_id = task_data.app_id
        my_app_secret = task_data.app_secret
        my_access_token = task_data.access_token
        business_id = task_data.business_id
        since=task_data.since
        until=task_data.until
        period=task_data.period
        since=since.strftime('%Y-%m-%d')
        until=until.strftime('%Y-%m-%d')

        dateDelta = datetime.datetime.now() - datetime.timedelta(days=1)
        deltaHyphen = dateDelta.strftime('%Y-%m-%d')
        #print(deltaHyphen)

        #Construct the params of time
        if not period:
            params = {
                'level':'campaign',
                'time_range': {
                    'since': since,
                    'until': until,
                },
                'time_increment': task_data.increment
            }
        else:
            params = {
                'level':'campaign',
                'date_preset': period,
                'time_increment': task_data.increment
            }
        
        # Start the connection to the facebook API
        FacebookAdsApi.init(my_app_id, my_app_secret, my_access_token)

        # Create a business object for the business account
        business = Business(business_id)

        # Get Fields Configuration
        fields = self.database.select('field','type_configuration','campaing')
        fieldsList = []

        for field in fields:
            if (field.active == 'Y'):
                fieldsList.append(field.name_field)

        del fields

        # Get field for insights from data base 
        campaing_insights = self.database.select('field','type_configuration','campaing-insight')
        campaing_insights_fields_list = []

        for campaing_insights in campaing_insights:
            if (campaing_insights.active == 'Y'):
                campaing_insights_fields_list.append(campaing_insights.name_field)
        del campaing_insights

        # To keep track of rows added to file
        rows = 0

        #Iterate through the adaccounts
        #for account in accounts:
            # Create an addaccount object from the adaccount id to make it possible to get insights
        account_id = account_id
        tempaccount = AdAccount("act_"+account_id)
        # Grab insight info for all camp in the adaccount
        camps = tempaccount.get_campaigns(
            fields=fieldsList,
            params=params
        )
        for camp in camps:
            #print(camp,'Acà')
            campaing_data = {
                'date_consult': datetime.datetime.now().strftime('%Y-%m-%d %X'),
                'id_platform': 1
            }
            for field in fieldsList:
                if(field in camp):
                    if (field == 'id'):
                        campaing_data['campaing_id'] = camp[field]
                    else :
                        if(field == 'promoted_object'):
                            campaing_data[field] = superSerialize(camp[field])
                        else:
                            campaing_data[field] = camp[field]
            rows = rows + 1
            #print(campaing_data)
            #Save in data base
            self.database.insert('campaing',campaing_data)
            #Insight
            campaing_object = Campaign(campaing_data['campaing_id'])
            insights_list =  campaing_object.get_insights(
                params = params,
                fields = campaing_insights_fields_list
            )
            if(len(insights_list)>0):
                for insight in insights_list:
                    insights_data = {
                        'campaing_id': campaing_data['campaing_id'],
                        'level_insight':'campaign',
                        'time_increment': task_data.increment
                    }
                    for campaing_insights_field in campaing_insights_fields_list:
                        if (campaing_insights_field in insight):
                            if(campaing_insights_field == 'promoted_object'):
                                insights_data[campaing_insights_field] = superSerialize(insight[campaing_insights_field])
                            else:
                                insights_data[campaing_insights_field] = insight[campaing_insights_field]
                    insights_data['date_consult']=datetime.datetime.now().strftime('%Y-%m-%d %X')
                    self.database.insert('insight',insights_data)
                    del insights_data
        
            #Check if you reached 75% of the limit, if yes then back-off for 5 minutes (put this chunk in your 'for ad is ads' loop, every 100-200 iterations)
            if (check_limit(account_id,my_access_token)>75):
                print('75% Rate Limit Reached. Cooling Time 5 Minutes.'+ account_id)
                logging.debug('75% Rate Limit Reached. Cooling Time 5 Minutes.')
                time.sleep(300)
                print('Cooling finish.'+ account_id)

        # Print report
        print (str(rows) + " rows added to the file ")