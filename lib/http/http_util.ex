defmodule NewsCli.Http.HttpUtil do
  @moduledoc """
  A convenience module that helps to streamline the most basic HTTP calls and
  response processing.
  """

  import NewsCli.Parser.JsonParserUtil

  alias NewsCli.Types

  @doc """
  Executes functions passed as parameters in the following order:

  1. `http_api_caller`
  1. *default response body extractor*
      1. Note: only allows a response with HTTP 200 status code
  1. `body_parser`

  During execution, the output of a function is passed as the input of the next one.

  In the end, we get a fully parsed result from a desired HTTP endpoint.
  """
  @spec get_api_response(
          http_api_caller :: Types.http_api_caller_function(),
          body_parser :: Types.body_parser_function()
        ) :: {:ok, any()} | {:error, any()}
  def get_api_response(http_api_caller, body_parser) do
    get_api_response(http_api_caller, &extract_ok_response_body/1, body_parser)
  end

  @doc """
  Executes functions passed as parameters in the following order:

  1. `http_api_caller`
  1. `response_body_extractor`
  1. `body_parser`

  During execution, the output of a function is passed as the input of the next one.

  In the end, we get a fully parsed result from a desired HTTP endpoint.
  """
  @spec get_api_response(
          http_api_caller :: Types.http_api_caller_function(),
          response_body_extractor :: Types.response_body_extractor_function(),
          body_parser :: Types.body_parser_function()
        ) :: {:ok, any()} | {:error, any()}
  def get_api_response(http_api_caller, response_body_extractor, body_parser) do
    with {:ok, raw_response} <- do_http_api_call(http_api_caller),
         {:ok, json_response_body} <-
           do_extract_response_body(raw_response, response_body_extractor),
         {:ok, parsed} <- do_parse_api_response(json_response_body, body_parser) do
      {:ok, parsed}
    else
      error -> error
    end
  end

  defp do_http_api_call(http_api_caller) do
    with {:ok, raw_response} <- http_api_caller.() do
      {:ok, raw_response}
    else
      {:error, reason} -> {:error, {:http_call_error, reason}}
    end
  end

  defp do_extract_response_body(raw_response, response_body_extractor) do
    with {:ok, json_response_body} <- response_body_extractor.(raw_response) do
      {:ok, json_response_body}
    else
      error -> {:error, {:http_response_error, error}}
    end
  end

  defp do_parse_api_response(json_response_body, body_parser) do
    with {:ok, parsed} <- parse_api_response(json_response_body, body_parser) do
      {:ok, parsed}
    else
      body_parse_error -> body_parse_error
    end
  end

  defp extract_ok_response_body(response) do
    case response do
      %{status: 200, body: body} -> {:ok, body}
      _ -> :wrong_response
    end
  end
end
