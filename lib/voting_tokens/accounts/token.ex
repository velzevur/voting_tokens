defmodule VotingTokens.Accounts.Token do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tokens" do
    field :group, :integer
    field :is_used, :boolean, default: false
    field :keyword, :string

    timestamps()
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:keyword, :is_used, :group])
    |> validate_required([:keyword, :is_used, :group])
  end
end
