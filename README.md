# NewsCli

A small CLI written in Elixir for learning purposes.

## Build

News CLI is an [escript](https://hexdocs.pm/mix/main/Mix.Tasks.Escript.Build.html), to build it run:

```bash
mix escript.build
```

The output will be a `news_cli` file, that can run on any machine that has Erlang/OTP installed.

## Usage

General usage of the CLI is:

```bash
news_cli [subcommand] [arguments]
```

Below are the supported subommands

### Category

Retrieves a list of news related to a chosen category. News will be presented in a short format.

```bash
news_cli --category technology
```

### Country

Retrieves a list of news related to a chosen country. News will be presented in a short format.

```bash
news_cli --country us
```

### Search

Retrieves a list of news related to the chosen keywords. If you would like to provide more
keywords, separate them by spaces and put the whole keyowrd list in quotes. News will be
presented in a short format.

```bash
news_cli --search "artificial intelligence"
```

## News API

There is no real News API that is getting called, it has been substituted with mock
responses served by a locally running WireMock. Related files can be found under the
[wiremock](wiremock/) folder.

To start the WireMock server with the mocks set up, you can use the starter script:

```bash
./run_wiremock.sh
```

*Note: the script expects to find the WireMock JAR under the `$HOME/wiremock/` directory
(check the script for more details)*
