defmodule EliscoreWeb.MatchControllerTest do
  use EliscoreWeb.ConnCase, async: true
  import Eliscore.Factory
  alias Eliscore.{Repo, Model.Category, GameMatch}

  test "index/2 responds with all GameMatches" do
    category = Category.changeset(%Category{}, %{name: "fusball"})
    |> Repo.insert!

    user1 = insert(:user, full_name: "John Doe")
    user2 = insert(:user, full_name: "Dohn Joe")

    matches = [
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user1.id,
          player1_score: 10,
          player2_id: user2.id,
          player2_score: 9,
          category_id: category.id
        }
      ),
      GameMatch.changeset(
        %GameMatch{},%{
          player1_id: user1.id,
          player1_score: 0,
          player2_id: user2.id,
          player2_score: 10,
          category_id: category.id
        }
      )]

    Enum.each(matches, &Repo.insert!(&1))

    match_1 = Repo.get_by(GameMatch, player1_score: 10)
    match_2 = Repo.get_by(GameMatch, player1_score: 0)

    response = build_conn()
               |> Eliscore.Guardian.Plug.sign_in(user1)
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
            "id" => user1.id,
            "full_name" => user1.full_name,
            "image_url" => "image/url",
            "email" => user1.email
          },
          "player2" => %{
            "id" => user2.id,
            "full_name" => user2.full_name,
            "image_url" => "image/url",
            "email" => user2.email
          },
          "category_id" => category.id
        },
        %{
          "accepted" => false,
          "id" => match_1.id,
          "player1_score" => match_1.player1_score,
          "player2_score" => match_1.player2_score,
          "player1" => %{
            "id" => user1.id,
            "full_name" => user1.full_name,
            "image_url" => "image/url",
            "email" => user1.email
          },
          "player2" => %{
            "id" => user2.id,
            "full_name" => user2.full_name,
            "image_url" => "image/url",
            "email" => user2.email
          },
          "category_id" => category.id
        }
      ]
    }

    assert response == expected
  end
end
