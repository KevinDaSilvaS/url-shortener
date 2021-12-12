defmodule Http.Errors do
  def field_not_set, do: Jason.encode! %{"error" => "Field(s) not properly set(alias and/or url)."}

  def resource_not_found, do: Jason.encode! %{"error" => "Resource not found."}

  def internal_server_error, do: Jason.encode! %{"error" => "An unexpected error has ocurred."}

  def link_not_found, do: Jason.encode! %{"error" => "Link doesnt exist."}
end
