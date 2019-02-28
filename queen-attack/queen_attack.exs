defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(w \\ {0, 3}, b \\ {7, 3})
  def new(w, w), do: raise ArgumentError
  def new(w, b), do: %Queens{black: b, white: w}

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(q, s \\ 64, acc \\ [])
  def to_string(q, 64 = s, acc), do: to_string(q, s - 1, [has_queen(q, s) | acc])
  def to_string(q, 0, acc), do: IO.iodata_to_binary(acc)
  def to_string(q, s, acc) when rem(s, 8) == 0, do: to_string(q, s - 1, [has_queen(q, s), ?\n | acc])
  def to_string(q, s, acc), do: to_string(q, s - 1, [has_queen(q, s), ?\s | acc])

  defp has_queen(%Queens{black: b, white: w}, s) do
    r = div(s - 1, 8)
    c = rem(s - 1, 8)
    has_queen?(b, r, c) && ?B || has_queen?(w, r, c) && ?W || ?_
  end
  defp has_queen?({r, c}, r, c), do: true
  defp has_queen?(_, _, _), do: false

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{black: {r, _}, white: {r, _}}), do: true
  def can_attack?(%Queens{black: {_, c}, white: {_, c}}), do: true
  def can_attack?(%Queens{black: {rb, cb}, white: {rw, cw}}) do
    abs(rb - cb) == abs(rw - cw) && true || false
  end
end
