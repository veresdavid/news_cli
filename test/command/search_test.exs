defmodule NewsCli.Command.SearchTest do
  use ExUnit.Case

  import Mox

  alias NewsCli.Domain.News
  alias NewsCli.Command.Search
  alias NewsCli.Datasource.MockNewsApi

  setup :verify_on_exit!

  test "should return news for the given keywords" do
    json = """
    [ { "id": 1, "title": "Title", "summary": "Summary" } ]
    """

    MockNewsApi
    |> expect(:get_news_containing_keywords, fn keywords ->
      assert keywords == ["artificial", "intelligence"]

      {:ok, %{status: 200, body: json}}
    end)

    expected =
      {:ok,
       {:search_result,
        [
          %News{
            id: 1,
            title: "Title",
            summary: "Summary"
          }
        ]}}

    actual = Search.process(["artificial intelligence"])

    assert actual == expected
  end

  test "should print error when no parameter is passed" do
    expected = {:error, {:invalid_param_error, "Search command requires a single param!"}}

    actual = Search.process([])

    assert actual == expected
  end

  test "should print error when more than one parameter is passed" do
    expected = {:error, {:invalid_param_error, "Search command requires a single param!"}}

    actual = Search.process(["too", "many"])

    assert actual == expected
  end

  test "should print error when command processing fails" do
    MockNewsApi
    |> expect(:get_news_containing_keywords, fn _ ->
      {:error, %{}}
    end)

    actual = Search.process(["artificial intelligence"])

    assert match?({:error, _}, actual)
  end
end
