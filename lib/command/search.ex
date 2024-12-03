defmodule NewsCli.Command.Search do
  @moduledoc """
  `NewsCli.Command.Command` implementation, that retrieves a list of news related
  to the given keywords.
  """

  import NewsCli.Service.NewsService

  alias NewsCli.Command.Command
  alias NewsCli.Domain.News

  @behaviour Command

  @doc """
  Retrieves a list of news related to the given keywords.

  ## Parameters

  - `args`: Expects a single element list, containing the keywords that we are
  interested about. In case we want to pass more keywords, we should do this via
  a single string, where the keywords are separated by spaces. When we have less
  or more than 1 argument, error result will be returned.

  ## Return value

  Returns an error tuple, which can be:

  - `{:ok, news}`: Indicating that the command processing succeeded, `news` list contains
  news related to the given keywords.
  - `{:error, error}`: Indicating that the command processing failed, with `error`
  describing the reason of error.
  """
  @impl Command
  @spec process(args :: [String.t()]) :: {:ok, [News.t()]} | {:error, any()}
  def process(args) do
    do_process(args)
  end

  defp do_process(args) when length(args) != 1 do
    {:error, {:invalid_param_error, "Search command requires a single param!"}}
  end

  defp do_process([joined_keywords]) do
    keywords = String.split(joined_keywords, " ", trim: true)

    case get_news_containing_keywords(keywords) do
      {:ok, news} -> {:ok, {:search_result, news}}
      error -> error
    end
  end
end
