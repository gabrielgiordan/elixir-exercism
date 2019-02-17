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
    <<b5::1, b4::1, b3::1, b2::1, b1::1>> = <<code::5>>
    a = []
    a = if b1 == 1, do: ["wink" | a], else: a
    a = if b2 == 1, do: ["double blink" | a], else: a
    a = if b3 == 1, do: ["close your eyes" | a], else: a
    a = if b4 == 1, do: ["jump" | a], else: a
    if b5 == 1, do: a, else: Enum.reverse(a)
  end
end
