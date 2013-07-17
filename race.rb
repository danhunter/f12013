require 'rubygems'
require 'sinatra'
require 'time'

class Race
  
  attr_accessor :location, :name, :image, :date, :pretty_date, :fastest_lap, :fastest_driver
  
  def initialize(data, time_now)
    
    @location = (data[:shortened].nil?) ? data[:location] : data[:shortened]
    @location.upcase!
    
    @name = "#{data[:location]} (#{data[:circuit]})".upcase! unless data[:circuit].nil?
    
    @date = data[:date]
    parsed_date = Time.parse(data[:date])
    @pretty_date = parsed_date.strftime("%d %b")
    
    @image = data[:image].nil? ? "unknown" : data[:image] 
    
    @fastest_lap = data[:lap].to_f * 1000
    @fastest_driver = data[:driver]
    
    @race_started = parsed_date < time_now ? true : false
  end
  
  def should_be_shown?
    return true #!@race_started
  end
end