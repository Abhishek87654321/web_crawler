class CrawlerController < ApplicationController
  def crawl
    url = params[:url]
    crawler = CrawlerService.new(url)
    @sitemap = crawler.crawl_site
  end
end
