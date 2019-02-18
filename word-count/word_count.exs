defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(~r/[^[:alnum:]-]+/u, trim: true)
    |> Enum.reduce(%{}, &Map.update(&2, &1, 1, fn c -> c + 1 end))
  end
end
