defmodule UrlShortener.Router do
  use Plug.Router
  use Plug.ErrorHandler
  import Plug.Conn
  import Http.Codes
  import Http.Scripts

  plug :match
  plug :dispatch
  plug Plug.Parsers,
       parsers: [:json],
       pass: ["application/json"], json_decoder: Jason

  get "/:url" do
    case Operations.Mongodb.get_link_url(url) do
      {:ok, link}   -> send_resp conn, ok(), redirect_script(link)
      {:error, err} -> response conn, not_found(), err
    end
  end

  post "/links" do
    {:ok, req_body, conn} = Plug.Conn.read_body conn, opts

    {result, body} = InsertLink.parse_body req_body
    IO.inspect {result, body}
    if result == :error do
      response conn, bad_request(), body

    else
      link_alias = body["alias"]
      {:ok, amount} = Operations.Mongodb.count_link_occurences link_alias
      unique_alias  = InsertLink.unique_link_alias link_alias, amount

      link = %{"alias" => "#{unique_alias}", "url" => body["url"]}
      {:ok, _} = Operations.Mongodb.insert_link link

      response conn, created(), Jason.encode!(link)
    end
  end

  match _ do
    response conn, not_found(), Http.Errors.resource_not_found()
  end

  def handle_errors(conn, _) do
    response conn, internal_server_error(), Http.Errors.internal_server_error()
  end

  def response(conn, code, message) do
    put_resp_content_type(conn, "application/json")
    |> send_resp(code, message)
  end
end
