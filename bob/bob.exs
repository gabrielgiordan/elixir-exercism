defmodule Bob do
  def hey(input) do
    silence? = String.trim(input) == ""
    asking? = String.ends_with?(input, "?")
    shouting? = input != String.downcase(input) and input == String.upcase(input)

    cond do
      silence? -> "Fine. Be that way!"
      asking? && shouting? -> "Calm down, I know what I'm doing!"
      asking? -> "Sure."
      shouting? -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end
