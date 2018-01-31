defmodule EliscoreWeb.LeaderboardControllerTest do
  use EliscoreWeb.ConnCase, async: true
  alias Eliscore.{Repo, User, GameMatch}

  test "index/2 responds with maps based on game matches won" do
    users = [
      User.changeset(
        %User{},%{
          full_name: "John Doe",
          first_name: "John",
          last_name: "Doe",
          image_url: "image/url",
          uuid: "11111111",
          email: "test1@test.test",
          password: "password"
        }),
      User.changeset(
        %User{},%{
          full_name: "Dohn Joe",
          first_name: "Dohn",
          last_name: "Joe",
          image_url: "image/url",
          uuid: "11111111",
          email: "test2@test.test",
          password: "password"
        })]

    Enum.each(users, &Repo.insert!(&1))
    user_1 = Repo.get_by(User, first_name: "John")
    user_2 = Repo.get_by(User, first_name: "Dohn")

    matches = [
      GameMatch.changeset(
        %GameMatch{},%{player1_id: user_1.id, player1_score: 10, player2_id: user_2.id, player2_score: 9}
      ),
      GameMatch.changeset(
        %GameMatch{},%{player1_id: user_1.id, player1_score: 10, player2_id: user_2.id, player2_score: 11}
      ),
      GameMatch.changeset(
        %GameMatch{},%{player1_id: user_1.id, player1_score: 11, player2_id: user_2.id, player2_score: 10}
      )]
    Enum.each(matches, &Repo.insert!(&1))

    response = build_conn()
               |> get(leaderboard_path(build_conn(), :index))
               |> json_response(200)

    expected = %{
      "data" => [
        %{"full_name" => "John Doe", "wins" => 2},
        %{"full_name" => "Dohn Joe", "wins" => 1},
      ]
    }

    assert response == expected
  end
end
