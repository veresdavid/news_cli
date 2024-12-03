defmodule NewsCli.Parser.JsonParserUtilTest do
  use ExUnit.Case

  alias NewsCli.Parser.JsonParserUtil
  alias NewsCli.Domain.News

  test "should parse json input properly" do
    json = """
    {"some": "json input"}
    """

    body_parser = fn decoded_body ->
      assert decoded_body == %{some: "json input"}

      %News{}
    end

    expected = {:ok, %News{}}

    actual = JsonParserUtil.parse_api_response(json, body_parser)

    assert actual == expected
  end

  test "should return error tuple when invalid json is passed" do
    json = "{ invalid"

    body_parser = fn -> :whatever end

    actual = JsonParserUtil.parse_api_response(json, body_parser)

    assert match?({:error, {:body_parse_error, %Jason.DecodeError{}}}, actual)
  end

  test "should return error tuple when body parser fails" do
    json = """
    { "some": "json input" }
    """

    body_parser = fn _ ->
      raise "body parser fails"
    end

    actual = JsonParserUtil.parse_api_response(json, body_parser)

    assert match?(
             {:error, {:body_parse_error, %RuntimeError{message: "body parser fails"}}},
             actual
           )
  end
end
