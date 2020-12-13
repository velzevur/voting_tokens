defmodule VotingTokens.Accounts.TokenGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "token_groups" do
    field :is_available, :boolean, default: false
    field :name, :string
    has_many :tokens, VotingTokens.Accounts.Token, foreign_key: :group_id

    timestamps()
  end

  @doc false
  def changeset(token_group, attrs) do
    token_group
    |> cast(attrs, [:name, :is_available])
    |> validate_required([:name, :is_available])
  end
end
