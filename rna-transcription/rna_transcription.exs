defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna, rna \\ [])
  def to_rna([n | d], rna) do
    to_rna(d, rna ++ [cond do
      n == ?G -> ?C
      n == ?C -> ?G
      n == ?T -> ?A
      n == ?A -> ?U
    end])
  end
  def to_rna([], rna), do: rna
end
