defmodule NewsCli.Datasource.HttpNewsApiTest do
  use ExUnit.Case

  alias NewsCli.Datasource.HttpNewsApi

  test "should initiate proper http call while retrieving news of a given category" do
    Req.Test.stub(NewsCli.Datasource.HttpNewsApiTestPlug, fn conn ->
      assert conn.request_path == "/news/category/technology"
      assert conn.method == "GET"

      Req.Test.json(conn, %{dummy: "response"})
    end)

    actual = HttpNewsApi.get_news_with_category("technology")

    assert match?({:ok, %{body: %{"dummy" => "response"}}}, actual)
  end

  test "should initiate proper http call while retrieving news of a given country" do
    Req.Test.stub(NewsCli.Datasource.HttpNewsApiTestPlug, fn conn ->
      assert conn.request_path == "/news/country/us"
      assert conn.method == "GET"

      Req.Test.json(conn, %{dummy: "response"})
    end)

    actual = HttpNewsApi.get_news_of_country("us")

    assert match?({:ok, %{body: %{"dummy" => "response"}}}, actual)
  end

  test "should initiate proper http call while retrieving news for given keywords" do
    Req.Test.stub(NewsCli.Datasource.HttpNewsApiTestPlug, fn conn ->
      assert conn.request_path == "/news"
      assert conn.params == %{"keywords" => "artificial,intelligence"}
      assert conn.method == "GET"

      Req.Test.json(conn, %{dummy: "response"})
    end)

    actual = HttpNewsApi.get_news_containing_keywords(["artificial", "intelligence"])

    assert match?({:ok, %{body: %{"dummy" => "response"}}}, actual)
  end
end
