# app/services/crawler_service.rb
require 'open-uri'
require 'nokogiri'

class CrawlerService
  def initialize(url)
    @url = url
    @domain = URI.parse(url).host
    @pages = {}
  end

  def crawl_site
    crawl_page(@url)
    @pages
  end

  private

  def crawl_page(url)
    return if @pages[url]

    html = URI.open(url)
    doc = Nokogiri::HTML(html)

    assets = extract_assets(doc)
    links = extract_links(doc)

    @pages[url] = {
      assets: assets,
      links: links
    }

    links.each do |link|
      next unless same_domain?(link)

      crawl_page(link)
    end
  end

  def extract_assets(doc)
    assets = []
    doc.css('script, img, link[href], style').each do |asset|
      url = asset['src'] || asset['href']
      assets << url if url
    end
    assets
  end

  def extract_links(doc)
    links = []
    doc.css('a[href]').each do |link|
      href = link['href']
      links << href if href.start_with?(@domain)
    end
    links
  end

  def same_domain?(url)
    URI.parse(url).host == @domain
  end
end
