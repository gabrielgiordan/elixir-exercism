defmodule OcrNumbers do
  @moduledoc false

  @ocr_numbers %{
    ' _ | ||_|' => '0',
    '     |  |' => '1',
    ' _  _||_ ' => '2',
    ' _  _| _|' => '3',
    '   |_|  |' => '4',
    ' _ |_  _|' => '5',
    ' _ |_ |_|' => '6',
    ' _   |  |' => '7',
    ' _ |_||_|' => '8',
    ' _ |_| _|' => '9'
  }

  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: String.t()
  def convert(input) do
    with :ok <- analyze_rows(input),
         :ok <- analyze_columns(input) do
      {:ok,
       input
       |> Stream.transform(0, &((&2 < 3 && {[&1], &2 + 1}) || {[], 0}))
       |> Task.async_stream(&analyze_line/1, max_concurrency: 4)
       |> Stream.map(&elem(&1, 1))
       |> Stream.chunk_every(3)
       |> Task.async_stream(&analyze_digits/1, max_concurrency: 4)
       |> Stream.map(&elem(&1, 1))
       |> Stream.intersperse(',')
       |> Stream.concat()
       |> Enum.to_list()
       |> to_string()}
    end
  end

  defp analyze_rows(input) when rem(length(input), 4) > 0, do: {:error, 'invalid line count'}
  defp analyze_rows(_), do: :ok

  defp analyze_columns([h | _]) when rem(byte_size(h), 3) > 0, do: {:error, 'invalid column count'}
  defp analyze_columns([_ | t]), do: analyze_columns(t)
  defp analyze_columns([]), do: :ok

  defp analyze_line(line) do
    line
    |> String.to_charlist()
    |> Stream.chunk_every(3)
    |> Enum.to_list()
  end

  defp analyze_digits(lines) do
    lines
    |> Stream.zip()
    |> Stream.map(&Tuple.to_list/1)
    |> Stream.map(&Enum.concat/1)
    |> Stream.map(&charlist_to_digit/1)
    |> Stream.concat()
    |> Enum.to_list()
  end

  for ocr_number <- Map.keys(@ocr_numbers) do
    defp charlist_to_digit(unquote(ocr_number)), do: unquote(@ocr_numbers[ocr_number])
  end
  defp charlist_to_digit(_), do: '?'
end
