use Bitwise

defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(s, acc \\ %MapSet{})
  def isogram?(<<?\-, t::bits>>, acc), do: isogram?(t, acc)
  def isogram?(<<?\s, t::bits>>, acc), do: isogram?(t, acc)
  def isogram?(<<h, t::bits>>, acc) do
    not MapSet.member?(acc, h) && isogram?(t, MapSet.put(acc, h)) || false
  end
  def isogram?(<<>>, _), do: true
end
