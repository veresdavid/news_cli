defmodule NewsCli.Command.Category do
  @moduledoc """
  `NewsCli.Command.Command` implementation, that retrieves a list of news related
  to a chosen category.
  """

  import NewsCli.Service.NewsService

  alias NewsCli.Command.Command
  alias NewsCli.Domain.News

  @behaviour Command

  @doc """
  Retrieves a list of news related to a chosen category.

  ## Parameters

  - `args`: Should be a single element list, containing the category that we are
  interested about. In case we have less or more than 1 argument, error result will
  be returned.

  ## Return value

  Returns an error tuple, which can be:

  - `{:ok, news}`: Indicating that the command processing succeeded, `news` list contains
  news related to the chose category.
  - `{:error, error}`: Indicating that the command processing failed, with `error`
  describing the reason of error.
  """
  @impl Command
  @spec process(args :: [String.t()]) :: {:ok, [News.t()]} | {:error, any()}
  def process(args) do
    do_process(args)
  end

  defp do_process(args) when length(args) != 1 do
    {:error, {:invalid_param_error, "Category command requires a single param!"}}
  end

  defp do_process([category]) do
    case get_news_with_category(category) do
      {:ok, news} -> {:ok, {:category_result, news}}
      error -> error
    end
  end
end
