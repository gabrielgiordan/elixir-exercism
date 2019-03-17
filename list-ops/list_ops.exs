defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l), do: reduce(l, 0, fn _, c -> c + 1 end)

  @spec reverse(list) :: list
  def reverse(l), do: reduce(l, [], &[&1 | &2])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: l |> reduce([], &[f.(&1) | &2]) |> reverse

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: reduce(l, [], &(f.(&1) && [&1 | &2] || &2)) |> reverse

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([h|t], acc, f), do: reduce(t, f.(h, acc), f)
  def reduce([], acc, _), do: acc

  @spec append(list, list) :: list
  def append(a, b), do: a |> reverse |> reduce(b, &[&1 | &2])

  @spec concat([[any]]) :: [any]
  def concat(ll), do: ll |> reverse |> reduce([], &append/2)
end
