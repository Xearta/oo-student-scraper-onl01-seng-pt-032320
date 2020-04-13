require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    index = Nokogiri::HTML(html)

    index.css("div.student-card").each do |student|
      student_info = {}
      student_info[:name] = student.css("h4.student-name").text
      student_info[:location] = student.css("p.student-location").text
      profile_url = student.css("a").attribute("href").value
      student_info[:profile_url] = './fixtures/student-site/' + profile_url
      students << student_info
    end
    students
    binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
