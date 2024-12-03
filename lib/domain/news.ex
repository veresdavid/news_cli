defmodule NewsCli.Domain.News do
  @moduledoc """
  Struct definition of a news.
  """

  defstruct [:id, :title, :summary]

  @type t :: %__MODULE__{
          id: non_neg_integer(),
          title: String.t(),
          summary: String.t()
        }
end
