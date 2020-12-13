defmodule VotingTokens.Repo.Migrations.AddGroupId do
  use Ecto.Migration

  def change do
      alter table("tokens") do
        remove :group
        add :group_id, references(:token_groups)
    end

  end
end
