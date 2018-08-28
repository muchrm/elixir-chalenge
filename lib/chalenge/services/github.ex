defmodule Chalenge.GithubService do
  @list []
  def list(keyword) do
    if length(@list) == 0 do
      url = "https://api.github.com/search/repositories?q=#{keyword}&per_page=100"
      response = HTTPoison.get!(url)
      req = Poison.decode!(response.body)
      req["items"]
    else
      @list
    end
  end
end
