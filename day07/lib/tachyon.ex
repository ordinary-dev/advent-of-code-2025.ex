defmodule Tachyon do
  def count_splits(start_position, lines) do
    {sum, _} =
      lines
      |> Enum.reduce({0, [start_position]}, fn line, acc -> count_splits_in_line(line, acc) end)

    sum
  end

  def count_timelines(start_position, lines) do
    positions = [{start_position, 1}]

    lines
    |> Enum.reduce(positions, fn line, acc -> simulate_timelines(line, acc) end)
    |> Enum.map(fn {_pos, counter} -> counter end)
    |> Enum.sum()
  end

  defp count_splits_in_line(line, {sum, positions}) do
    splitters = get_splitters(line)

    new_positions =
      positions
      |> Enum.flat_map(fn pos -> next_position(pos, splitters) end)

    new_sum = sum + Enum.count(new_positions) - Enum.count(positions)
    {new_sum, Enum.uniq(new_positions)}
  end

  defp simulate_timelines(line, positions) do
    splitters = get_splitters(line)

    positions
    |> Enum.flat_map(fn pos -> next_position(pos, splitters) end)
    |> merge()
  end

  defp get_splitters(line) do
    line
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.filter(fn {s, _idx} -> s == "^" end)
    |> Enum.map(fn {_s, idx} -> idx end)
  end

  defp next_position({pos, counter}, splitters) do
    if Enum.member?(splitters, pos) do
      [{pos-1, counter}, {pos+1, counter}]
    else
      [{pos, counter}]
    end
  end

  defp next_position(pos, splitters) do
    if Enum.member?(splitters, pos) do
      [pos-1, pos+1]
    else
      [pos]
    end
  end

  defp merge(positions) do
    positions
    |> Enum.group_by(fn {pos, _counter} -> pos end, fn {_pos, counter} -> counter end)
    |> Map.to_list()
    |> Enum.map(fn {pos, accs} -> {pos, Enum.sum(accs)} end)
  end
end
