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
      search_url = "#{TRIPADVISOR_URL_BASE}/Search?q=#{URI.encode_www_form_component(@hotel_name)}"
      response = Net::HTTP.get(URI(search_url))

      first_result = response.match(%r{<a href="(/Hotel_Review[^"]+)"})
      return nil unless first_result && first_result[1]

      "#{TRIPADVISOR_URL_BASE}#{first_result[1]}"
    end

    def booking_url
      search_url = "#{BOOKING_URL_BASE}/searchresults.html?ss=#{URI.encode_www_form_component(@hotel_name)}"
      response = Net::HTTP.get(URI(search_url))

      first_result = response.match(%r{<a href="(/hotel[^"]+)"})
      return nil unless first_result && first_result[1]

      "#{BOOKING_URL_BASE}#{first_result[1]}"
    end

    def holidaycheck_url
      search_url = "#{HOLIDAYCHECK_URL_BASE}/search?hotel=#{URI.encode_www_form_component(@hotel_name)}"
      response = Net::HTTP.get(URI(search_url))

      first_result = response.match(%r{<a href="(/hi[^"]+)"})
      return nil unless first_result && first_result[1]

      "#{HOLIDAYCHECK_URL_BASE}#{first_result[1]}"
    end
  end
end