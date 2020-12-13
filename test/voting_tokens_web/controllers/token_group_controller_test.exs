defmodule VotingTokensWeb.TokenGroupControllerTest do
  use VotingTokensWeb.ConnCase

  alias VotingTokens.Accounts

  @create_attrs %{is_available: true, name: "some name"}
  @update_attrs %{is_available: false, name: "some updated name"}
  @invalid_attrs %{is_available: nil, name: nil}

  def fixture(:token_group) do
    {:ok, token_group} = Accounts.create_token_group(@create_attrs)
    token_group
  end

  describe "index" do
    test "lists all token_groups", %{conn: conn} do
      conn = get(conn, Routes.token_group_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Token groups"
    end
  end

  describe "new token_group" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.token_group_path(conn, :new))
      assert html_response(conn, 200) =~ "New Token group"
    end
  end

  describe "create token_group" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.token_group_path(conn, :create), token_group: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.token_group_path(conn, :show, id)

      conn = get(conn, Routes.token_group_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Token group"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.token_group_path(conn, :create), token_group: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Token group"
    end
  end

  describe "edit token_group" do
    setup [:create_token_group]

    test "renders form for editing chosen token_group", %{conn: conn, token_group: token_group} do
      conn = get(conn, Routes.token_group_path(conn, :edit, token_group))
      assert html_response(conn, 200) =~ "Edit Token group"
    end
  end

  describe "update token_group" do
    setup [:create_token_group]

    test "redirects when data is valid", %{conn: conn, token_group: token_group} do
      conn = put(conn, Routes.token_group_path(conn, :update, token_group), token_group: @update_attrs)
      assert redirected_to(conn) == Routes.token_group_path(conn, :show, token_group)

      conn = get(conn, Routes.token_group_path(conn, :show, token_group))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, token_group: token_group} do
      conn = put(conn, Routes.token_group_path(conn, :update, token_group), token_group: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Token group"
    end
  end

  describe "delete token_group" do
    setup [:create_token_group]

    test "deletes chosen token_group", %{conn: conn, token_group: token_group} do
      conn = delete(conn, Routes.token_group_path(conn, :delete, token_group))
      assert redirected_to(conn) == Routes.token_group_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.token_group_path(conn, :show, token_group))
      end
    end
  end

  defp create_token_group(_) do
    token_group = fixture(:token_group)
    %{token_group: token_group}
  end
end
