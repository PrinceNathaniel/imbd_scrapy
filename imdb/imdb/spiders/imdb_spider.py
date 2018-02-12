from imdb.items import imdbItem
from scrapy import Spider,Request

class imdbSpider(Spider):
    name='imdb_spider'
    allowed_urls = ['http://www.imdb.com']
    #start_urls=['http://www.imdb.com/title/tt0120891/reviews?ref_=tt_ov_rt']
    for i in range(0,20):
        year1=1998+i
        year2=1999+i
        start_urls=['http://www.imdb.com/search/title?release_date='+str(year1)+'-01-01,'+str(year2)+'-01-01&page=%s&ref_=adv_nxt'% page for page in range(0,10)]
    #start_urls=['http://www.imdb.com/search/title?release_date=1999-01-01,2000-01-01']
    def parse(self,response):
        rows=response.xpath('//h3[@class="lister-item-header"]')
        for row in rows:
            item=imdbItem()
            tmp=row.xpath('.//a/@href').extract_first().split('/')[2]
            url='http://www.imdb.com/title/'+tmp+'/reviews?ref=tt_ov_rt'
            request=Request(url,callback=self.parse2)
            request.meta['item']=item
            yield request

    def parse2(self,response):
        #item=response.meta['item']

        rows = response.xpath('//div[@class="lister-item-content"]')
        for row in rows:
            item=response.meta['item']
            item["Rank"]=row.xpath('.//div[@class="ipl-ratings-bar"]/span/span/text()').extract_first()
            item['Year']=row.xpath('.//span[@class="review-date"]/text()').extract_first().split()[-1]

            item['Review']=row.xpath('.//div[@class="text"]/text()').extract_first()
            yield item
            