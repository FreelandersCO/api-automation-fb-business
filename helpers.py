# Import systeme necesary library
import datetime, csv, sys, json, os, logging, time
import requests as rq
import sqlalchemy

dirpath = os.getcwd()

def getDates(delta):
    # Get yesterday's date for the filename, and the csv data
    dateCurrent=datetime.datetime.now()
    dateDelta = datetime.datetime.now() - datetime.timedelta(days=delta)
    deltaHyphen = dateDelta.strftime('%Y-%m-%d')
    dateFolder= dateCurrent.strftime('%Y-%m-%d')
    
    return deltaHyphen, dateFolder

def getDatesCustom(delta_ini,delta_end):
    # Get yesterday's date for the filename, and the csv data
    print(delta_ini)
    print(delta_end)
    # dateCurrent=datetime.datetime.now()
    # dateDelta = datetime.datetime.now() - datetime.timedelta(days=delta)
    # deltaHyphen = dateDelta.strftime('%Y-%m-%d')
    # dateFolder= dateCurrent.strftime('%Y-%m-%d')
    
    # return deltaHyphen, dateFolder

def superSerialize(theData):
    if (type(theData) is int) or (type(theData) is list) or (type(theData) is str) or (type(theData) is bool): 
        finalData = theData
    else :
        finalData = {}
        indexes = []
        for data in theData:
            indexes.append(data)

        for index in indexes:
            dato = theData.get(index)
            if (type(dato) is int) or (type(dato) is list) or (type(dato) is str) or (type(dato) is bool): 
                finalData[index] = dato
            else :
                finalData[index] = superSerialize(dato)
       
    return json.dumps(finalData)

def periodToDays(period):
    switcher = {
        'last_14d' : 14,
        'last_28d' : 28,
        'last_30d' : 30,
        'last_3d' : 3,
        'last_7d' : 7,
        'last_90d' : 90,
        'last_month' : 31,
        'last_quarter' : 90,
        'last_week_mon_sun' : 5,
        'last_week_sun_sat' : 3,
        'last_year' : 360,
        'lifetime' : 'history',
        'this_month' : 30,
        'this_quarter' : 90,
        'this_week_mon_today' : 5,
        'this_week_sun_today' : 3,
        'this_year' : 306,
        'today' : 0,
        'yesterday' : 1,
    }
    return switcher.get(period, "Invalid month")

#Function to find the string between two strings or characters
def find_between( s, first, last ):
    try:
        start = s.index( first ) + len( first )
        end = s.index( last, start )
        return s[start:end]
    except ValueError:
        return ""

#Function to check how close you are to the FB Rate Limit
def check_limit(account_number,my_access_token):
    url = 'https://graph.facebook.com/v3.3/act_'+account_number+'/campaigns'
    try:
        check=rq.get(url, params={'access_token': my_access_token})
        headers = check.headers
        if 'x-ad-account-usage' in headers:
            usage=float(find_between(check.headers['x-ad-account-usage'],':','}'))
            return usage
        else:
            # Maybe set up for a retry, or continue in a retry loop
            print('Error validating the limit sleep 1 minutes (Timeout)')
            logging.debug('Error validating the limit sleep 1 minutes')
            time.sleep(60)
            check_limit(account_number,my_access_token)
    except rq.exceptions.Timeout:
        # Maybe set up for a retry, or continue in a retry loop
        print('Error validating the limit sleep 3 minutes (Timeout)')
        logging.debug('Error validating the limit sleep 3 minutes')
        time.sleep(120)
        check_limit(account_number,my_access_token)
    except rq.exceptions.TooManyRedirects:
        # Tell the user their URL was bad and try a different one
        print('Error validating the limit sleep 3 minutes (TooManyRedirects)')
        logging.debug('Error validating the limit sleep 3 minutes')
        time.sleep(120)
        check_limit(account_number,my_access_token)
    except rq.exceptions.RequestException as e:
        # catastrophic error. bail.
        print('Error validating the limit sleep 3 minutes (RequestException)', e)
        logging.debug('Error validating the limit sleep 3 minutes')
        time.sleep(120)
        check_limit(account_number,my_access_token)

