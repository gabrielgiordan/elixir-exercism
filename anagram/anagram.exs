defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates), do: matches(base, candidates)

  defp matches(base, candidates, matches \\ [])
  defp matches(b, [c | cs], m) when byte_size(b) == byte_size(c), do: matches(b, cs, anagram?(b, c) && [c | m] || m)
  defp matches(b, [_ | cs], m), do: matches(b, cs, m)
  defp matches(_, [], m), do: Enum.reverse(m)

  defp anagram?(base, canditate, equal? \\ true, base_map \\ %{}, candidate_map \\ %{})
  defp anagram?(<<b_h::utf8, b::binary>>, <<c_h::utf8, c::binary>>, e?, bm, cm) do
    nbh = nrm(b_h)
    nch = nrm(c_h)
    ne? = (e? && nbh == nch) && true || false
    nbm = Map.update(bm, nbh, 1, & &1 + 1)
    ncm = Map.update(cm, nch, 1, & &1 + 1)
    anagram?(b, c, ne?, nbm, ncm)
  end
  defp anagram?("", "", true, _, _), do: false
  defp anagram?("", "", _, m, m), do: true
  defp anagram?("", "", _, _, _), do: false

  defp nrm(c) when c >= ?A and c <= ?Z, do: c + 32
  defp nrm(c), do: c
end
