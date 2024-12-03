defmodule NewsCli.Service.NewsService do
  @moduledoc """
  Service module that serves as a facade, to perform news related operations.
  """

  import NewsCli.Http.HttpUtil
  import NewsCli.Parser.NewsParser

  alias NewsCli.Domain.News

  @doc """
  Returns news for the given category.

  ## Parameters

  - `category`: The category that we are interested in.

  ## Return value

  The return value can be:

  - `{:ok, news}`: When retrieving the news succeeds, in this case `news` will contain
  a list of `NewsCli.Domain.News` items.
  - `{:error, reason}`:  When retrieving the news fails, in this case `reason` contains
  more details about the error.
  """
  @spec get_news_with_category(category :: String.t()) ::
          {:ok, news :: list(News.t())} | {:error, reason :: any()}
  def get_news_with_category(category) do
    get_api_response(
      fn -> news_api().get_news_with_category(category) end,
      &parse_news_list/1
    )
  end

  @doc """
  Returns news for the given country.

  ## Parameters

  - `country`: The country that we are interested in.

  ## Return value

  The return value can be:

  - `{:ok, news}`: When retrieving the news succeeds, in this case `news` will contain
  a list of `NewsCli.Domain.News` items.
  - `{:error, reason}`:  When retrieving the news fails, in this case `reason` contains
  more details about the error.
  """
  @spec get_news_of_country(country :: String.t()) ::
          {:ok, news :: list(News.t())} | {:error, reason :: any()}
  def get_news_of_country(country) do
    get_api_response(
      fn -> news_api().get_news_of_country(country) end,
      &parse_news_list/1
    )
  end

  @doc """
  Returns news for the given keywords.

  ## Parameters

  - `keywords`: The list of keywords that we are interested in.

  ## Return value

  The return value can be:

  - `{:ok, news}`: When retrieving the news succeeds, in this case `news` will contain
  a list of `NewsCli.Domain.News` items.
  - `{:error, reason}`:  When retrieving the news fails, in this case `reason` contains
  more details about the error.
  """
  @spec get_news_containing_keywords(keywords :: list(String.t())) ::
          {:ok, news :: list(News.t())} | {:error, reason :: any()}
  def get_news_containing_keywords(keywords) do
    get_api_response(
      fn -> news_api().get_news_containing_keywords(keywords) end,
      &parse_news_list/1
    )
  end

  defp parse_news_list(list_of_news_maps) do
    Enum.map(list_of_news_maps, &parse_news/1)
  end

  defp news_api() do
    Application.get_env(:news_cli, :news_api)
  end
end
