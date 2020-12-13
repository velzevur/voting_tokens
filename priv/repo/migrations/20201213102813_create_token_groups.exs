defmodule VotingTokens.Repo.Migrations.CreateTokenGroups do
  use Ecto.Migration

  def change do
    create table(:token_groups) do
      add :name, :string
      add :is_available, :boolean, default: false, null: false

      timestamps()
    end

  end
end
