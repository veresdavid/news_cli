defmodule NewsCli do
  @moduledoc """
  Main module of the CLI.
  """

  alias NewsCli.Command.ResultHandler

  @doc """
  Entrypoint of the CLI, that receives the command line arguments and
  forwards them to the proper commands for processing.

  After processing the input and getting a result, the result will be
  presented to the user.

  ## Parameters

  - `args`: Command line arguments, that describe what operations the
  user would like to perform.

  ## Return value

  This function has no specific return value, the result of the processing will be
  presented to the user by passing it to the `NewsCli.Command.ResultHandler.handle/1`
  function.
  """
  @spec main(args :: String.t()) :: :ok
  def main(args) do
    args
    |> main_command().process()
    |> ResultHandler.handle()
  end

  defp main_command() do
    Application.get_env(:news_cli, :main_command)
  end
end
