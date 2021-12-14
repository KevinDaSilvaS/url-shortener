defmodule UrlShortenerTest.Http.Errors do
  use ExUnit.Case
  doctest UrlShortener

  use ExUnitProperties

  describe "#field_not_set" do
    property "should return {\"error\":\"error_message\"} json" do
      assert Http.Errors.field_not_set() == "{\"error\":\"Field(s) not properly set(alias and/or url).\"}"
    end
  end

  describe "#resource_not_found" do
    property "should return {\"error\": \"error_message\"} json" do
      assert Http.Errors.resource_not_found() == "{\"error\":\"Resource not found.\"}"
    end
  end

  describe "#internal_server_error" do
    property "should return {\"error\": \"error_message\"} json" do
      assert Http.Errors.internal_server_error() == "{\"error\":\"An unexpected error has ocurred.\"}"
    end
  end

  describe "#link_not_found" do
    property "should return {\"error\": \"error_message\"} json" do
      assert Http.Errors.link_not_found() == "{\"error\":\"Link doesnt exist.\"}"
    end
  end
end
