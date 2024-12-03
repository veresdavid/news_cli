import Config

config :news_cli,
  news_api_request_options: [
    plug: {Req.Test, NewsCli.Datasource.HttpNewsApiTestPlug}
  ]
