defmodule NewsCli.Parser.NewsParser do
  @moduledoc """
  Module that helps to parse input to `NewsCli.Domain.News` struct format.
  """

  alias NewsCli.Domain.News

  @doc """
  Parses a map to `NewsCli.Domain.News` format.

  ## Parameters

  - `news_as_map`: An Elixir map that describes a news item. Properties of a
  news item are expected to be atom keys of the map.

  ## Return value

  Returns the parsed `NewsCli.Domain.News` struct when succeeds.
  A `KeyError` can be expected, if any key is missing, that describes a mandatory
  property of a news item.
  """
  @spec parse_news(news_as_map :: map()) :: News.t()
  def parse_news(news_as_map) do
    %News{
      id: news_as_map.id,
      title: news_as_map.title,
      summary: news_as_map.summary
    }
  end
end
