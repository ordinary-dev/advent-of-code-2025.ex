defmodule ValidatorTest do
  use ExUnit.Case
  doctest Validator

  @input [
    11..22,
    95..115,
    998..1012,
    1_188_511_880..1_188_511_890,
    222_220..222_224,
    1_698_522..1_698_528,
    446_443..446_449,
    38_593_856..38_593_862,
    565_653..565_659,
    824_824_821..824_824_827,
    2_121_212_118..2_121_212_124
  ]

  test "example 1" do
    assert Validator.invalid_id_sum(@input, &Validator.identical_halves?/1) == 1_227_775_554
  end

  test "example 2" do
    assert Validator.invalid_id_sum(@input, &Validator.identical_parts?/1) == 4_174_379_265
  end
end
