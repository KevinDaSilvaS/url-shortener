defmodule UrlShortenerTest.Http.Codes do
  use ExUnit.Case
  doctest UrlShortener

  use ExUnitProperties

  describe "#ok" do
    property "should return http code number" do
      assert Http.Codes.ok() == 200
    end
  end

  describe "#created" do
    property "should return http code number" do
      assert Http.Codes.created() == 201
    end
  end

  describe "#bad_request" do
    property "should return http code number" do
      assert Http.Codes.bad_request() == 400
    end
  end

  describe "#not_found" do
    property "should return http code number" do
      assert Http.Codes.not_found() == 404
    end
  end

  describe "#internal_server_error" do
    property "should return http code number" do
      assert Http.Codes.internal_server_error() == 500
    end
  end
end
