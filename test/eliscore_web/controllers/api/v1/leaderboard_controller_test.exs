defmodule EliscoreWeb.LeaderboardControllerTest do
  use EliscoreWeb.ConnCase, async: true
  alias Eliscore.{Model.Category, Repo, User, GameMatch}

  test "fifa/2 responds with maps based on game matches won" do
    category = Category.changeset(%Category{}, %{name: "fifa"})
    |> Repo.insert!

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
          full_name: "Joe Dohn",
          first_name: "Joe",
          last_name: "Dohn",
          image_url: "image/url",
          uuid: "11111111",
          email: "test2@test.test",
          password: "password"
        }),
      User.changeset(
        %User{},%{
          full_name: "Dohn Joe",
          first_name: "Dohn",
          last_name: "Joe",
          image_url: "image/url",
          uuid: "11111111",
          email: "test3@test.test",
          password: "password"
        })]

    Enum.each(users, &Repo.insert!(&1))
    user_1 = Repo.get_by(User, first_name: "John")
    user_2 = Repo.get_by(User, first_name: "Dohn")
    user_3 = Repo.get_by(User, first_name: "Joe")

    matches = [
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user_1.id,
          player1_score: 10,
          player2_id: user_2.id,
          player2_score: 9,
          category_id: category.id
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user_1.id,
          player1_score: 10,
          player2_id: user_2.id,
          player2_score: 10,
          category_id: category.id
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user_2.id,
          player1_score: 10,
          player2_id: user_3.id,
          player2_score: 10,
          category_id: category.id
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user_2.id,
          player1_score: 10,
          player2_id: user_3.id,
          player2_score: 10,
          category_id: category.id
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user_2.id,
          player1_score: 10,
          player2_id: user_3.id,
          player2_score: 10,
          category_id: category.id
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user_2.id,
          player1_score: 10,
          player2_id: user_3.id,
          player2_score: 10,
          category_id: category.id
        }
      )]

    Enum.each(matches, &Repo.insert!(&1))

    response = build_conn()
               |> get(leaderboard_path(build_conn(), :fifa))
               |> json_response(200)

    expected = %{
      "data" => [
        %{
          "full_name" => "Dohn Joe",
          "wins" => 0,
          "all_games" => 6,
          "loses" => 1,
          "draws" => 5,
          "points" => 5
        },
        %{
          "full_name" => "John Doe",
          "wins" => 1,
          "all_games" => 2,
          "loses" => 0,
          "draws" => 1,
          "points" => 4
        },
        %{
          "full_name" => "Joe Dohn",
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

  test "fusball/2 responds with maps based on game matches won" do
    category = Category.changeset(%Category{}, %{name: "fusball"})
    |> Repo.insert!

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
          full_name: "Joe Dohn",
          first_name: "Joe",
          last_name: "Dohn",
          image_url: "image/url",
          uuid: "11111111",
          email: "test2@test.test",
          password: "password"
        }),
      User.changeset(
        %User{},%{
          full_name: "Dohn Joe",
          first_name: "Dohn",
          last_name: "Joe",
          image_url: "image/url",
          uuid: "11111111",
          email: "test3@test.test",
          password: "password"
        })]

    Enum.each(users, &Repo.insert!(&1))
    user_1 = Repo.get_by(User, first_name: "John")
    user_2 = Repo.get_by(User, first_name: "Dohn")
    user_3 = Repo.get_by(User, first_name: "Joe")

    matches = [
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user_1.id,
          player1_score: 10,
          player2_id: user_2.id,
          player2_score: 9,
          category_id: category.id
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user_1.id,
          player1_score: 10,
          player2_id: user_2.id,
          player2_score: 0,
          category_id: category.id
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user_2.id,
          player1_score: 0,
          player2_id: user_3.id,
          player2_score: 10,
          category_id: category.id
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user_2.id,
          player1_score: 0,
          player2_id: user_3.id,
          player2_score: 10,
          category_id: category.id
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user_2.id,
          player1_score: 0,
          player2_id: user_3.id,
          player2_score: 10,
          category_id: category.id
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user_2.id,
          player1_score: 10,
          player2_id: user_3.id,
          player2_score: 0,
          category_id: category.id
        }
      )]

    Enum.each(matches, &Repo.insert!(&1))

    response = build_conn()
               |> get(leaderboard_path(build_conn(), :fusball))
               |> json_response(200)

    expected = %{
      "data" => [
        %{
          "full_name" => "Joe Dohn",
          "wins" => 3,
          "all_games" => 4,
          "loses" => 1,
          "draws" => 0,
          "points" => 3
        },
        %{
          "full_name" => "John Doe",
          "wins" => 2,
          "all_games" => 2,
          "loses" => 0,
          "draws" => 0,
          "points" => 2
        },
        %{
          "full_name" => "Dohn Joe",
          "wins" => 1,
          "all_games" => 6,
          "loses" => 5,
          "draws" => 0,
          "points" => 1
        }
      ]
    }

    assert response == expected
  end
end
