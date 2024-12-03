defmodule NewsCli.Datasource.HttpNewsApi do
  @moduledoc """
  `NewsCli.Datasource.HttpNewsApi` implementation, that makes real HTTP requests
  to the News API, using the `Req` library underneath.
  """

  alias NewsCli.Datasource.NewsApi

  @behaviour NewsApi

  @doc """
  Performs an HTTP request with `Req` to retrieve the news related to the given category.
  """
  @impl NewsApi
  @spec get_news_with_category(category :: String.t()) ::
          {:ok, Req.Response.t()} | {:error, Exception.t()}
  def get_news_with_category(category) do
    [
      url: "#{news_api_base_url()}/news/category/#{category}",
      method: :get
    ]
    |> Keyword.merge(Application.get_env(:news_cli, :news_api_request_options, []))
    |> Req.request()
  end

  @doc """
  Performs an HTTP request with `Req` to retrieve the news related to the given country.
  """
  @impl NewsApi
  @spec get_news_of_country(country :: String.t()) ::
          {:ok, Req.Response.t()} | {:error, Exception.t()}
  def get_news_of_country(country) do
    [
      url: "#{news_api_base_url()}/news/country/#{country}",
      method: :get
    ]
    |> Keyword.merge(Application.get_env(:news_cli, :news_api_request_options, []))
    |> Req.request()
  end

  @doc """
  Performs an HTTP request with `Req` to retrieve the news related to the given keywords.
  """
  @impl NewsApi
  @spec get_news_containing_keywords(keywords :: list(String.t())) ::
          {:ok, Req.Response.t()} | {:error, Exception.t()}
  def get_news_containing_keywords(keywords) do
    [first | rest] = keywords
    query_string = Enum.reduce(rest, first, fn keyword, acc -> acc <> "," <> keyword end)

    [
      url: "#{news_api_base_url()}/news",
      params: [keywords: query_string],
      method: :get
    ]
    |> Keyword.merge(Application.get_env(:news_cli, :news_api_request_options, []))
    |> Req.request()
  end

  defp news_api_base_url() do
    Application.get_env(:news_cli, :news_api_base_url)
  end
end
