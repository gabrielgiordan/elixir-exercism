defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""
  def encode(string), do: do_encode(string)
  defp do_encode(string, previous \\ <<>>, count \\ 0, acc \\ "")
  defp do_encode(<<h::utf8>>, p, c, a) when h == p, do: a <> count(c + 1) <> <<p::utf8>>
  defp do_encode(<<h::utf8>>, p, c, a), do: a <> count(c) <> <<p::utf8>> <> <<h::utf8>>
  defp do_encode(<<h::utf8, t::binary>>, <<>>, _, a), do: do_encode(t, h, 0, a)
  defp do_encode(<<h::utf8, t::binary>>, p, c, a) when h == p, do: do_encode(t, h, c + 1, a)
  defp do_encode(<<h::utf8, t::binary>>, p, c, a), do: do_encode(t, h, 0, a <> count(c) <> <<p::utf8>>)
  defp count(c), do: c > 0 && to_string(c + 1) || <<>>

  @spec decode(String.t()) :: String.t()
  def decode(string), do: do_decode(string)
  defp do_decode(string, count \\ "", acc \\ "")
  defp do_decode("", _, a), do: a
  defp do_decode(<<h::utf8, t::binary>>, c, a) when h > ?0 and h < ?9, do: do_decode(t, c <> <<h::utf8>>, a)
  defp do_decode(<<h::utf8, t::binary>>, c, a), do: do_decode(t, "", a <> duplicate(h, c))
  defp duplicate(h, c), do: c == "" && <<h::utf8>> || String.duplicate(<<h::utf8>>, String.to_integer(c))
end
