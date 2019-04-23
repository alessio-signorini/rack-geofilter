module Rack
  class Geofilter

  BLOCKED_COUNTRIES_KEY = 'BLOCKED_COUNTRIES'
  CLOUDFLARE_IPCOUNTRY_KEY = 'HTTP_CF_IPCOUNTRY'

  def initialize app, country_string=nil
    @app = app
    setup_filter(ENV[BLOCKED_COUNTRIES_KEY] || country_string)
  end

  def call env
    if should_block?(env)
      return error_message
    end

    @app.call(env)
  end

  private

  def setup_filter country_string
    if !country_string.nil? && country_string != ""
      @blocked_countries = country_string.split(',').map(&:strip).uniq.compact
      @filter_enabled = @blocked_countries.count > 0
    end
  end

  def should_block?(env)
    return unless @filter_enabled

    @blocked_countries.include? env[CLOUDFLARE_IPCOUNTRY_KEY]
  end

  def error_message
    [451, {'Content-Type' => 'plain/text'}, ["Service not available in country of origin\n"]]
  end

  end
end
