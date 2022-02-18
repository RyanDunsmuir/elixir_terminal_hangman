defmodule Controller do
  alias Hangman.Game

  def begin_game() do
    Interface.ask_difficulty()

    Interface.user_input()
    |> validate_input
    |> setup_game()
    |> play()
  end

  defp validate_input("1\n"), do: {:ok, :easy}
  defp validate_input("2\n"), do: {:ok, :medium}
  defp validate_input("3\n"), do: {:ok, :hard}
  defp validate_input(_), do: {:error, :invalid_input}

  defp setup_game({:error, _error}) do
    Interface.invalid_input()
    begin_game()
  end

  defp setup_game(difficulty) do
    Game.new_game(difficulty)
  end

  defp play({game, tally}) do
    Interface.game_round(tally)
    |> translate_input()
    |> Game.make_move(game)
    |> case do
      {%{game_state: :won} = game, _tally} -> game_over(game)
      {%{game_state: :lost} = game, _tally} -> game_over(game)
      {%{game_state: _} = game, tally} -> play({game, tally})
    end
  end

  defp translate_input(input) do
    input
    |> String.at(0)
    |> String.capitalize()
  end

  def game_over(%{game_state: state} = game) do
    Interface.game_over(state)

    Game.calculate_score(game)
    |> Interface.display_score()
    |> Interface.continue()
  end
end
