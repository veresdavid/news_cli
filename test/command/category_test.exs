defmodule NewsCli.Command.CategoryTest do
  use ExUnit.Case

  import Mox

  alias NewsCli.Domain.News
  alias NewsCli.Command.Category
  alias NewsCli.Datasource.MockNewsApi

  setup :verify_on_exit!

  test "should return news for the given category" do
    json = """
    [ { "id": 1, "title": "Title", "summary": "Summary" } ]
    """

    MockNewsApi
    |> expect(:get_news_with_category, fn category ->
      assert category == "technology"

      {:ok, %{status: 200, body: json}}
    end)

    expected =
      {:ok,
       {:category_result,
        [
          %News{
            id: 1,
            title: "Title",
            summary: "Summary"
          }
        ]}}

    actual = Category.process(["technology"])

    assert actual == expected
  end

  test "should print error when no parameter is passed" do
    expected =
      {:error, {:invalid_param_error, "Category command requires a single param!"}}

    actual = Category.process([])

    assert actual == expected
  end

  test "should print error when more than one parameter is passed" do
    expected =
      {:error, {:invalid_param_error, "Category command requires a single param!"}}

    actual = Category.process(["too", "many"])

    assert actual == expected
  end

  test "should print error when command processing fails" do
    MockNewsApi
    |> expect(:get_news_with_category, fn _ ->
      {:error, %{}}
    end)

    actual = Category.process(["technology"])

    assert match?({:error, _}, actual)
  end
end
