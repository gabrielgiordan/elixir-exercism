defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clocnmwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []
  def matrix(n) do
    for x <- 0..n - 1 do
      for y <- 0..n - 1 do

        nm = min(min(x, y), min(n - 1 - x, n - 1 - y))

        s = if (x <= y) do
          (n - 2 * nm) * (n - 2 * nm) - (x - nm) - (y - nm)
        else
          (n - 2 * nm - 2) * (n - 2 * nm - 2) + (x - nm) + (y - nm)
        end

        n * n - s + 1
      end
    end
  end
end
