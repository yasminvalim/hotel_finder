# frozen_string_literal: true

require_relative "hotel_finder/version"

require 'uri'
require 'net/http'

module HotelFinder
  class Finder
    BOOKING_URL_BASE = 'https://www.booking.com'.freeze
    HOLIDAYCHECK_URL_BASE = 'https://www.holidaycheck.de'.freeze
    TRIPADVISOR_URL_BASE = 'http://www.tripadvisor.com'.freeze

    def initialize(hotel_name)
      @hotel_name = hotel_name
    end

    def match
      urls = {}
      urls[:booking] = booking_url
      urls[:holidaycheck] = holidaycheck_url
      urls[:tripadvisor] = tripadvisor_url
    
      urls
    end

    private

    def tripadvisor_url
      "#{TRIPADVISOR_URL_BASE}/Search?q=#{URI.encode_www_form_component(@hotel_name)}"
    end

    def booking_url
      "#{BOOKING_URL_BASE}/searchresults.html?ss=#{URI.encode_www_form_component(@hotel_name)}"
    end

    def holidaycheck_url
      "#{HOLIDAYCHECK_URL_BASE}/search?hotel=#{URI.encode_www_form_component(@hotel_name)}"
    end
  end
end