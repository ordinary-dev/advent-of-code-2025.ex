defmodule BatteriesTest do
  use ExUnit.Case
  doctest Batteries

  @input [
    "987654321111111",
    "811111111111119",
    "234234234234278",
    "818181911112111"
  ]

  test "example 1" do
    assert Batteries.total_joitage(@input, 2) == 357
  end

  test "example 2" do
    assert Batteries.total_joitage(@input, 12) == 3_121_910_778_619
  end
end
