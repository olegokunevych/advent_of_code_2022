defmodule RockPaperScissors do
  @moduledoc """
  Documentation for `RockPaperScissors`.
  """

  @rock 1
  @paper 2
  @scissors 3

  @win 6
  @lose 0
  @draw 3

  @mapping %{
    "A" => %{
      "X" => @rock + @draw,
      "Y" => @paper + @win,
      "Z" => @scissors + @lose
    },
    "B" => %{
      "X" => @rock + @lose,
      "Y" => @paper + @draw,
      "Z" => @scissors + @win
    },
    "C" => %{
      "X" => @rock + @win,
      "Y" => @paper + @lose,
      "Z" => @scissors + @draw
    }
  }

  @strategy_mapping %{
    "X" => %{ # X means you need to lose
      "A" => "Z",
      "B" => "X",
      "C" => "Y"
    },
    "Y" => %{ # Y means you need to end the round in a draw
      "A" => "X",
      "B" => "Y",
      "C" => "Z"
    },
    "Z" => %{ # Z means you need to win
      "A" => "Y",
      "B" => "Z",
      "C" => "X"
    }
  }

  # "Anyway, the second column says how the round needs to end: X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win. Good luck!"

  @doc """
  Plays a game of rock paper scissors and returns the number of wins for the player.

  ## Examples

      iex> RockPaperScissors.play("A Y\\nB X\\nC Z")
      15

      iex> "./input.txt" |> File.read!() |> RockPaperScissors.play()
      14264

  """
  @spec play(String.t()) :: integer()
  def play(input) do
    input
    |> String.split("\n")
    |> Enum.map(&play_round/1)
    |> Enum.sum()
  end

  @doc """
  Plays a game of rock paper scissors and returns the number of wins for the player using ultra strategy.

  ## Examples

      iex> "./input.txt" |> File.read!() |> RockPaperScissors.play_ultra()
      12382

  """
  @spec play_ultra(String.t()) :: integer()
  def play_ultra(input) do
    input
    |> String.split("\n")
    |> Enum.map(&play_ultra_round/1)
    |> Enum.sum()
  end

  ## Private

  defp play_round(""), do: 0

  defp play_round(<<first::binary-size(1), _::binary-size(1), second::binary-size(1)>>) do
    @mapping[first][second]
  end

  defp play_ultra_round(""), do: 0

  defp play_ultra_round(<<first::binary-size(1), _::binary-size(1), second::binary-size(1)>>) do
    xyz = @strategy_mapping[second][first]
    @mapping[first][xyz]
  end
end
