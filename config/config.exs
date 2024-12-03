import Config

config :news_cli, main_command: NewsCli.Command.Main

config :news_cli,
  main_subcommands: %{
    "--category" => NewsCli.Command.Category,
    "--country" => NewsCli.Command.Country,
    "--search" => NewsCli.Command.Search
  }

config :news_cli, news_api: NewsCli.Datasource.HttpNewsApi
config :news_cli, news_api_base_url: "http://localhost:8080"

# Import environment-specific configs
import_config("#{config_env()}.exs")
