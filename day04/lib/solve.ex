defmodule Mix.Tasks.Solve do
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    grid =
      File.stream!("input.txt")
      |> Stream.map(&String.trim/1)

    grid
    |> Forklift.count_available_rolls_once()
    |> IO.inspect(label: "part 1")

    grid
    |> Forklift.count_available_rolls()
    |> IO.inspect(label: "part 2")
  end
end
