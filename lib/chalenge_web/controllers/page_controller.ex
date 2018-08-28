defmodule ChalengeWeb.PageController do
  use ChalengeWeb, :controller

  def index(conn, _params) do
    list = Chalenge.GithubService.list("elixir")
    repos = Enum.chunk_every(list, 10)
    render conn, "index.html", repos: hd repos
  end

  def listGithub(conn, _params) do
    json conn, Chalenge.GithubService.list("elixir")
  end

  def reOrder(conn, params) do
    json conn, Chalenge.TransformService.iterateBranch(params, nil)
  end
end
