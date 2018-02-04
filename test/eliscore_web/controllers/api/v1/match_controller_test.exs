defmodule EliscoreWeb.MatchControllerTest do
  use EliscoreWeb.ConnCase, async: true
  alias Eliscore.{Repo, Model.Category, User, GameMatch}

  test "index/2 responds with all GameMatches" do
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
          player1_score: 0,
          player2_id: user_2.id,
          player2_score: 10,
          category_id: category.id
        }
      )]

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
          "id" => match_2.id,
          "player1_score" => match_2.player1_score,
          "player2_score" => match_2.player2_score,
          "player1" => %{
            "id" => user_1.id,
            "full_name" => user_1.full_name,
            "image_url" => "image/url",
            "email" => user_1.email
          },
          "player2" => %{
            "id" => user_2.id,
            "full_name" => user_2.full_name,
            "image_url" => "image/url",
            "email" => user_2.email
          },
          "category_id" => category.id
        },
        %{
          "accepted" => false,
          "id" => match_1.id,
          "player1_score" => match_1.player1_score,
          "player2_score" => match_1.player2_score,
          "player1" => %{
            "id" => user_1.id,
            "full_name" => user_1.full_name,
            "image_url" => "image/url",
            "email" => user_1.email
          },
          "player2" => %{
            "id" => user_2.id,
            "full_name" => user_2.full_name,
            "image_url" => "image/url",
            "email" => user_2.email
          },
          "category_id" => category.id
        }
      ]
    }

    assert response == expected
  end
end
