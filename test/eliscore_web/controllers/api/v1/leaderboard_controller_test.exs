defmodule EliscoreWeb.LeaderboardControllerTest do
  use EliscoreWeb.ConnCase, async: true
  import Eliscore.Factory
  alias Eliscore.{Repo, User, GameMatch}

  test "index/2 responds with maps based on game matches won" do
    user1 = insert(:user, full_name: "John Wayne")
    user2 = insert(:user, full_name: "John Rambo")
    user3 = insert(:user, full_name: "John Travolta")

    matches = [
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user1.id,
          player1_score: 10,
          player2_id: user2.id,
          player2_score: 9
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user1.id,
          player1_score: 10,
          player2_id: user2.id,
          player2_score: 10
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user2.id,
          player1_score: 10,
          player2_id: user3.id,
          player2_score: 10
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user2.id,
          player1_score: 10,
          player2_id: user3.id,
          player2_score: 10
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user2.id,
          player1_score: 10,
          player2_id: user3.id,
          player2_score: 10
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user2.id,
          player1_score: 10,
          player2_id: user3.id,
          player2_score: 10
        }
      )]

    Enum.each(matches, &Repo.insert!(&1))

    response = build_conn()
               |> Eliscore.Guardian.Plug.sign_in(user1)
               |> get(leaderboard_path(build_conn(), :index))
               |> json_response(200)

    expected = %{
      "data" => [
        %{
          "full_name" => "John Rambo",
          "wins" => 0,
          "all_games" => 6,
          "loses" => 1,
          "draws" => 5,
          "points" => 5
        },
        %{
          "full_name" => "John Wayne",
          "wins" => 1,
          "all_games" => 2,
          "loses" => 0,
          "draws" => 1,
          "points" => 4
        },
        %{
          "full_name" => "John Travolta",
          "wins" => 0,
          "all_games" => 4,
          "loses" => 0,
          "draws" => 4,
          "points" => 4
        }
      ]
    }

    assert response == expected
  end
end
