defmodule VotingTokensWeb.PageController do
  use VotingTokensWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
