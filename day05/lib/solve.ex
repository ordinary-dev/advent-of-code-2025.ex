defmodule Mix.Tasks.Solve do
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    {ranges, ids, _} =
      File.stream!("input.txt")
      |> Enum.map(&String.trim/1)
      |> Enum.reduce({[], [], false}, &parse_database/2)

    Inventory.count_fresh_ids(ranges, ids)
    |> IO.inspect(label: "Part 1")

    Inventory.ranges_len(ranges)
    |> IO.inspect(label: "Part 2")
  end

  defp parse_database(line, {ranges, ids, true}) do
    id = String.to_integer(line)
    {ranges, [id | ids], true}
  end

  defp parse_database("", {ranges, ids, false}) do
    {ranges, ids, true}
  end

  defp parse_database(line, {ranges, ids, false}) do
    [i1, i2] =
      line
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)

    range = i1..i2
    {[range | ranges], ids, false}
  end
end
