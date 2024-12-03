ExUnit.start()

Mox.defmock(NewsCli.Datasource.MockNewsApi, for: NewsCli.Datasource.NewsApi)
Application.put_env(:news_cli, :news_api, NewsCli.Datasource.MockNewsApi)

Mox.defmock(NewsCli.Command.MainCommandMock, for: NewsCli.Command.Command)
Application.put_env(:news_cli, :main_command, NewsCli.Command.MainCommandMock)

Mox.defmock(NewsCli.Command.SubCommandMock, for: NewsCli.Command.Command)

Application.put_env(:news_cli, :main_subcommands, %{
  "--subcommand" => NewsCli.Command.SubCommandMock
})
