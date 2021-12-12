defmodule InsertLink do
  def parse_body(req_body) do
    Jason.decode!(req_body) |> filter_fields()
  end

  @alias "alias"
  @url "url"
  def filter_fields(body) do
    case (Map.has_key?(body, @alias) && Map.has_key?(body, @url)) do
      false -> {:error, Http.Errors.field_not_set}
      true  -> {:ok, body}
    end
  end

  def unique_link_alias(link_alias, 0), do: link_alias
  def unique_link_alias(link_alias, amount), do: "#{link_alias}_#{amount}"
end
