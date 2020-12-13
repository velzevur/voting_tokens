# VotingTokens

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Setup PostresSQL with corresponding user, password and db in the
    corresponding config (ex. [dev.exs](config/dev.exs))
  * Setup and populate the database with `mix ecto.reset`. This fills all the
    allowed emails and provided tokens. Those could be edited from the
    [seeds.exs](priv/repo/seeds.exs)
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Providing tokens

Users visit `http://localhost:4000/claim` and fill their email. They receive a
set of tokens they could use to vote.

All claimed tokens could be fetched from `http://localhost:4000/claimed`. This
is how every user can make sure their token is registereded.

