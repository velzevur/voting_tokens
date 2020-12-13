defmodule VotingTokens.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :is_used, :boolean, default: false, null: false

      timestamps()
    end

  end
end
