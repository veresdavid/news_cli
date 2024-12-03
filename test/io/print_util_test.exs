defmodule NewsCli.IO.PrintUtilTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias NewsCli.IO.PrintUtil
  alias NewsCli.Domain.News

  test "should print proper short news format" do
    news_item = %News{
      id: 1,
      title: "Title",
      summary: "Summary"
    }

    captured_io =
      capture_io(fn ->
        PrintUtil.print_short_news_info(news_item)
      end)

    assert captured_io == "1 - Title\n"
  end
end
