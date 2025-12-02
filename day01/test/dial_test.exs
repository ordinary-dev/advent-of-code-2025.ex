defmodule DialTest do
  use ExUnit.Case
  doctest Dial

  test "example 1" do
    res =
      Dial.get_password(
        [
          "L68",
          "L30",
          "R48",
          "L5",
          "R60",
          "L55",
          "L1",
          "L99",
          "R14",
          "L82"
        ],
        &Dial.count_zeros_after_rotation/1
      )

    assert res == 3
  end

  test "example 2" do
    res =
      Dial.get_password(
        [
          "L68",
          "L30",
          "R48",
          "L5",
          "R60",
          "L55",
          "L1",
          "L99",
          "R14",
          "L82"
        ],
        &Dial.count_all_zeros/1
      )

    assert res == 6
  end
end
