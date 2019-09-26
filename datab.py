#import sqlalchemy
from sqlalchemy import create_engine, Table, Column, String, MetaData, Float, Date, Integer, exc
from sqlalchemy.dialects.postgresql import ARRAY, BIGINT, BIT, BOOLEAN, BYTEA, CHAR, CIDR, DATE, DOUBLE_PRECISION, ENUM, FLOAT, HSTORE, INET, INTEGER, INTERVAL, JSON, JSONB, MACADDR, MONEY, NUMERIC, OID, REAL, SMALLINT, TEXT, TIME, TIMESTAMP, UUID, VARCHAR, INT4RANGE, INT8RANGE, NUMRANGE, DATERANGE, TSRANGE, TSTZRANGE, TSVECTOR
import datetime , sys, json, os, argparse, logging, time


# define a class
class DatabaseOperation:
    def __init__(self):
        '''Returns a connection and a metadata object'''
        # We connect with the help of the PostgreSQL URL
        user='postgres'
        password='1nt3r4ct1v3'
        db='havas_bussines'
        host='localhost'
        port='5432'
        url = 'postgresql://{}:{}@{}:{}/{}'
        url = url.format(user, password, host, port, db)

        # The return value of create_engine() is our connection object
        self.con = create_engine(url, client_encoding='utf8')

        # We then bind the connection to MetaData()
        self.meta = MetaData(bind=self.con, reflect=True)

        self.account_table = Table('account', self.meta, extend_existing=True)
        self.token_table = Table('token', self.meta, extend_existing=True)
        self.campaing_table = Table('campaing', self.meta, extend_existing=True)
        self.ad_table = Table('ad', self.meta, extend_existing=True)
        self.creative_table = Table('creative', self.meta, extend_existing=True)
        self.adset_table = Table('adset', self.meta, extend_existing=True)
        self.field_table = Table('field_configuration', self.meta, extend_existing=True)
        self.breakdown_configuration_table = Table('breakdown_configuration', self.meta, extend_existing=True)
        self.insight_table= Table('insight', self.meta, extend_existing=True)

    def get_table(self, table):
        switcher = {
            'account' : self.account_table,
            'ad' : self.ad_table,
            'adset' : self.adset_table,
            'breakdown' : self.breakdown_configuration_table,
            'campaing' : self.campaing_table,
            'creative' : self.creative_table,
            'field' : self.field_table,
            'insight': self.insight_table,
            'token' : self.token_table,
        }
        return switcher.get(table, "Invalid Param")

    def insert(self, tableParam, data):
        table = self.get_table(tableParam)
        with self.con.connect() as conn:
            insert_statement = table.insert().values(data)
            conn.execute(insert_statement)
    
    def select(self, tableParam, fieldFilter = False, value = False):
        table = self.get_table(tableParam)
        with self.con.connect() as conn:
            if fieldFilter:
                select_statement = table.select().where(table.columns[fieldFilter] == value)
            else :
                select_statement = table.select()
            result_set = conn.execute(select_statement).fetchall()
            return result_set

    def update(self, tableParam, fieldFilter = False, value = False, data={}):
        table = self.get_table(tableParam)
        with self.con.connect() as conn:
            if fieldFilter:
                update_statement = table.update().where(table.columns[fieldFilter] == value).values(data)
                result_set = conn.execute(update_statement)
            else:
                result_set=0
            return result_set
    
    def delete(self, tableParam, fieldFilter = False, value = False):
        table = self.get_table(tableParam)
        with self.con.connect() as conn:
            if fieldFilter:
                update_statement = table.delete().where(table.columns[fieldFilter] == value)
                result_set = conn.execute(update_statement)
            else:
                result_set=0
            return result_set