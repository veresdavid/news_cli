defmodule NewsCli.Http.HttpUtilTest do
  use ExUnit.Case

  alias NewsCli.Http.HttpUtil

  test "should return api response properly" do
    json = """
    {"some": "json input"}
    """

    http_api_caller = fn -> {:ok, %{status: 200, body: json}} end
    body_parser = fn _ -> %{parsed: :body} end

    expected = {:ok, %{parsed: :body}}

    actual = HttpUtil.get_api_response(http_api_caller, body_parser)

    assert actual == expected
  end

  test "should utilize response body extractor when it is passed" do
    json = """
    {"some": "json input"}
    """

    parsed_json = %{some: "json input"}

    http_api_caller = fn -> {:ok, %{status: 201, body: json}} end

    response_body_extractor = fn raw_response ->
      assert match?(%{status: 201}, raw_response)
      {:ok, json}
    end

    body_parser = fn response_body ->
      assert response_body == parsed_json
      parsed_json
    end

    expected = {:ok, parsed_json}

    actual = HttpUtil.get_api_response(http_api_caller, response_body_extractor, body_parser)

    assert actual == expected
  end

  test "should return error tuple when http api caller fails" do
    http_api_caller = fn -> {:error, :some_http_error} end

    actual = HttpUtil.get_api_response(http_api_caller, nil, nil)

    assert match?({:error, {:http_call_error, :some_http_error}}, actual)
  end

  test "should return error tuple when response body extractor fails" do
    http_api_caller = fn -> {:ok, :http_response} end

    response_body_extractor = fn raw_response ->
      assert raw_response == :http_response

      :some_response_error
    end

    actual = HttpUtil.get_api_response(http_api_caller, response_body_extractor, nil)

    assert match?({:error, {:http_response_error, :some_response_error}}, actual)
  end

  test "should return error tuple when body parsing fails" do
    json = """
    {"some": "json input"}
    """

    http_api_caller = fn -> {:ok, :http_response} end

    response_body_extractor = fn raw_response ->
      assert raw_response == :http_response

      {:ok, json}
    end

    body_parser = fn _ ->
      raise "body parse error"
    end

    actual = HttpUtil.get_api_response(http_api_caller, response_body_extractor, body_parser)

    assert match?(
             {:error, {:body_parse_error, %RuntimeError{message: "body parse error"}}},
             actual
           )
  end

  test "should return error tuple default response body extractor founds different status code than http 200" do
    http_api_caller = fn -> {:ok, %{status: 400}} end

    actual = HttpUtil.get_api_response(http_api_caller, nil)

    assert match?({:error, {:http_response_error, :wrong_response}}, actual)
  end
end
