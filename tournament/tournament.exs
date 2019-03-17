defmodule Tournament.Result do
  defstruct mp: 0, w: 0, d: 0, l: 0, p: 0
end

defmodule Tournament do
  @win %Tournament.Result{mp: 1, w: 1, p: 3}
  @loss %Tournament.Result{mp: 1, l: 1}
  @draw %Tournament.Result{mp: 1, d: 1, p: 1}

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input), do: input |> map() |> string()

  defp string(m), do:
    m |> sort() |> Enum.reduce("#{String.pad_trailing("Team", 31, " ")}| MP |  W |  D |  L |  P", &string/2)
  defp string({t, r}, acc), do:
    <<acc::binary, ?\n, "#{String.pad_trailing(t, 31, " ")}|  #{r.mp} |  #{r.w} |  #{r.d} |  #{r.l} |  #{r.p}">>

  defp sort(m), do: m |> Enum.sort(&sort/2)
  defp sort({_, a}, {_, b}), do: a.p >= b.p

  defp map(list, map \\ %{})
  defp map([h|t], m), do: map(t, split(h, m))
  defp map([], m), do: m

  defp split(s, m), do: s |> String.split(";") |> update(m)

  defp update([a, b, "win"], m), do: m |> update(a, @win) |> update(b, @loss)
  defp update([a, b, "draw"], m), do: m |> update(a, @draw) |> update(b, @draw)
  defp update([a, b, "loss"], m), do: update([b, a, "win"], m)
  defp update(_, m), do: m
  defp update(m, t, r), do: Map.update(m, t, r, &%Tournament.Result{
    mp: &1.mp + r.mp, w: &1.w + r.w, d: &1.d + r.d, l: &1.l + r.l, p: &1.p + r.p})

end
