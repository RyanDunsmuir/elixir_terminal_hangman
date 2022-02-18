defmodule Router do
  def run() do
    Interface.menu()

    Interface.user_input()
    |> dispatch()

    Router.run()
  end

  defp dispatch("1\n"), do: Controller.begin_game()
  defp dispatch("2\n"), do: System.halt()

  defp dispatch(_) do
    Interface.invalid_input()
    Router.run()
  end
end
