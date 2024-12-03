defmodule NewsCli.Parser.NewsParserTest do
  use ExUnit.Case

  alias NewsCli.Domain.News
  alias NewsCli.Parser.NewsParser

  test "parse news should properly parse a map to a news struct" do
    input = %{
      :id => 1,
      :title => "Title",
      :summary => "Summary"
    }

    expected = %News{
      id: 1,
      title: "Title",
      summary: "Summary"
    }

    actual = NewsParser.parse_news(input)

    assert actual == expected
  end
end
