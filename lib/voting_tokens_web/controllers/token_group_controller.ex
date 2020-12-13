defmodule VotingTokensWeb.TokenGroupController do
  use VotingTokensWeb, :controller

  alias VotingTokens.Accounts
  alias VotingTokens.Accounts.TokenGroup

  def index(conn, _params) do
    token_groups =
      Accounts.list_token_groups()
      |> Enum.sort()
    render(conn, "index.html", token_groups: token_groups)
  end

  def new(conn, _params) do
    changeset = Accounts.change_token_group(%TokenGroup{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"token_group" => token_group_params}) do
    case Accounts.create_token_group(token_group_params) do
      {:ok, token_group} ->
        conn
        |> put_flash(:info, "Token group created successfully.")
        |> redirect(to: Routes.token_group_path(conn, :show, token_group))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    token_group = Accounts.get_token_group!(id)
    render(conn, "show.html", token_group: token_group)
  end

  def edit(conn, %{"id" => id}) do
    token_group = Accounts.get_token_group!(id)
    changeset = Accounts.change_token_group(token_group)
    render(conn, "edit.html", token_group: token_group, changeset: changeset)
  end

  def update(conn, %{"id" => id, "token_group" => token_group_params}) do
    token_group = Accounts.get_token_group!(id)

    case Accounts.update_token_group(token_group, token_group_params) do
      {:ok, token_group} ->
        conn
        |> put_flash(:info, "Token group updated successfully.")
        |> redirect(to: Routes.token_group_path(conn, :show, token_group))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", token_group: token_group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    token_group = Accounts.get_token_group!(id)
    {:ok, _token_group} = Accounts.delete_token_group(token_group)

    conn
    |> put_flash(:info, "Token group deleted successfully.")
    |> redirect(to: Routes.token_group_path(conn, :index))
  end

  def toggle(conn, %{"id" => id}) do
    Accounts.toggle_token_group(id)
    conn
    |> redirect(to: Routes.token_group_path(conn, :index))
  end
end
