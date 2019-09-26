# Import system necesary library
import datetime , sys, json, os, argparse, logging, time
import requests as rq

#Import Helpers
from helpers import getDates , periodToDays , check_limit

from datab import DatabaseOperation

# Import all the facebook mumbo jumbo
from facebook_business.api import FacebookAdsApi
from facebook_business.adobjects.adsinsights import AdsInsights
from facebook_business.adobjects.adaccount import AdAccount
from facebook_business.adobjects.business import Business

from multiprocessing.pool import ThreadPool

class Accounts(object):
    def __init__(self,task_data):
        super(Accounts).__init__()
        self.database = DatabaseOperation()
        my_app_id = task_data.app_id
        my_app_secret = task_data.app_secret
        my_access_token = task_data.access_token
        business_id = task_data.business_id

        # Start the connection to the facebook API
        FacebookAdsApi.init(my_app_id, my_app_secret, my_access_token)

        # Create a business object for the business account
        business = Business(business_id)

        # Get all ad accounts on the business account
        accounts = business.get_owned_ad_accounts(
            fields=[
                AdAccount.Field.account_id ,
                AdAccount.Field.account_status ,
                AdAccount.Field.name ,
                AdAccount.Field.age ,
                AdAccount.Field.amount_spent ,
                AdAccount.Field.business ,
                AdAccount.Field.business_city ,
                AdAccount.Field.business_country_code ,
                AdAccount.Field.business_name ,
                AdAccount.Field.business_state ,
                AdAccount.Field.business_street ,
                AdAccount.Field.business_street2 ,
                AdAccount.Field.business_zip
            ]
        )

        # To keep track of rows added to file
        rows = 0

        #Iterate through the adaccounts
        for account in accounts:
            # Write all ad info to the file, and increment the number of rows that will display
            #Construct the params of time
            id_account = self.database.select('account', 'account_id',account[AdAccount.Field.account_id])
            if len(id_account) == 0:
                value = {
                    'fb_id':account[AdAccount.Field.id],
                    'account_id':account[AdAccount.Field.account_id],
                    'name':account[AdAccount.Field.name],
                    'account_status':account[AdAccount.Field.account_status],
                    'age':account[AdAccount.Field.age],
                    'amount_spent':account[AdAccount.Field.amount_spent]
                }
                rows = rows + 1
                self.database.insert('account',value)

        print(str(rows) + " rows added ")