defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    r = if rem(number, 3) == 0, do: "Pling", else: <<>>
    r = if rem(number, 5) == 0, do: "#{r}Plang", else: r
    r = if rem(number, 7) == 0, do: "#{r}Plong", else: r
    if byte_size(r) == 0, do: to_string(number), else: r
  end
end
