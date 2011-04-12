# coding: utf-8

require 'bigdecimal'
require 'cgi'
require 'singleton'
require 'roxml'
require 'andand'

module ONIX
  module Version #:nodoc:
    Major = 0
    Minor = 8
    Tiny  = 6

    String = [Major, Minor, Tiny].join('.')
  end

  class Formatters
    def self.decimal
      lambda do |val|
        if val.nil?
          nil
        elsif val.kind_of?(BigDecimal)
          val.to_s("F")
        else
          val.to_s
        end
      end
    end

    def self.yyyymmdd
      lambda do |val|
        if val.nil? || !val.respond_to?(:strftime)
          nil
        else
          val.strftime("%Y%m%d")
        end
      end
    end

    def self.two_digit
      lambda do |val|
        if val.nil?
          nil
        elsif val < 10
          "0#{val}"
        elsif val > 99
          val.to_s[-2,2]
        else
          val.to_s
        end
      end
    end

    def self.space_separated
      lambda { |val| val.join(" ")  if val }
    end
  end
end


# Ordering is important here; classes need to be defined before any
# other class can use them.
[
  # core files
  "core/element",
  "core/lists",
  "core/code",

  # element mappings
  "elements/sender_identifier",
  "elements/addressee_identifier",
  "elements/product_identifier",
  "elements/series_identifier",
  "elements/series",
  "elements/title",
  "elements/website",
  "elements/contributor",
  "elements/language",
  "elements/subject",
  "elements/audience_range",
  "elements/imprint",
  "elements/publisher",
  "elements/other_text",
  "elements/media_file",
  "elements/sales_restriction",
  "elements/sales_rights",
  "elements/not_for_sale",
  "elements/stock",
  "elements/price",
  "elements/supply_detail",
  "elements/market_representation",
  "elements/measure",
  "elements/product",

  # more core files
  "core/header",
  "core/reader",
  "core/writer",

  # product wrappers
  "wrappers/simple_product",
  "wrappers/apa_product",

  # utilities
  "utils/normaliser",
  "utils/code_list_extractor"
].each do |req|
  #require File.join("onix", req)
  require File.join(File.dirname(__FILE__), "onix", req)
end
