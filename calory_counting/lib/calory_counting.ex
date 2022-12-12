defmodule CaloryCounting do
  @moduledoc """
  Documentation for `CaloryCounting`.
  """

  @doc """
  Finds the elf with the most calories carried and returns it's sum of calories.

  ## Examples

      iex> CaloryCounting.perform("18814 \\n\\n1927\\n12782 \\n8734\\n10904\\n9548 \\n1493\\n\\n1000")
      45388

      iex> "./input.txt" |> File.read!() |> CaloryCounting.perform()
      69626

  """
  @spec perform(String.t()) :: integer()
  def perform(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&parse_line/1)
    |> Enum.max()
  end

  defp parse_line(""), do: 0

  defp parse_line(line) do
    line
    |> String.split("\n")
    |> Enum.map(fn el -> el |> String.trim() |> parse_line_value() end)
    |> Enum.sum()
  end

  defp parse_line_value(value) do
    case Integer.parse(value) do
      {value, ""} -> value
      _ -> 0
    end
  end
end
