defmodule Mix.Tasks.Solve do
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    packs =
      File.stream!("input.txt")
      |> Stream.map(&String.trim/1)

    packs
    |> Batteries.total_joitage(2)
    |> IO.inspect(label: "part 1")

    packs
    |> Batteries.total_joitage(12)
    |> IO.inspect(label: "part 2")
  end
end
