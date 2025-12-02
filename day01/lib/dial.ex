defmodule Dial do
  def get_password(instructions, algo) do
    instructions
    |> Stream.scan(50, &rotate/2)
    |> algo.()
  end

  def count_zeros_after_rotation(positions) do
    is_zero = fn x -> rem(x, 100) == 0 end

    positions
    |> Stream.filter(is_zero)
    |> Enum.count()
  end

  def count_all_zeros(positions) do
    crossings =
      positions
      |> Stream.transform(50, fn new_pos, old_pos ->
        res = zero_crossings(old_pos, new_pos)
        {[res], new_pos}
      end)
      |> Enum.sum()

    crossings + count_zeros_after_rotation(positions)
  end

  defp rotate("L" <> delta, position) do
    int_delta = String.to_integer(delta)
    position - int_delta
  end

  defp rotate("R" <> delta, position) do
    int_delta = String.to_integer(delta)
    position + int_delta
  end

  def zero_crossings(old_pos, new_pos) do
    [low, high] = Enum.sort([old_pos, new_pos])

    # Skip values that represent 0.
    low = increase_if_zero(low)
    high = decrease_if_zero(high)

    segment_a = to_segment_number(low)
    segment_b = to_segment_number(high)

    abs(segment_b - segment_a)
  end

  defp to_segment_number(x) when x >= 0, do: div(x, 100)
  defp to_segment_number(x), do: div(x + 1, 100) - 1

  defp increase_if_zero(x) when rem(x, 100) == 0, do: x + 1
  defp increase_if_zero(x), do: x

  defp decrease_if_zero(x) when rem(x, 100) == 0, do: x - 1
  defp decrease_if_zero(x), do: x
end
