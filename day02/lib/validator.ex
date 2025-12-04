# This solution is slow, suggestions are welcome.
defmodule Validator do
  def invalid_id_sum(ranges, algo) do
    ranges
    |> Enum.map(fn range -> sum_invalid_ids_from_range(range, algo) end)
    |> Enum.sum()
  end

  defp sum_invalid_ids_from_range(range, algo) do
    range
    |> Stream.filter(algo)
    |> Enum.sum()
  end

  def identical_halves?(x) do
    s = Integer.to_string(x)
    len = String.length(s)

    if rem(len, 2) == 0 do
      middle = div(len, 2)
      {s1, s2} = String.split_at(s, middle)
      s1 == s2
    else
      false
    end
  end

  def identical_parts?(x) do
    s = Integer.to_string(x)
    len = String.length(s)
    part_lengths = 1..div(len, 2)//1

    part_lengths
    |> Enum.any?(fn part_len -> identical_parts?(s, part_len) end)
  end

  def identical_parts?(s, part_len) do
    {pattern, rest} = String.split_at(s, part_len)
    identical_parts?(rest, pattern, part_len)
  end

  def identical_parts?("", _pattern, _part_len), do: true

  def identical_parts?(s, pattern, part_len) do
    {first_part, rest} = String.split_at(s, part_len)

    if first_part == pattern do
      identical_parts?(rest, pattern, part_len)
    else
      false
    end
  end
end
