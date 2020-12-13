defmodule VotingTokens.Repo.Migrations.CreateTokens do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :keyword, :string, unique: true
      add :is_used, :boolean, default: false, null: false
      add :group, :integer

      timestamps()
    end

  end
end
