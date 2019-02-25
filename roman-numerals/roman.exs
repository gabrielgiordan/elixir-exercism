defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number), do: number |> reduce(&roman/3) |> IO.iodata_to_binary

  @romans %{
    1 => 'IVX',
    2 => 'XLC',
    3 => 'CDM'
  }
  defp roman(digit, house, acc) when house > 3, do: [List.duplicate('M', digit) | acc]
  defp roman(digit, house, acc) do
    [roman1, roman2, roman3] = @romans[house]
    case digit do
      1 -> [roman1 | acc]
      2 -> [roman1, roman1 | acc]
      3 -> [roman1, roman1, roman1 | acc]
      4 -> [roman1, roman2 | acc]
      5 -> [roman2 | acc]
      6 -> [roman2, roman1 | acc]
      7 -> [roman2, roman1, roman1 | acc]
      8 -> [roman2, roman1, roman1, roman1 | acc]
      9 -> [roman1, roman3 | acc]
      0 -> acc
    end
  end

  defp reduce(number, acc \\ [], fun, house \\ 1) do
    digit = rem(number, 10)
    remaining = div(number - digit, 10)
    acc_ = fun.(digit, house, acc)
    number >= 100 && reduce(remaining, acc_, fun, house + 1) ||
      number >= 10 && fun.(remaining, house + 1, acc_) || acc_
  end
end
