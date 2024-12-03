defmodule NewsCli.Command.ResultHandlerTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias NewsCli.Command.ResultHandler
  alias NewsCli.Domain.News

  test "should print category results properly" do
    result =
      {:ok,
       {:category_result,
        [
          %News{
            id: 1,
            title: "Title",
            summary: "Summary"
          }
        ]}}

    actual =
      capture_io(fn ->
        ResultHandler.handle(result)
      end)

    assert actual == "1 - Title\n"
  end

  test "should print country results properly" do
    result =
      {:ok,
       {:country_result,
        [
          %News{
            id: 1,
            title: "Title",
            summary: "Summary"
          }
        ]}}

    actual =
      capture_io(fn ->
        ResultHandler.handle(result)
      end)

    assert actual == "1 - Title\n"
  end

  test "should print search results properly" do
    result =
      {:ok,
       {:search_result,
        [
          %News{
            id: 1,
            title: "Title",
            summary: "Summary"
          }
        ]}}

    actual =
      capture_io(fn ->
        ResultHandler.handle(result)
      end)

    assert actual == "1 - Title\n"
  end

  test "should print error message when no subcommand has been chosen" do
    result = {:error, :no_subcommand_chosen}

    actual =
      capture_io(fn ->
        ResultHandler.handle(result)
      end)

    assert actual == "Error: No subcommand has been chosen\n"
  end

  test "should print error message when unknown subcommand was chosen" do
    result = {:error, :unknown_subcommand}

    actual =
      capture_io(fn ->
        ResultHandler.handle(result)
      end)

    assert actual == "Error: Unknown subcommand\n"
  end

  test "should print error message when invalid params have been passed" do
    result = {:error, {:invalid_param_error, "invalid param message"}}

    actual =
      capture_io(fn ->
        ResultHandler.handle(result)
      end)

    assert actual == "Error: invalid param message\n"
  end

  test "should print error message when http call happened" do
    result = {:error, {:http_call_error, %{}}}

    actual =
      capture_io(fn ->
        ResultHandler.handle(result)
      end)

    assert actual == "Error: Failed to call 3rd party API\n"
  end

  test "should print error message when received wrong http response" do
    result = {:error, {:http_response_error, %{}}}

    actual =
      capture_io(fn ->
        ResultHandler.handle(result)
      end)

    assert actual == "Error: Got wrong response from 3rd party API\n"
  end

  test "should print error message when response parse failed" do
    result = {:error, {:body_parse_error, %{}}}

    actual =
      capture_io(fn ->
        ResultHandler.handle(result)
      end)

    assert actual == "Error: Failed to parse JSON response\n"
  end

  test "should print generic error message when we got unknown error" do
    result = {:error, %{}}

    actual =
      capture_io(fn ->
        ResultHandler.handle(result)
      end)

    assert actual == "Error: Unknown error\n"
  end

  test "should print generic message when we got unexpected result" do
    result = %{}

    actual =
      capture_io(fn ->
        ResultHandler.handle(result)
      end)

    assert actual == "Unexpected result\n"
  end
end
