defmodule VotingTokens.AccountsTest do
  use VotingTokens.DataCase

  alias VotingTokens.Accounts

  describe "users" do
    alias VotingTokens.Accounts.User

    @valid_attrs %{email: "some email", is_used: true}
    @update_attrs %{email: "some updated email", is_used: false}
    @invalid_attrs %{email: nil, is_used: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.is_used == true
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.is_used == false
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "tokens" do
    alias VotingTokens.Accounts.Token

    @valid_attrs %{group: 42, is_used: true, keyword: "some keyword"}
    @update_attrs %{group: 43, is_used: false, keyword: "some updated keyword"}
    @invalid_attrs %{group: nil, is_used: nil, keyword: nil}

    def token_fixture(attrs \\ %{}) do
      {:ok, token} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_token()

      token
    end

    test "list_tokens/0 returns all tokens" do
      token = token_fixture()
      assert Accounts.list_tokens() == [token]
    end

    test "get_token!/1 returns the token with given id" do
      token = token_fixture()
      assert Accounts.get_token!(token.id) == token
    end

    test "create_token/1 with valid data creates a token" do
      assert {:ok, %Token{} = token} = Accounts.create_token(@valid_attrs)
      assert token.group == 42
      assert token.is_used == true
      assert token.keyword == "some keyword"
    end

    test "create_token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_token(@invalid_attrs)
    end

    test "update_token/2 with valid data updates the token" do
      token = token_fixture()
      assert {:ok, %Token{} = token} = Accounts.update_token(token, @update_attrs)
      assert token.group == 43
      assert token.is_used == false
      assert token.keyword == "some updated keyword"
    end

    test "update_token/2 with invalid data returns error changeset" do
      token = token_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_token(token, @invalid_attrs)
      assert token == Accounts.get_token!(token.id)
    end

    test "delete_token/1 deletes the token" do
      token = token_fixture()
      assert {:ok, %Token{}} = Accounts.delete_token(token)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_token!(token.id) end
    end

    test "change_token/1 returns a token changeset" do
      token = token_fixture()
      assert %Ecto.Changeset{} = Accounts.change_token(token)
    end
  end

  describe "token_groups" do
    alias VotingTokens.Accounts.TokenGroup

    @valid_attrs %{is_available: true, name: "some name"}
    @update_attrs %{is_available: false, name: "some updated name"}
    @invalid_attrs %{is_available: nil, name: nil}

    def token_group_fixture(attrs \\ %{}) do
      {:ok, token_group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_token_group()

      token_group
    end

    test "list_token_groups/0 returns all token_groups" do
      token_group = token_group_fixture()
      assert Accounts.list_token_groups() == [token_group]
    end

    test "get_token_group!/1 returns the token_group with given id" do
      token_group = token_group_fixture()
      assert Accounts.get_token_group!(token_group.id) == token_group
    end

    test "create_token_group/1 with valid data creates a token_group" do
      assert {:ok, %TokenGroup{} = token_group} = Accounts.create_token_group(@valid_attrs)
      assert token_group.is_available == true
      assert token_group.name == "some name"
    end

    test "create_token_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_token_group(@invalid_attrs)
    end

    test "update_token_group/2 with valid data updates the token_group" do
      token_group = token_group_fixture()
      assert {:ok, %TokenGroup{} = token_group} = Accounts.update_token_group(token_group, @update_attrs)
      assert token_group.is_available == false
      assert token_group.name == "some updated name"
    end

    test "update_token_group/2 with invalid data returns error changeset" do
      token_group = token_group_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_token_group(token_group, @invalid_attrs)
      assert token_group == Accounts.get_token_group!(token_group.id)
    end

    test "delete_token_group/1 deletes the token_group" do
      token_group = token_group_fixture()
      assert {:ok, %TokenGroup{}} = Accounts.delete_token_group(token_group)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_token_group!(token_group.id) end
    end

    test "change_token_group/1 returns a token_group changeset" do
      token_group = token_group_fixture()
      assert %Ecto.Changeset{} = Accounts.change_token_group(token_group)
    end
  end
end
