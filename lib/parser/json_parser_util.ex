defmodule NewsCli.Parser.JsonParserUtil do
  @moduledoc """
  Helper module to parse JSON payload.
  """

  alias NewsCli.Types

  @doc """
  Parses a JSON string to a custom type.

  This function is built on top of the `Jason` library. During parsing,
  the `Jason.decode/1` function will be used with a configuration, that
  results in an Elixir map. This map then will be passed to the provided
  `body_parser` function, that can convert it to any desired format.

  ## Parameters

  - `json_response_body`: The JSON string to be parsed.
  - `body_parser`: A function that converts a map (Elixir representation of the JSON string)
  to a desired format.

  ## Return value

  Return value can be either:

  - `{:ok, parsed_body}`: When parsing succeeds, where the `parsed_body` is the value
  returned by the `body_parser` function.
  - `{:error, {:body_parse_error, reason}}`: When parsing fails, either because of
  JSON deserialization or due to any issue while executing `body_parser`.
  """
  @spec parse_api_response(
          json_response_body :: String.t(),
          body_parser :: Types.body_parser_function()
        ) :: {:ok, any()} | {:error, {:body_parse_error, any()}}
  def parse_api_response(json_response_body, body_parser) do
    with {:ok, decoded_body} <- Jason.decode(json_response_body, keys: :atoms),
         {:ok, parsed_body} <- do_parse_body(decoded_body, body_parser) do
      {:ok, parsed_body}
    else
      {:error, reason} -> {:error, {:body_parse_error, reason}}
    end
  end

  defp do_parse_body(decoded_body, body_parser) do
    try do
      {:ok, body_parser.(decoded_body)}
    rescue
      parse_exception -> {:error, parse_exception}
    end
  end
end
