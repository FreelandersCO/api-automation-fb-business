import datetime , sys, json, os, argparse, logging, time, threading
import requests as rq

#Import Helpers
from helpers import getDatesCustom

#conexion a la base de datos
from datab import DatabaseOperation
from getaccounts import Accounts
from getadsets import Adset
from getads import Ads
from getcampains import Campain
from getcreatives import AdsCreativites

parser = argparse.ArgumentParser()
#Database conection
DB = DatabaseOperation()


def run_task_thread(**bussines_task):
    bussines_data=bussines_task['bussines_task']
    now = datetime.datetime.now()
    print(' Start to run business ', bussines_data.business_id, now.year, now.month, now.day, now.hour, now.minute, now.second)
    hilo1 = threading.Thread(target=Accounts,args=(bussines_data,))
    hilo1.start()
    hilo1.join()
    accounts = DB.select('account')
    for account in accounts:
        print('Start Campaing')
        Campain(bussines_data,account.account_id)
        print('End Campaing Cooling Time 10 Seconds ')
        time.sleep(10)
        print('Start Adset')
        Adset(bussines_data,account.account_id)
        print('End Adset Cooling Time 10 Seconds ')
        time.sleep(10)
        print('Start Ads')
        Ads(bussines_data,account.account_id)
        print('End Ads Cooling Time 10 Seconds ')
        time.sleep(10)
        print('Start AdsCreativites')
        AdsCreativites(bussines_data,account.account_id)
        print('End AdsCreativites Cooling Time 10 Seconds ')
        time.sleep(10)

    print(' End to run business ', bussines_data.business_id, now.year, now.month, now.day, now.hour, now.minute, now.second)
    




def main():
    print('Running Facebook Bussines')
    if not os.path.exists('temp'):
        os.makedirs('temp')

    task_data = DB.select('token')
    for task in task_data :
        print(task)
        hilo = threading.Thread(target=run_task_thread,
                                kwargs={
                                    'bussines_task':task
                                })
        hilo.start()

if __name__ == '__main__':
    main()