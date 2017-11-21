defmodule EliscoreWeb.MatchControllerTest do
  use EliscoreWeb.ConnCase, async: true
  alias Eliscore.{Repo, User, GameMatch}

  test "index/2 responds with all GameMatches" do
    users = [ User.changeset(%User{},%{login: "Test1", email: "test1@test.test", password: "password"}),
              User.changeset(%User{},%{login: "Test2", email: "test2@test.test", password: "password"})]
    Enum.each(users, &Repo.insert!(&1))
    user_1 = Repo.get_by(User, login: "Test1")
    user_2 = Repo.get_by(User, login: "Test2")

    matches = [ GameMatch.changeset(%GameMatch{},%{player1_id: user_1.id, player1_score: 10, player2_id: user_2.id, player2_score: 9}),
              GameMatch.changeset(%GameMatch{},%{player1_id: user_1.id, player1_score: 0, player2_id: user_2.id, player2_score: 10})]
    Enum.each(matches, &Repo.insert!(&1))
    match_1 = Repo.get_by(GameMatch, player1_score: 10)
    match_2 = Repo.get_by(GameMatch, player1_score: 0)

    response = build_conn()
               |> get(match_path(build_conn(), :index))
               |> json_response(200)

    expected = %{
      "data" => [
        %{
          "accepted" => false, 
          "id" => match_1.id, 
          "player1_score" => match_1.player1_score, 
          "player2_score" => match_1.player2_score, 
          "player1" => %{"id" => user_1.id, "login" => user_1.login, "email" => user_1.email},
          "player2" => %{"id" => user_2.id, "login" => user_2.login, "email" => user_2.email}
        },
        %{
          "accepted" => false, 
          "id" => match_2.id, 
          "player1_score" => match_2.player1_score, 
          "player2_score" => match_2.player2_score, 
          "player1" => %{"id" => user_1.id, "login" => user_1.login, "email" => user_1.email},
          "player2" => %{"id" => user_2.id, "login" => user_2.login, "email" => user_2.email}
        }
      ]
    }

    assert response == expected
  end
end
