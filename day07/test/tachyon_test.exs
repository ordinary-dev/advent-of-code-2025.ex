defmodule TachyonTest do
  use ExUnit.Case
  doctest Tachyon

  @start_pos 7

  @lines [
    "...............",
    ".......^.......",
    "...............",
    "......^.^......",
    "...............",
    ".....^.^.^.....",
    "...............",
    "....^.^...^....",
    "...............",
    "...^.^...^.^...",
    "...............",
    "..^...^.....^..",
    "...............",
    ".^.^.^.^.^...^.",
    "...............",
  ]

  test "example 1" do
    assert Tachyon.count_splits(@start_pos, @lines) == 21
  end

  test "example 2" do
    assert Tachyon.count_timelines(@start_pos, @lines) == 40
  end
end
