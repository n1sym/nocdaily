require 'mechanize'
require 'net/http'
require 'uri'
require 'json'
require 'csv'
require 'date'

def main
  data = scrape()
  new_data = get_new_data(data)
  write_csv(new_data)
  write_json(new_data)
end

def scrape
  agent = Mechanize.new
  url = "https://noc.syosetu.com/rank/list/type/daily_total/"
  page = agent.get(url)
  
  cookie = agent.cookies.first
  cookie.name = 'over18'
  cookie.value = 'yes'
  sleep 1
  page = agent.get(url)

  titles = page.xpath('//div[@class="rank_h"]/a')
  tables = page.xpath('//table[@class="rank_table"]')

  data = []
  100.times do |i|
    title = titles[i].text
    table = tables[i]
    url = titles[i].attribute("href").value
    id = url.split("/")[3]

    header = table.css("td")[0].text.split("\n").reject(&:empty?)
    desc = table.css("td")[1].text.gsub("\n", " ")
    footer = table.css("td")[2].text.split("\n\n").map{|el|el.split("\n").reject(&:empty?)}
    
    state = header[1]
    counts = footer[1][0].split("分")[1]
    keywords = footer[0]
    keywords.shift
    keywords = keywords.join("/")

    unit = [id, title, url, state, desc, keywords, counts] 
    data << unit
  end

  data
end

def write_csv(data)
  CSV.open("list.csv",'a') do |csv|
    data.each do |unit|
      novel_id = unit[0]
      csv << [novel_id]
    end
  end
end

def list
  list = CSV.read("list.csv")
end

def exist_novel_ids
  @exist_novel_ids ||= list.map{ |li| li[0] }
end

def get_new_data(data)
  new_data = []
  data.each do |unit|
    novel_id = unit[0]
    new_data << unit unless exist_novel_ids.include?(novel_id)
  end
  new_data
end

def write_json(data)
  today = Date.today.to_s
  arr = []
  # [id, title, url, state, desc, keywords, counts] 
  data.each do |unit|
    arr << {
      id: unit[0],
      title: unit[1],
      url: unit[2],
      state: unit[3],
      desc: unit[4],
      keywords: unit[5],
      counts: unit[6]
    }
  end
  File.open("data/#{today}.json","w") {|file| 
    file.puts(JSON.generate(arr))
  }
end

main()