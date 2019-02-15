defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    do_keep(list, fun)
  end

  defp do_keep([h | t], f) do
    if f.(h), do: [h | do_keep(t, f)], else: do_keep(t, f)
  end

  defp do_keep([], f) do
    []
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    do_discard(list, fun)
  end

  defp do_discard([h | t], f) do
    unless f.(h), do: [h | do_discard(t, f)], else: do_discard(t, f)
  end

  defp do_discard([], f) do
    []
  end
end
