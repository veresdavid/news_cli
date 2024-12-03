defmodule NewsCli.Command.CountryTest do
  use ExUnit.Case

  import Mox

  alias NewsCli.Domain.News
  alias NewsCli.Command.Country
  alias NewsCli.Datasource.MockNewsApi

  setup :verify_on_exit!

  test "should return news for the given country" do
    json = """
    [ { "id": 1, "title": "Title", "summary": "Summary" } ]
    """

    MockNewsApi
    |> expect(:get_news_of_country, fn country ->
      assert country == "us"

      {:ok, %{status: 200, body: json}}
    end)

    expected =
      {:ok,
       {:country_result,
        [
          %News{
            id: 1,
            title: "Title",
            summary: "Summary"
          }
        ]}}

    actual = Country.process(["us"])

    assert actual == expected
  end

  test "should return error result when no parameter is passed" do
    expected = {:error, {:invalid_param_error, "Country command requires a single param!"}}

    actual = Country.process([])

    assert actual == expected
  end

  test "should return error result when more than one parameter is passed" do
    expected = {:error, {:invalid_param_error, "Country command requires a single param!"}}

    actual = Country.process(["too", "many"])

    assert actual == expected
  end

  test "should return error result when command processing fails" do
    MockNewsApi
    |> expect(:get_news_of_country, fn _ ->
      {:error, %{}}
    end)

    actual = Country.process(["us"])

    assert match?({:error, _}, actual)
  end
end
