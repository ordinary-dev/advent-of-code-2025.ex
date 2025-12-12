defmodule Mix.Tasks.Solve do
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    lines = File.stream!("input.txt")

    {horizontal_lists, signs} = Parser.parse_horizontal_worksheet(lines)

    Math.apply_operations(horizontal_lists, signs)
    |> IO.inspect(label: "Part 1")

    {vertical_lists, _signs} = Parser.parse_vertical_worksheet(lines)

    Math.apply_operations_to_vertical_lists(vertical_lists, signs)
    |> IO.inspect(label: "Part 2")
  end
end
