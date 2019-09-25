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
    Accounts(bussines_data)
    accounts = DB.select('account','account_id', '499413830878475')
    for account in accounts:        
        hilo3 = threading.Thread(target=Campain,args=(bussines_data,account.account_id,))
        hilo3.start()
        hilo4 = threading.Thread(target=Adset,args=(bussines_data,account.account_id,))
        hilo4.start()
        hilo2 = threading.Thread(target=Ads,args=(bussines_data,account.account_id,))
        hilo2.start()
        hilo2.join()
        hilo5 = threading.Thread(target=AdsCreativites,args=(bussines_data,account.account_id,))
        hilo5.start()

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