defmodule Markdown do
  @moduledoc false

  @markups_surrounds [{"__", "strong"}, {"_", "em"}]
  @markups_prefixes for n <- 1..6, do: {String.duplicate("#", n), "h#{n}"}
  @markups_specials [{"*", "li", "ul"}]
  @markup_default "p"

  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m), do: parse_lines(m)

  defp tag_enclose(tag, text), do: tag_open(tag) <> text <> tag_close(tag)

  defp tag_open(tag), do: "<#{tag}>"

  defp tag_close(tag), do: "</#{tag}>"

  defp parse_lines(markdown, opened_tags \\ []) do
    case parse_line_with_prefix(markdown) do
      {{parsed, tail}, tag, special_tag} ->
        if special_tag in opened_tags do
          tag_enclose(tag, parsed) <>
            tag_close(special_tag) <> parse_lines(tail, opened_tags -- [special_tag])
        else
          tag_open(special_tag) <>
            tag_enclose(tag, parsed) <> parse_lines(tail, [special_tag | opened_tags])
        end
      {parsed, tag, special_tag} ->
        tag_enclose(tag, parsed) <> tag_close(special_tag)
      {{parsed, tail}, tag} ->
        tag_enclose(tag, parsed) <> parse_lines(tail, opened_tags)
      {parsed, tag} ->
        tag_enclose(tag, parsed)
    end
  end

  defp parse_line_with_prefix(markdown) do
    case parse_markup_prefix(markdown) do
      {markdown, tag} ->
        {parse_line(markdown), tag}
      {markdown, tag, special_tag} ->
        {parse_line(markdown), tag, special_tag}
    end
  end

  defp parse_line(markdown, parsed \\ "", opened_tags \\ [])
  defp parse_line("", parsed, _opened_tags), do: parsed
  defp parse_line("\n" <> tail, parsed, _opened_tags), do: {parsed, tail}
  defp parse_line(markdown, parsed, opened_tags) do
    case parse_markup(markdown) do
      {tail, tag} ->
        if tag in opened_tags do
          parse_line(tail, parsed <> tag_close(tag), opened_tags -- [tag])
        else
          parse_line(tail, parsed <> tag_open(tag), [tag | opened_tags])
        end
      unparsed ->
        <<hd::utf8, tail::binary>> = unparsed
        parse_line(tail, <<parsed::binary, hd::utf8>>, opened_tags)
    end
  end

  for {markup, tag} <- @markups_surrounds do
    defp parse_markup(unquote(markup) <> tail), do: {tail, unquote(tag)}
  end
  defp parse_markup(markdown), do: markdown

  for {markup, tag} <- @markups_prefixes do
    defp parse_markup_prefix(unquote("#{markup} ") <> tail), do: {tail, unquote(tag)}
  end
  for {markup, tag, special_tag} <- @markups_specials do
    defp parse_markup_prefix(unquote("#{markup} ") <> tail),
      do: {tail, unquote(tag), unquote(special_tag)}
  end
  defp parse_markup_prefix(markdown), do: {markdown, @markup_default}
end
