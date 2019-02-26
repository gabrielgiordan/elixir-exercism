defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input, columns \\ [], rows \\ [])
  def from_string("", c, r), do: %Matrix{matrix: Enum.reverse([Enum.reverse(c) | r])}
  def from_string(<<h::utf8, t::binary>>, c, r) when h == ?\s, do: from_string(t, c, r)
  def from_string(<<h::utf8, t::binary>>, c, r) when h == ?\n, do: from_string(t, [], [Enum.reverse(c) | r])
  def from_string(<<h::utf8, _::binary>> = input, c, r) when h >= ?0 and h <= ?9 do # Number
    { t, n } = from_number(input)
    from_string(t, [n | c], r)
  end
  def from_string(input, c, r) do # String
    { t, s } = from_kernel_string(input)
    from_string(t, [s | c], r)
  end

  defp from_kernel_string(input, acc \\ [])
  defp from_kernel_string("", acc), do: { "", acc |> Enum.reverse |> Kernel.to_string }
  defp from_kernel_string(<<h::utf8, _::binary>> = input, acc) when h == ?\s or h == ?\n do
    { input, acc |> Enum.reverse |> Kernel.to_string }
  end
  defp from_kernel_string(<<h::utf8, t::binary>>, acc), do: from_kernel_string(t, [h | acc])

  defp from_number(input, number \\ 0, decimal \\ 1)
  defp from_number(<<h::utf8, t::binary>>, n, d) when h >= ?0 and h <= ?9, do: from_number(t, n * d + (h - ?0), d * 10)
  defp from_number(input, n, _), do: { input, n }

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%Matrix{matrix: matrix}), do: to_string_rows(matrix)
  defp to_string_rows(matrix, acc \\ [])
  defp to_string_rows([h], acc), do: [to_string_column(h) | acc] |> Enum.reverse |> IO.iodata_to_binary
  defp to_string_rows([h | t], acc), do: to_string_rows(t, [?\n, to_string_column(h) | acc])
  defp to_string_column(list, acc \\ [])
  defp to_string_column([h], acc) when is_integer(h), do: Enum.reverse([Integer.to_string(h) | acc])
  defp to_string_column([h | t], acc) when is_integer(h), do: to_string_column(t, [?\s, Integer.to_string(h) | acc])
  defp to_string_column([h], acc), do: Enum.reverse([h | acc])
  defp to_string_column([h | t], acc), do: to_string_column(t, [?\s, h | acc])

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%Matrix{matrix: matrix}), do: matrix

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%Matrix{matrix: matrix}, index), do: Enum.at(matrix, index)

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(%Matrix{matrix: matrix}), do: transpose(matrix)
  defp transpose(matrix, tmp \\ [], columns \\ [], rows \\ [], reverse? \\ true)
  defp transpose([[ch | ct] | rt], t, c, r, r?), do: transpose(rt, [ct | t], [ch | c], r, r?)
  defp transpose([], t, c, r, r?), do: transpose(t, [], [], [(r? && Enum.reverse(c) || c) | r], not r?)
  defp transpose(_, _, [], r, _), do: Enum.reverse(r)

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(%Matrix{matrix: matrix}, index), do: transpose_column(matrix, index)
  defp transpose_column(matrix, index, acc \\ [])
  defp transpose_column([h | t], i, c), do: transpose_column(t, i, [Enum.at(h, i) | c])
  defp transpose_column([], _, c), do: Enum.reverse(c)
end
