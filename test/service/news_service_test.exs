defmodule NewsCli.Service.NewsServiceTest do
  use ExUnit.Case

  import Mox

  alias NewsCli.Domain.News
  alias NewsCli.Service.NewsService

  test "should return news per category properly" do
    json = """
    [ { "id": 1, "title": "Title", "summary": "Summary" } ]
    """

    api_response = {:ok, %{status: 200, body: json}}

    NewsCli.Datasource.MockNewsApi
    |> expect(:get_news_with_category, fn "technology" -> api_response end)

    expected =
      {:ok,
       [
         %News{
           id: 1,
           title: "Title",
           summary: "Summary"
         }
       ]}

    actual = NewsService.get_news_with_category("technology")

    assert actual == expected
  end

  test "should return news per country properly" do
    json = """
    [ { "id": 1, "title": "Title", "summary": "Summary" } ]
    """

    api_response = {:ok, %{status: 200, body: json}}

    NewsCli.Datasource.MockNewsApi
    |> expect(:get_news_of_country, fn "us" -> api_response end)

    expected =
      {:ok,
       [
         %News{
           id: 1,
           title: "Title",
           summary: "Summary"
         }
       ]}

    actual = NewsService.get_news_of_country("us")

    assert actual == expected
  end

  test "should return news for keywords properly" do
    json = """
    [ { "id": 1, "title": "Title", "summary": "Summary" } ]
    """

    api_response = {:ok, %{status: 200, body: json}}

    NewsCli.Datasource.MockNewsApi
    |> expect(:get_news_containing_keywords, fn ["artificial", "intelligence"] -> api_response end)

    expected =
      {:ok,
       [
         %News{
           id: 1,
           title: "Title",
           summary: "Summary"
         }
       ]}

    actual = NewsService.get_news_containing_keywords(["artificial", "intelligence"])

    assert actual == expected
  end
end
