defmodule MathTest do
  use ExUnit.Case
  doctest Math

  @lines [
    "123 328  51 64 ",
    " 45 64  387 23 ",
    "  6 98  215 314",
    "*   +   *   +  ",
  ]

  test "example 1" do
    {lists, operations} = Parser.parse_horizontal_worksheet(@lines)
    assert Math.apply_operations(lists, operations) == 4277556
  end

  test "example 2" do
    {lists, operations} = Parser.parse_vertical_worksheet(@lines)
    assert Math.apply_operations_to_vertical_lists(lists, operations) == 3263827
  end
end
