module Rack
  class Geofilter

  BLOCKED_COUNTRIES_KEY = 'BLOCKED_COUNTRIES'.freeze
  CLOUDFLARE_IPCOUNTRY_KEY = 'HTTP_CF_IPCOUNTRY'.freeze

  def initialize app, country_string=nil
    @app = app

    setup_blocked_countries(ENV[BLOCKED_COUNTRIES_KEY] || country_string)
    @filter_enabled = @blocked_countries.count > 0
  end

  def call request
    if should_block?(request)
      return error_message
    end

    @app.call(request)
  end

  private

  def setup_blocked_countries country_string

    if !country_string.nil? && country_string != ""
      @blocked_countries = Hash[country_string.downcase.split(',').map(&:strip).uniq.compact.collect{|c| [c, true]} ].freeze
    else
      @blocked_countries = {}.freeze
    end
  end

  def should_block?(request)
    return false unless @filter_enabled
    return false unless request[CLOUDFLARE_IPCOUNTRY_KEY]

    @blocked_countries.key?(request[CLOUDFLARE_IPCOUNTRY_KEY].strip.downcase)
  end

  def error_message
    [451, {'Content-Type' => 'plain/text'}, ["Service not available in country of origin\n"]]
  end

  end
end
