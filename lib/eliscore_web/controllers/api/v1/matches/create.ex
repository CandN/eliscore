defmodule EliscoreWeb.API.V1.Matches.Create do
  use Maru.Router

  @moduledoc """
  This module is responsible for making create new match endpoint
  """

  params do
    requires :player1_id
    requires :player1_score
    requires :player2_id
    requires :player2_score
    requires :category_id
    optional :accepted
  end

  post do
    with {:ok, match} <- Eliscore.Logic.Matches.save(params) do
      json(conn, %{data: match})
    else
      {:error, reason} -> json(conn, %{error: reason})
    end
  end
end
