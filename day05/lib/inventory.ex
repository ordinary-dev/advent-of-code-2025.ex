defmodule Inventory do
  def count_fresh_ids(ranges, ids) do
    ids
    |> Enum.filter(fn x -> in_range?(x, ranges) end)
    |> Enum.count()
  end

  defp in_range?(id, ranges) do
    Enum.any?(ranges, fn range -> Enum.member?(range, id) end)
  end

  def ranges_len(ranges) do
    ranges
    |> Enum.reduce([], &add_unique_range/2)
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp add_unique_range(range, prev_ranges) do
    res =
      prev_ranges
      |> Enum.reduce([range], &remove_intersecting_parts/2)

    res ++ prev_ranges
  end

  defp remove_intersecting_parts(prev_range, current_parts) do
    current_parts
    |> Enum.flat_map(fn part -> substract_range(part, prev_range) end)
  end

  defp substract_range(r1..r2//_, prev1..prev2//_) when r2 < prev1 or prev2 < r1 do
    [r1..r2]
  end

  defp substract_range(r1..r2//_, prev1..prev2//_) when prev1 <= r1 and prev2 >= r2 do
    []
  end

  defp substract_range(r1..r2//_, prev1..prev2//_) when r2 >= prev1 and r2 <= prev2 do
    [r1..(prev1 - 1)]
  end

  defp substract_range(r1..r2//_, prev1..prev2//_) when r1 >= prev1 and r1 <= prev2 do
    [(prev2 + 1)..r2]
  end

  defp substract_range(r1..r2//_, prev1..prev2//_) do
    [r1..(prev1 - 1), (prev2 + 1)..r2]
  end
end
