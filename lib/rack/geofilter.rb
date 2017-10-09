module Rack
  class Geofilter

  def initialize app
    @app = app
  end

  def call env
    if should_block?(env)
      return error_message
    end

    @app.call(env)
  end

  private

  def filter_enabled?
    ENV.has_key?('BLOCKED_COUNTRIES')
  end

  def countries_blocked
    ENV['BLOCKED_COUNTRIES'].split(',')
  end

  def origin_country(env)
    env['HTTP_CF_IPCOUNTRY']
  end

  def request_tagged?(env)
    env.has_key?('HTTP_CF_IPCOUNTRY')
  end

  def should_block?(env)
    if filter_enabled? && request_tagged?(env)
      countries_blocked.include? origin_country(env)
    end
  end

  def error_message
    [451, {'Content-Type' => 'application/json'}, ["Service not available in country of origin\n"]]
  end

  end
end
