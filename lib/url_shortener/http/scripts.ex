defmodule Http.Scripts do
  def redirect_script(url) do
    "<script>window.location.href='#{url}';</script>"
  end
end
