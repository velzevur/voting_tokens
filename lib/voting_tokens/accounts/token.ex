defmodule VotingTokens.Accounts.Token do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tokens" do
    field :group_id, :integer
    field :is_used, :boolean, default: false
    field :keyword, :string

    timestamps()
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:keyword, :is_used, :group_id])
    |> validate_required([:keyword, :is_used, :group_id])
  end
end
