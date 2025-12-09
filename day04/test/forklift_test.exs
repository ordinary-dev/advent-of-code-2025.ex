defmodule ForkliftTest do
  use ExUnit.Case
  doctest Forklift

  @input [
    "..@@.@@@@.",
    "@@@.@.@.@@",
    "@@@@@.@.@@",
    "@.@@@@..@.",
    "@@.@@@@.@@",
    ".@@@@@@@.@",
    ".@.@.@.@@@",
    "@.@@@.@@@@",
    ".@@@@@@@@.",
    "@.@.@@@.@."
  ]

  test "example 1" do
    assert Forklift.count_available_rolls_once(@input) == 13
  end

  test "example 2" do
    assert Forklift.count_available_rolls(@input) == 43
  end
end
