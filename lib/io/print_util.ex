defmodule NewsCli.IO.PrintUtil do
  @moduledoc """
  Util module containing IO related functions.
  """

  alias NewsCli.Domain.News

  @doc """
  Prints the given news item to the command line in a short format.

  The short format consists of the `id` of the news, followed by the
  `title`, both of these separated by a dash.

  ## Parameters

  - `news_item`: The news item to be printed in short format.

  ## Examples

      iex> NewsCli.IO.PrintUtil.print_short_news_info(%NewsCli.Domain.News{
        id: 1,
        title: "Title",
        summary: "Summary"
      })
      "1 - Title"
      :ok
  """
  @spec print_short_news_info(news_item :: News.t()) :: :ok
  def print_short_news_info(news_item) do
    IO.puts("#{news_item.id} - #{news_item.title}")
  end

  @doc """
  Prints the provided message to the command line, preceeded with the
  string `Error: `.

  ## Parameters

  - `message`: A string describing the error.

  ## Examples

      iex> NewsCli.IO.PrintUtil.print_error("Invalid parameter")
      "Error: Invalid parameter"
      :ok
  """
  @spec print_error(message :: String.t()) :: :ok
  def print_error(message) do
    IO.puts("Error: #{message}")
  end
end
