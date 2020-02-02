defmodule RobotSimulator do
  @directions [north: {0, 1}, east: {1, 0}, south: {0, -1}, west: {-1, 0}]
  directions_keys = Keyword.keys(@directions)

  defguardp is_direction(d) when d in unquote(directions_keys)
  defguardp is_position(p) when is_tuple(p) and tuple_size(p) == 2 and is_integer(elem(p, 0)) and is_integer(elem(p, 1))

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})
  def create(d, _) when not is_direction(d), do: {:error, "invalid direction"}
  def create(_, p) when not is_position(p), do: {:error, "invalid position"}
  def create(d, p), do: %{direction: d, position: p}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions)
  def simulate(r, <<"A", t::binary>>), do: r |> advance() |> simulate(t)
  def simulate(r, <<"R", t::binary>>), do: r |> turn_right() |> simulate(t)
  def simulate(r, <<"L", t::binary>>), do: r |> turn_left() |> simulate(t)
  def simulate(r, ""), do: r
  def simulate(_, _), do: {:error, "invalid instruction"}

  defmacrop cycle(list, element, offset),
    do: list |> Stream.cycle() |> Stream.drop_while(& element != &1) |> Enum.at(offset)

  for direction <- directions_keys do
    defp turn_right(%{direction: unquote(direction)} = r),
      do: %{r | direction: cycle(unquote(directions_keys), unquote(direction), 1)}

    defp turn_left(%{direction: unquote(direction)} = r),
      do: %{r | direction: cycle(unquote(directions_keys), unquote(direction), unquote(length(directions_keys) - 1))}

    defp advance(%{position: p, direction: unquote(direction)} = r),
      do: %{r | position: sum_positions(p, unquote(@directions[direction]))}
  end

  defp sum_positions({a, b}, {c, d}), do: {a + c, b + d}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%{direction: d}), do: d

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%{position: p}), do: p
end
