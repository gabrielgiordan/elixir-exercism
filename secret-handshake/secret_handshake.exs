defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    <<e::1, d::1, c::1, b::1, a::1>> = <<code::5>>
    h = a == 1 && ["wink"] || []
    h = b == 1 && ["double blink" | h] || h
    h = c == 1 && ["close your eyes" | h] || h
    h = d == 1 && ["jump" | h] || h
    e == 1 && h || Enum.reverse(h)
  end
end
