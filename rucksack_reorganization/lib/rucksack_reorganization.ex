defmodule RucksackReorganization do
  @moduledoc """
  Documentation for `RucksackReorganization`.
  """

  @lower_case_margin 96
  @upper_case_margin 38

  @doc """
  Finds the priorities and returns it's sum.

  ## Examples

      iex> RucksackReorganization.sum_of_priorities("vJrwpWtwJgWrhcsFMMfFFhFp\\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\\nPmmdzqPrVvPwwTWBwg\\nwMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\\nttgJtRGJQctTZtZT\\nCrZsJsPPZsGzwwsLwLmpwMDw")
      157

      iex> "./input.txt" |> File.read!() |> RucksackReorganization.sum_of_priorities()
      7428

  """
  def sum_of_priorities(input) do
    input
    |> String.split("\n")
    |> Enum.map(&find_priority/1)
    |> Enum.sum()
  end

  @doc """
  Finds the priorities in groups of three elves and returns it's sum.

  ## Examples

      iex> RucksackReorganization.sum_of_groupped_priorities("vJrwpWtwJgWrhcsFMMfFFhFp\\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\\nPmmdzqPrVvPwwTWBwg\\nwMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\\nttgJtRGJQctTZtZT\\nCrZsJsPPZsGzwwsLwLmpwMDw")
      70

      iex> "./input.txt" |> File.read!() |> RucksackReorganization.sum_of_groupped_priorities()
      2650

  """
  def sum_of_groupped_priorities(input) do
    input
    |> String.split("\n")
    |> Enum.chunk_every(3)
    |> Enum.map(&find_group_priority/1)
    |> Enum.sum()
  end

  defp find_priority(""), do: 0

  defp find_priority(line) do
    {first, second} = String.split_at(line, div(String.length(line), 2))

    first
    |> String.myers_difference(second)
    |> Keyword.get(:eq)
    |> priority_value_by_item()
  end

  defp find_group_priority(lines) do
    lines
    |> Enum.sort_by(&byte_size/1)
    |> get_priority_in_group()
    |> priority_value_by_item()
  end

  defp get_priority_in_group([head | tail]) do
    head
    |> String.split("", trim: true)
    |> Enum.find(fn byte ->
      tail |> Enum.all?(fn item -> String.contains?(item, byte) end)
    end)
  end

  defp priority_value_by_item(nil), do: 0

  defp priority_value_by_item(item) do
    margin = if String.upcase(item) == item, do: @upper_case_margin, else: @lower_case_margin

    item
    |> String.to_charlist()
    |> Enum.at(0)
    |> Kernel.-(margin)
  end
end
