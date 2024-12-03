defmodule NewsCli.Command.ResultHandler do
  @moduledoc """
  A module which helps to handle the result given back by a `NewsCli.Command.Command` implementation.

  Provides a `handle/1` function with many different forms, that can match the
  result and handle it properly.

  Also provides fallback handling, in case the given result is unknown.
  """

  alias NewsCli.IO.PrintUtil

  @doc """
  Handles the result of a command.

  ## Parameters

  - `result`: The result of a command, which will typically be a tuple, like
  `{:ok, result}` or `{:error, reason}`. Second elements of the tuples, `result` and
  `reason` can be also tuples or atoms, that gives a better description about the result
  and that can be used for pattern matching in `handle/1` implementations, to provide
  a proper handling.

  ## Return value

  No specific return value should be expected from this function.
  """
  @spec handle(result :: any()) :: any()
  def handle(result) do
    do_handle(result)
  end

  # known success results

  defp do_handle({:ok, {:category_result, news}}) do
    Enum.each(news, &PrintUtil.print_short_news_info/1)
  end

  defp do_handle({:ok, {:country_result, news}}) do
    Enum.each(news, &PrintUtil.print_short_news_info/1)
  end

  defp do_handle({:ok, {:search_result, news}}) do
    Enum.each(news, &PrintUtil.print_short_news_info/1)
  end

  # known errors

  defp do_handle({:error, :no_subcommand_chosen}) do
    PrintUtil.print_error("No subcommand has been chosen")
  end

  defp do_handle({:error, :unknown_subcommand}) do
    PrintUtil.print_error("Unknown subcommand")
  end

  defp do_handle({:error, {:invalid_param_error, message}}) do
    PrintUtil.print_error(message)
  end

  defp do_handle({:error, {:http_call_error, _}}) do
    PrintUtil.print_error("Failed to call 3rd party API")
  end

  defp do_handle({:error, {:http_response_error, _}}) do
    PrintUtil.print_error("Got wrong response from 3rd party API")
  end

  defp do_handle({:error, {:body_parse_error, _}}) do
    PrintUtil.print_error("Failed to parse JSON response")
  end

  # unknown error

  defp do_handle({:error, _}) do
    PrintUtil.print_error("Unknown error")
  end

  # unknown result

  defp do_handle(_) do
    IO.puts("Unexpected result")
  end
end
