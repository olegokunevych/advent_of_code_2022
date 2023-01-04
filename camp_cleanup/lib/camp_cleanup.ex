defmodule CampCleanup do
  @moduledoc """
  Documentation for `CampCleanup`.
  """

  @doc """
  Returns how many assignment pairs does one range fully contain the other.
  Reflects how many elves should be facilitated.

  ## Examples

      iex> CampCleanup.facilitate("2-4,6-8\\n2-3,4-5\\n5-7,7-9\\n2-8,3-7\\n6-6,4-6\\n2-6,4-8")
      2

      iex> "./input.txt" |> File.read!() |> CampCleanup.facilitate()
      532

  """
  @spec facilitate(input :: binary) :: integer
  def facilitate(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.count(&fully_contains?/1)
  end

  @doc """
  Returns how many assignment pairs does one range overlaps the other.
  Reflects how many elves should be warned about possible facilitation

  ## Examples

      iex> CampCleanup.warn("2-4,6-8\\n2-3,4-5\\n5-7,7-9\\n2-8,3-7\\n6-6,4-6\\n2-6,4-8")
      4

      iex> "./input.txt" |> File.read!() |> CampCleanup.warn()
      854

  """
  @spec warn(input :: binary) :: integer
  def warn(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.count(&overlaps?/1)
  end

  defp fully_contains?([""]), do: false

  defp fully_contains?([
         first,
         second
       ]) do
    [r1_start, r1_end] = String.split(first, "-")
    [r2_start, r2_end] = String.split(second, "-")

    (String.to_integer(r1_start) <= String.to_integer(r2_start) and
       String.to_integer(r1_end) >= String.to_integer(r2_end)) or
      (String.to_integer(r2_start) <= String.to_integer(r1_start) and
         String.to_integer(r2_end) >= String.to_integer(r1_end))
  end

  defp overlaps?([""]), do: false

  defp overlaps?([
         first,
         second
       ]) do
    [r1_start, r1_end] = String.split(first, "-")
    [r2_start, r2_end] = String.split(second, "-")
    mapset_1 = (String.to_integer(r1_start)..String.to_integer(r1_end)) |> Enum.into(MapSet.new())
    mapset_2 = (String.to_integer(r2_start)..String.to_integer(r2_end)) |> Enum.into(MapSet.new())
    # dbg()
    MapSet.intersection(mapset_1, mapset_2) |> MapSet.size() > 0
  end
end
