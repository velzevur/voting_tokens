defmodule VotingTokens.Repo do
  use Ecto.Repo,
    otp_app: :voting_tokens,
    adapter: Ecto.Adapters.Postgres
end
