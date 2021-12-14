defmodule UrlShortenerTest.RouteFunctions.InsertLink do
  use ExUnit.Case
  doctest UrlShortener

  use ExUnitProperties

  describe "#filter_fields" do
    @body %{"alias" => "alias", "url" => "https://hex.pm/packages/"}

    property "should return {:ok, body} when alias and url are set" do
      assert InsertLink.filter_fields(@body) == {:ok, @body}
    end

    property "should return {:error, error} when url is not set" do
      assert InsertLink.filter_fields(%{"alias" => @body["alias"]}) == {:error, Http.Errors.field_not_set}
    end

    property "should return {:error, error} when alias is not set" do
      assert InsertLink.filter_fields(%{"url" => @body["url"]}) == {:error, Http.Errors.field_not_set}
    end
  end

  describe "prop test #unique_link_alias" do
    @alias "alias"

    property "should return alias_amount when amount is greater than zero" do
      check all(count <- integer(1..100000)) do
        assert InsertLink.unique_link_alias(@alias, count) == "#{@alias}_#{count}"
      end
    end

    property "should return alias_amount when amount is less than zero" do
      check all(count <- integer(100000..-1)) do
        assert InsertLink.unique_link_alias(@alias, count) == "#{@alias}_#{count}"
      end
    end

    property "should return alias when amount is equal zero" do
      assert InsertLink.unique_link_alias(@alias, 0) == @alias
    end
  end

  describe "#parse_body" do
    @body "{ \"alias\": \"alias\", \"url\": \"url\"}"

    property "should return {:ok, body} when alias @body is a valid json" do
      assert InsertLink.parse_body(@body) == {:ok, %{"alias" => "alias", "url" => "url"}}
    end

    @body "{ \"alias: \"alias\", \"url\": \"url\"}"
    property "should return an exception when alias @body is not a valid json" do
      assert_raise Jason.DecodeError, fn -> InsertLink.parse_body(@body) end
    end
  end
end
