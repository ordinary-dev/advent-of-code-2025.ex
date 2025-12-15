defmodule Mix.Tasks.Solve do
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    {[first_line], lines} =
      File.stream!("input.txt")
      |> Enum.split(1)

    start_position =
      first_line
      |> String.graphemes()
      |> Enum.find_index(fn s -> s == "S" end)

    Tachyon.count_splits(start_position, lines)
    |> IO.inspect(label: "Part 1")

    Tachyon.count_timelines(start_position, lines)
    |> IO.inspect(label: "Part 2")
  end
end
