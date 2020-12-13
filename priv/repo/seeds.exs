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


alias VotingTokens.Accounts.{Token,User,TokenGroup}
alias VotingTokens.Repo

Enum.each(
  [ "joe@doe.com" , "jane@doe.com" ],
  fn e -> %User{email: e} |> Repo.insert! end)



[{"Държави в Европа",
    [ "Франция",
      "Германия" ], false},
  {"Гръцки богове",
    ["Зевс",
     "Аполон",
     "Хермес",
     "Афродита",
     "Диана"], true},
  {"Реки",
    ["Нил",
     "Амазонка",
     "Дунав",
     "Искър",
     "Велека"], true}
]
|> Enum.each(
  fn {group_name, keys, is_available} ->
    group = Repo.insert!(%TokenGroup{name: group_name, is_available: is_available})
    Enum.each(keys,
      fn k -> %Token{keyword: k, group_id: group.id} |> Repo.insert! end)
  end)
