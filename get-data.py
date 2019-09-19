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
    print(bussines_data.business_id)
    now = datetime.datetime.now()
    deltaCurrent = now.strftime('%Y-%m-%d %X')
    deltalog = now.strftime('%Y-%m-%d-%X')
    print(' Start to run Page ', bussines_data.business_id, now.year, now.month, now.day, now.hour, now.minute, now.second)
    hilo1 = threading.Thread(target=Accounts,args=(bussines_data,))
    hilo1.start()
    hilo1.join()
    accounts = DB.select('account')
    for account in accounts:
        #print('entramos aqui')
        #print(account)
        hilo2 = threading.Thread(target=Ads,args=(bussines_data,account.account_id,))
        hilo2.start()
        hilo2.join()
        hilo3 = threading.Thread(target=Campain,args=(bussines_data,account.account_id,))
        hilo3.start()
        hilo3.join()
        hilo4 = threading.Thread(target=Adset,args=(bussines_data,account.account_id,))
        hilo4.start()
        hilo4.join()
        hilo5 = threading.Thread(target=AdsCreativites,args=(bussines_data,account.account_id,))
        hilo5.start()
        hilo5.join()




def main():
    print('Running Facebook Bussines')
    if not os.path.exists('temp'):
        os.makedirs('temp')

    task_data = DB.select('token')
    for task in task_data :
        hilo = threading.Thread(target=run_task_thread,
                                kwargs={
                                    'bussines_task':task
                                })
        hilo.start()

if __name__ == '__main__':
    main()