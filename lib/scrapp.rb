# coding: utf-8
require "scrapp/version"

module Scrapp
# Récupère les titres des annonces
def name
  @links = []
  @names = []
  i = 0
  page = Nokogiri::HTML(open(@page_url))
  news_links = page.css('div[class=col-10]').css('div[class=row]').css('div[class=col-12]').css('div[class=job__name]').css('a')
  news_links.each do |link|
    @links[i] = link['href']
    @names[i] = link.text
    i +=1
  end
end

# Récupère la description du job
def     parse_pres_job
  i = 0
  j = 0
  @pres = []
  @links.each do |link|
    url = "https://startuponly.com"
    page = Nokogiri::HTML(open(url + "#{link}"))
    news_links = page.css('div[class="row"]').css('div[class="col-12 col-sm-7"]').css('div[class="row"]').css('div[class="col-12"]').css('p')
    news_links.each do |p|
      @pres[j] = p.text
      pp @pres[j]
      j +=1
    end
    i +=1
  end
end

def get_tag(array)
  tags = ''
  array.each do |string|
    if string["class"] == "jobRow__tag"
      tags += string.text
      tags += ","
    end
  end
  return tags
end

# Récupère le type de job,la durée et les tags
def parse_type_job
  i = 0
  job = []
  hash_offre = {}
  tags = []
  @links.each do |link|
    url = 'https://startuponly.com'
    page = Nokogiri::HTML(open(url + "#{link}"))
    news_links = page.css('div[class="row"]').css('div[class="col-12 col-sm-7"]').css('div[class="row"]').css('div[class="col-12"]').css('span')
    tags[i] = get_tag(news_links);
    puts tags[i]
    i +=1
  end
  i = 0
  @pres.each do |presentation|
    job[i] = hash_offre = {"name" => @names[i], "offre"=> presentation, "tag"=> tags[i]}
    i +=1
  end
  job.each do |jobs|
    pp "#{jobs}"
    pp "############################################"
  end
end
end
