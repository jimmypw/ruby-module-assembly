#!/usr/bin/env ruby
$LOAD_PATH.unshift File.expand_path('../ext', __FILE__)

require 'bundler/setup'
require 'httparty'
require 'nokogiri'
require 'quantbet/quantbet'

response_raw = HTTParty.get("http://quantbet.com/quiz/dev")
response = Nokogiri::HTML(response_raw.body)

cookies = HTTParty::CookieHash.new
response_raw.get_fields('Set-Cookie').each do |c|
    cookies.add_cookies(c)
end

number1 = response.xpath('//form[@id="quiz"]/p/strong[1]/text()').to_s.to_i
number2 = response.xpath('//form[@id="quiz"]/p/strong[2]/text()').to_s.to_i
magic_number = Quantbet.new.find_highest_divisor(number1, number2) # zoooom

puts "Number 1 #{number1}"
puts "Number 2 #{number2}"
puts "Magic Number #{magic_number}"

result_raw = HTTParty.post("http://quantbet.com/submit",
    headers: {
        'Cookie': cookies.to_cookie_string
    },
    body: {'id': 'quiz', 'divisor': magic_number }
)

result = Nokogiri::HTML(result_raw.body)

puts result.xpath('//div[@class="quiz-content"]/div[1]/text()').to_s
