defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @ay "ay"
  @vowels ["a", "e", "i", "o", "u", "xb", "xr", "yd", "yt"]

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase |> String.split() |> Enum.map_join(" ", &do_translate/1)
  end
  defp do_translate(<<"qu", t::binary>>), do: "#{t}qu#{@ay}"
  defp do_translate(<<f::binary-1, s::binary-1, _::binary>> = w) when f in @vowels or f <> s in @vowels, do: w <> @ay
  defp do_translate(<<f::binary-1, t::binary>>), do: do_translate(t <> f)
end
