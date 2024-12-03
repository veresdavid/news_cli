defmodule NewsCliTest do
  use ExUnit.Case

  import Mox
  import ExUnit.CaptureIO

  alias NewsCli.Domain.News

  setup :verify_on_exit!

  test "should delegate processing to main command" do
    NewsCli.Command.MainCommandMock
    |> expect(:process, fn args ->
      assert args == ["--category", "technology"]

      {:ok,
       {:category_result,
        [
          %News{
            id: 1,
            title: "Title",
            summary: "Summary"
          }
        ]}}
    end)

    actual =
      capture_io(fn ->
        NewsCli.main(["--category", "technology"])
      end)

    assert actual == "1 - Title\n"
  end
end
