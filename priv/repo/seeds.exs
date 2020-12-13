# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     VotingTokens.Repo.insert!(%VotingTokens.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias VotingTokens.Accounts.{Token,User}
alias VotingTokens.Repo

Enum.each(
  [ "john@doe.com" , "jane@doe.com" ],
  fn e -> %User{email: e} |> Repo.insert! end)

european_countries =
  [ "Франция",
    "Германия" ]

Enum.each(european_countries,
  fn k -> %Token{keyword: k, group: 1} |> Repo.insert! end)
