defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) when is_binary(str), do:
    for str <- String.split(str, "\n"), do:
      for str <- String.split(str, " "), do: String.to_integer(str)

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t() | List.t()) :: [[integer]]
  def columns(str) when is_binary(str), do: str |> rows() |> columns()
  def columns(matrix) when is_list(matrix), do:
    for zipped <- Enum.zip(matrix), do: Tuple.to_list(zipped)

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) when is_binary(str) do
    rows = rows(str)
    cols = columns(rows)

    for {row, x} <- Enum.with_index(rows),
        {col, y} <- Enum.with_index(cols),
        Enum.max(row) == Enum.min(col), do: {x, y}
  end
end
