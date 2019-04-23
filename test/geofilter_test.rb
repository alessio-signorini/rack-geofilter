require "test_helper"

class GeofilterTest < Minitest::Test

  def setup
    ENV["BLOCKED_COUNTRIES"] = nil

    @app = mock()
  end

  def test_no_arg_or_env_and_not_tagged


    @app.expects(:call).once

    geofilter = Rack::Geofilter.new @app

    geofilter.call({})

  end

  def test_with_arg_but_no_env_with_request_from_banned_country

    @app.expects(:call).never

    geofilter = Rack::Geofilter.new @app, "RU,JP"

    geofilter.call({"HTTP_CF_IPCOUNTRY" => "RU"})

  end

  def test_with_env_but_no_arg_with_request_from_banned_country

    ENV["BLOCKED_COUNTRIES"] = "KR"

    @app.expects(:call).never

    geofilter = Rack::Geofilter.new @app

    geofilter.call({"HTTP_CF_IPCOUNTRY" => "KR"})

  end

  def test_with_arg_and_env_with_request_from_banned_country

    ENV["BLOCKED_COUNTRIES"] = "KR"

    @app.expects(:call).never

    geofilter = Rack::Geofilter.new @app, "RU,JP"

    geofilter.call({"HTTP_CF_IPCOUNTRY" => "KR"})

  end

  def test_with_arg_and_env_with_request_from_other_banned_country

    ENV["BLOCKED_COUNTRIES"] = "KR"

    @app.expects(:call).once

    geofilter = Rack::Geofilter.new @app, "RU,JP"

    geofilter.call({"HTTP_CF_IPCOUNTRY" => "RU"})

  end


  def test_with_arg_but_no_env_with_request_from_ok_country

    @app.expects(:call).once

    geofilter = Rack::Geofilter.new @app, "RU,JP"

    geofilter.call({"HTTP_CF_IPCOUNTRY" => "US"})

  end

  def test_with_env_but_no_arg_with_request_from_ok_country

    ENV["BLOCKED_COUNTRIES"] = "KR"

    @app.expects(:call).once

    geofilter = Rack::Geofilter.new @app

    geofilter.call({"HTTP_CF_IPCOUNTRY" => "US"})

  end

  def test_with_arg_and_env_with_request_from_ok_country

    ENV["BLOCKED_COUNTRIES"] = "KR"

    @app.expects(:call).once

    geofilter = Rack::Geofilter.new @app, "RU,JP"

    geofilter.call({"HTTP_CF_IPCOUNTRY" => "US"})

  end

end