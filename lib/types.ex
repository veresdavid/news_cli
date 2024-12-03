defmodule NewsCli.Types do
  @moduledoc """
  Collection of types used across the application.
  """

  @typedoc """
  Function that performs an HTTP call with `Req` and returns the response object.
  """
  @type http_api_caller_function :: (-> Req.Response.t())

  @typedoc """
  Function that extracts the response body in string format from the received
  `Req.Response` struct.
  """
  @type response_body_extractor_function :: (Req.Response.t() -> String.t())

  @typedoc """
  Function that transforms the input map (typically an HTTP response body in
  Elixir's map format) to a custom format.
  """
  @type body_parser_function :: (map() -> any())
end
