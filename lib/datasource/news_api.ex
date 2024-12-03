defmodule NewsCli.Datasource.NewsApi do
  @moduledoc """
  Behaviour describing the possible operations to communicate with a 3rd party News API.

  Acts as a wrapper for the `Req` library.
  """

  @doc """
  Performs an HTTP request with `Req` to retrieve the news related to the given category.
  """
  @callback get_news_with_category(category :: String.t()) ::
              {:ok, Req.Response.t()} | {:error, Exception.t()}

  @doc """
  Performs an HTTP request with `Req` to retrieve the news related to the given country.
  """
  @callback get_news_of_country(country :: String.t()) ::
              {:ok, Req.Response.t()} | {:error, Exception.t()}

  @doc """
  Performs an HTTP request with `Req` to retrieve the news related to the given keywords.
  """
  @callback get_news_containing_keywords(keywords :: list(String.t())) ::
              {:ok, Req.Response.t()} | {:error, Exception.t()}
end
