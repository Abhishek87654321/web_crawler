class CrawlerController < ApplicationController
  def crawl
    url = params[:url]
    if url.present?
      crawler = CrawlerService.new(url)
      @sitemap = crawler.crawl_site
    else
      flash[:error] = "URL cannot be blank"
      redirect_to articles_index_path
    end
  end
end
