# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class imdbItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()

    Rank=scrapy.Field()
    #Name=scrapy.Field()
    Year=scrapy.Field()
    Review=scrapy.Field()
class imdbItem2(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    movienum=scrapy.Field()
    
