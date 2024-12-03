defmodule NewsCli.Command.Main do
  alias NewsCli.Command.Command

  @behaviour Command

  @impl Command
  def process([]) do
    {:error, :no_subcommand_chosen}
  end

  @impl Command
  def process([first_arg | tail]) do
    case subcommand = subcommands()[first_arg] do
      nil -> {:error, :unknown_subcommand}
      _ -> subcommand.process(tail)
    end
  end

  defp subcommands do
    Application.get_env(:news_cli, :main_subcommands)
  end
end
