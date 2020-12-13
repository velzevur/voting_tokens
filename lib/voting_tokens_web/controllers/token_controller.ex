defmodule VotingTokensWeb.TokenController do
  use VotingTokensWeb, :controller

  alias VotingTokens.Accounts
  alias VotingTokens.Accounts.{User,Token}

  def index(conn, _params) do
    tokens = Accounts.list_tokens()
    render(conn, "index.html", tokens: tokens)
  end

  def new(conn, _params) do
    changeset = Accounts.change_token(%Token{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"token" => token_params}) do
    case Accounts.create_token(token_params) do
      {:ok, token} ->
        conn
        |> put_flash(:info, "Token created successfully.")
        |> redirect(to: Routes.token_path(conn, :show, token))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    token = Accounts.get_token!(id)
    render(conn, "show.html", token: token)
  end

  def edit(conn, %{"id" => id}) do
    token = Accounts.get_token!(id)
    changeset = Accounts.change_token(token)
    render(conn, "edit.html", token: token, changeset: changeset)
  end

  def update(conn, %{"id" => id, "token" => token_params}) do
    token = Accounts.get_token!(id)

    case Accounts.update_token(token, token_params) do
      {:ok, token} ->
        conn
        |> put_flash(:info, "Token updated successfully.")
        |> redirect(to: Routes.token_path(conn, :show, token))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", token: token, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    token = Accounts.get_token!(id)
    {:ok, _token} = Accounts.delete_token(token)

    conn
    |> put_flash(:info, "Token deleted successfully.")
    |> redirect(to: Routes.token_path(conn, :index))
  end

  def register(conn, _params) do
    changeset = Accounts.change_token(%Token{})
    render(conn, "register.html", changeset: changeset)
  end

  def claim(conn, %{"form" => %{"email" => email}}) do
    case Accounts.lookup_user(email) do
      nil ->
        render(conn, "claim.html", error: "not_found")
      %User{is_used: true} ->
        render(conn, "claim.html", error: "already_used")
      user ->
        case Accounts.available_tokens() do
          {:ok, {token1, token2}} ->
            Accounts.update_user(user, %{is_used: true})
            render(conn, "claim.html", tokens: [token1, token2])
          {:error, err} ->
            render(conn, "claim.html", error: err)
        end
    end
  end

  def claimed(conn, _) do
    {:ok, {used1, used2}} = Accounts.used_tokens()
    render(conn, "claimed.html", used: [used1, used2])
  end

end
