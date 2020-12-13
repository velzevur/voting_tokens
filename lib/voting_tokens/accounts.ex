defmodule VotingTokens.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi
  alias VotingTokens.Repo

  alias VotingTokens.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def lookup_user(email) do
    Repo.get_by(User, email: email)
  end

  alias VotingTokens.Accounts.Token

  @doc """
  Returns the list of tokens.

  ## Examples

      iex> list_tokens()
      [%Token{}, ...]

  """
  def list_tokens do
    Repo.all(Token)
  end

  @doc """
  Gets a single token.

  Raises `Ecto.NoResultsError` if the Token does not exist.

  ## Examples

      iex> get_token!(123)
      %Token{}

      iex> get_token!(456)
      ** (Ecto.NoResultsError)

  """
  def get_token!(id), do: Repo.get!(Token, id)

  @doc """
  Creates a token.

  ## Examples

      iex> create_token(%{field: value})
      {:ok, %Token{}}

      iex> create_token(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_token(attrs \\ %{}) do
    %Token{}
    |> Token.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a token.

  ## Examples

      iex> update_token(token, %{field: new_value})
      {:ok, %Token{}}

      iex> update_token(token, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_token(%Token{} = token, attrs) do
    token
    |> Token.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a token.

  ## Examples

      iex> delete_token(token)
      {:ok, %Token{}}

      iex> delete_token(token)
      {:error, %Ecto.Changeset{}}

  """
  def delete_token(%Token{} = token) do
    Repo.delete(token)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking token changes.

  ## Examples

      iex> change_token(token)
      %Ecto.Changeset{data: %Token{}}

  """
  def change_token(%Token{} = token, attrs \\ %{}) do
    Token.changeset(token, attrs)
  end

  alias VotingTokens.Accounts.TokenGroup

  @doc """
  Returns the list of token_groups.

  ## Examples

      iex> list_token_groups()
      [%TokenGroup{}, ...]

  """
  def list_token_groups do
    Repo.all(TokenGroup)
    |> Repo.preload([:tokens])
  end

  @doc """
  Gets a single token_group.

  Raises `Ecto.NoResultsError` if the Token group does not exist.

  ## Examples

      iex> get_token_group!(123)
      %TokenGroup{}

      iex> get_token_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_token_group!(id), do: Repo.get!(TokenGroup, id)

  @doc """
  Creates a token_group.

  ## Examples

      iex> create_token_group(%{field: value})
      {:ok, %TokenGroup{}}

      iex> create_token_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_token_group(attrs \\ %{}) do
    %TokenGroup{}
    |> TokenGroup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a token_group.

  ## Examples

      iex> update_token_group(token_group, %{field: new_value})
      {:ok, %TokenGroup{}}

      iex> update_token_group(token_group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_token_group(%TokenGroup{} = token_group, attrs) do
    token_group
    |> TokenGroup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a token_group.

  ## Examples

      iex> delete_token_group(token_group)
      {:ok, %TokenGroup{}}

      iex> delete_token_group(token_group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_token_group(%TokenGroup{} = token_group) do
    Repo.delete(token_group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking token_group changes.

  ## Examples

      iex> change_token_group(token_group)
      %Ecto.Changeset{data: %TokenGroup{}}

  """
  def change_token_group(%TokenGroup{} = token_group, attrs \\ %{}) do
    TokenGroup.changeset(token_group, attrs)
  end
  
  defp get_available_groups() do
    fn repo, _ ->
      case  from(TokenGroup, where: [is_available: true], order_by: [desc: :id], preload: [:tokens])
            |> Repo.all() do
        [group1, group2] -> {:ok, {group1, group2}}
        _ -> {:error, :groups_issue}
      end
    end
  end

  defp pick_tokens() do
    fn repo, %{get_groups: {group1, group2}} ->
      pick =
        fn(%TokenGroup{tokens: tokens}) ->
          tokens
          |> Enum.filter(fn %Token{is_used: is_used} -> !is_used end)
          |> (fn unused ->
                case Enum.empty?(unused) do
                  true -> {:error, :no_tokens_left}
                  false ->
                    unused
                    |> Enum.random()
                    |> (fn token ->
                          token
                          |> Token.changeset(%{is_used: true})
                          |> Repo.update()
                          {:ok, token}
                      end).()
                end
              end).()
        end
      case {pick.(group1), pick.(group2)} do
        {{:ok, token1}, {:ok, token2}} ->
          {:ok, {token1, token2}}
        {{:error, err}, _} ->
          {:error, err}
      end
    end
  end

  def available_tokens() do
    res =
      Multi.new()
      |> Multi.run(:get_groups, get_available_groups())
      |> Multi.run(:pick_tokens, pick_tokens())
      |> Repo.transaction()
    case res do
      {:ok, %{pick_tokens: tokens}} -> {:ok, tokens}
      {:error, _, err, _} -> {:error, err}
    end
  end

  def toggle_token_group(id) do
    Multi.new()
    |> Multi.run(:toggle,
      fn repo, _ ->
        tk = repo.get!(TokenGroup, id)
        tk
        |> TokenGroup.changeset(%{is_available: !tk.is_available})
        |> repo.update()
      end )
    |> Repo.transaction()
  end

  def used_tokens() do
    res =
      Multi.new()
      |> Multi.run(:get_groups, get_available_groups())
      |> Multi.run(:list,
        fn repo, %{get_groups: {group1, group2}} ->
          process =
            fn group ->
              used = Enum.filter(group.tokens, fn t -> t.is_used end)
              {:ok, %{name: group.name, used: used}}
            end
          case {process.(group1), process.(group2)} do
            {{:ok, token1}, {:ok, token2}} ->
              {:ok, {token1, token2}}
            {{:error, err}, _} ->
              {:error, err}
          end
        end)
      |> Repo.transaction()

    case res do
      {:ok, %{list: tokens}} -> {:ok, tokens}
      {:error, _, err, _} -> {:error, err}
    end
  end


end
