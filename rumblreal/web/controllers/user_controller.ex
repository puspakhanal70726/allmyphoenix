defmodule Rumbl.UserController do
  alias Rumbl.User
  use Rumbl.Web, :controller

  def index(conn, _params) do
    users = Repo.all(Rumbl.User)
    render conn, "index.html", users: users
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    {:ok, user} = Repo.insert(changeset)
    conn
    |> put_flash(:info, "#{user.name} created!") |> redirect(to: user_path(conn, :index))
end
end
