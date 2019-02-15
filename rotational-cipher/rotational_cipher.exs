defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(fn c ->
      r = c + rem(shift, 26)
      cond do
        c >= ?a && c <= ?z -> if r <= ?z, do: r, else: r - 26
        c >= ?A && c <= ?Z -> if r <= ?Z, do: r, else: r - 26
        true -> c
      end
    end)
    |> to_string()
  end
end
