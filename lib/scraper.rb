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
      student_info[:profile_url] = student.css("a").attribute("href").value
      students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_info = {}
    html = open(profile_url)
    profile = Nokogiri::HTML(html)

    profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_info[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_info[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_info[:github] = social.attribute("href").value
      else
        student_info[:blog] = social.attribute("href").value
      end
    end

    student_info[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    student_info[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text
    
    student_info
  end
end
