defmodule InventoryTest do
  use ExUnit.Case
  doctest Inventory

  @ranges [
    3..5,
    10..14,
    16..20,
    12..18
  ]

  @ids [
    1,
    5,
    8,
    11,
    17,
    32
  ]

  test "example 1" do
    assert Inventory.count_fresh_ids(@ranges, @ids) == 3
  end

  test "example 2" do
    assert Inventory.ranges_len(@ranges) == 14
  end
end
