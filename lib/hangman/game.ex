defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initialising,
    letters: [],
    used: MapSet.new()
  )

  def new_game({:ok, difficulty}) do
    word = build_word(difficulty)

    return_with_tally(%Hangman.Game{letters: word})
  end

  defp build_word(difficulty) do
    difficulty
    |> Dictionary.random_word()
    |> String.codepoints()
  end

  defp return_with_tally(game), do: {game, tally(game)}

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: reveal_guessed(game.letters, game.used),
      used: reveal_used(game.used)
    }
  end

  defp reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, Enum.member?(used, letter)) end)
    |> Enum.join(" ")
  end

  defp reveal_letter(letter, true), do: letter
  defp reveal_letter(_letter, _not_guessed), do: "_"

  defp reveal_used(used_letters) do
    used_letters
    |> MapSet.to_list()
    |> Enum.join(" ")
  end

  # ---------------------------

  def make_move(_guess, game = %{game_state: state}) when state in [:won, :lost] do
    return_with_tally(game)
  end

  def make_move(guess, game) do
    game
    |> validate_move(guess, MapSet.member?(game.used, guess))
    |> return_with_tally()
  end

  defp validate_move(game, _guess, _already_guessed = true) do
    %{game | game_state: :already_guessed}
  end

  defp validate_move(game, guess, _) do
    %{game | used: MapSet.put(game.used, guess)}
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _good_guess = true) do
    new_state =
      MapSet.new(game.letters)
      |> MapSet.subset?(game.used)
      |> did_win()

    Map.put(game, :game_state, new_state)
  end

  defp score_guess(game = %{turns_left: 1}, _bad_guess) do
    %{game | game_state: :lost, turns_left: 0}
  end

  defp score_guess(game = %{turns_left: turns_left}, _bad_guess) do
    %{game | turns_left: turns_left - 1, game_state: :bad_guess}
  end

  defp did_win(true), do: :won
  defp did_win(false), do: :good_guess

  def calculate_score(%{game_state: :lost}), do: 0

  def calculate_score(game) do
    Enum.count(game.letters) * 10 * game.turns_left
  end
end
