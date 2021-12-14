defmodule UrlShortenerTest.Http.Scripts do
  use ExUnit.Case
  doctest UrlShortener

  use ExUnitProperties

  describe "#redirect_script" do
    @url "https://hex.pm/packages/"
    property "should return an html containing the redirect url" do
      assert Http.Scripts.redirect_script(@url) == "<script>window.location.href='#{@url}';</script>"
    end
  end
end
