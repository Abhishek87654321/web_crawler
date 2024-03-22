# spec/services/crawler_service_spec.rb
require 'rails_helper'

RSpec.describe CrawlerService do
  describe '#crawl_site' do
    it 'should crawl a simple website and return a sitemap' do
      url = 'http://example.com'
      stub_request(:get, url).to_return(body: File.read('spec/fixtures/example_com.html'))

      crawler = CrawlerService.new(url)
      sitemap = crawler.crawl_site

      expect(sitemap.keys).to include(url)
      expect(sitemap[url][:assets]).to include('example.css', 'example.js', 'example.jpg')
      expect(sitemap[url][:links]).to include('http://example.com/about')
    end
  end
end
