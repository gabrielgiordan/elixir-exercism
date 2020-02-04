defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Task.async_stream(&analyze/1, max_concurrency: workers, ordered: false)
    |> Enum.reduce(%{}, fn {:ok, f}, acc -> Map.merge(acc, f, fn _, a, b -> a + b end) end)
  end

  def analyze(text, acc \\ %{})
  def analyze(<<h::utf8, t::binary>>, acc) do
    h = String.downcase(<<h::utf8>>)
    (h =~ ~r(\p{L}) && analyze(t, Map.update(acc, h, 1, &(1 + &1)))) || analyze(t, acc)
  end
  def analyze(<<>>, acc), do: acc
end
