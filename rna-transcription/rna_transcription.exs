defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna, rna \\ [])
  def to_rna([head | tail], rna) do
    nucleotide = case head do
      ?G -> ?C
      ?C -> ?G
      ?T -> ?A
      ?A -> ?U
    end
    to_rna(tail, [nucleotide | rna])
  end
  def to_rna([], rna), do: Enum.reverse(rna)
end
