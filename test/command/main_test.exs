defmodule NewsCli.Command.MainTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  test "should delegate call to proper subcommand" do
    NewsCli.Command.SubCommandMock
    |> expect(:process, fn args ->
      assert args == ["param"]

      {:ok, %{}}
    end)

    actual = NewsCli.Command.Main.process(["--subcommand", "param"])

    assert actual == {:ok, %{}}
  end

  test "should print error message when argument list is empty" do
    actual = NewsCli.Command.Main.process([])

    assert actual == {:error, :no_subcommand_chosen}
  end

  test "should print error message when subcommand does not exist" do
    actual = NewsCli.Command.Main.process(["--nonexistent"])

    assert actual == {:error, :unknown_subcommand}
  end
end
