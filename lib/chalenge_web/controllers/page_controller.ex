defmodule ChalengeWeb.PageController do
  use ChalengeWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  def reOrder(conn, _params) do
    json(conn, ChalengeWeb.TransformService.iterateBranch(_params, nil))
  end
end
