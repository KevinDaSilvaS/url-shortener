defmodule Operations.Mongodb do

  @collection "links"

  def insert_link(link_info) do
    Mongo.insert_one :mongo, @collection, link_info
  end

  def count_link_occurences(link_alias) do
    Mongo.count :mongo, @collection, %{"alias" => %{"$regex" => "#{link_alias}"}}
  end

  def get_link_url(link_alias) do
    result = Mongo.find_one :mongo, @collection, %{"alias" => "#{link_alias}"}
    case result do
      nil -> {:error, Http.Errors.link_not_found()}
      _   -> {:ok, result["url"]}
    end
  end
end
