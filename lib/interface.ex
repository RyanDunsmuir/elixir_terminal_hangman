defmodule Interface do
  def menu() do
    spacer()

    IO.puts("""
    MAIN MENU
    1 - Start Game
    2 - Exit Game
    """)
  end

  def ask_difficulty() do
    spacer()

    IO.puts("""
    SELECT DIFFICULTY
    1 - Easy
    2 - Medium
    3 - Hard
    """)
  end

  def game_round(tally) do
    spacer()

    IO.puts("""
    GUESS THE WORD
    ===============================

    #{tally.letters}

    ===============================
    ATTEMPTS LEFT: #{tally.turns_left}
    USED LETTERS: #{tally.used}
    ===============================

    """)

    IO.gets("Type a Letter: ")
  end

  def game_over(state) do
    spacer()

    IO.puts("""
    #{if state == :won, do: "YOU WIN!! :D", else: "YOU LOSE :("}

    """)
  end

  def display_score(score) do
    IO.puts("""

    ===============================
    YOUR SCORE:

              #{score}

    ===============================

    """)
  end

  def spacer() do
    IO.puts("""




    """)
  end

  def continue(_previous_message) do
    IO.gets("Type anthing to continue: ")
  end

  def user_input() do
    IO.gets("Select Option: ")
  end

  def user_game_input() do
    IO.gets("Guess: ")
  end

  def invalid_input() do
    IO.puts("Invalid input")
  end
end
