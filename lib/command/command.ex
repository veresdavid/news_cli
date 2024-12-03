defmodule NewsCli.Command.Command do
  @moduledoc """
  Behaviour describing the blueprint of a command.

  By implementing this behaviour, we can create new commands that can be injected to the CLI.
  """

  @doc """
  Entrypoint to a command / subcommand, that handles the processing.

  ## Parameters

  - `args`: A string list containing the args passed to the command / subcommand. Validating,
  parsing and processing these arguments properly are the responsibility of the given
  implementation.

  ## Return value

  Returns an error tuple, which can be:

  - `{:ok, result}`: Indicating that the command processing succeeded. Second element of
  the tuple can be anything, that can be later used for proper result handling.
  - `{:error, error}`: Indicating that the command processing failed. Second element of
  the tuple can be anything, that properly describes the reason of the error and can
  be used later for error result handling.

  Regarding later command result handling, see: `NewsCli.Command.ResultHandler`.
  """
  @callback process(args :: [String.t()]) :: {:ok, any()} | {:error, any()}
end
