defmodule Mix.Tasks.Solve do
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    instructions =
      File.stream!("input.txt")
      |> Stream.map(&String.trim/1)

    instructions
    |> Dial.get_password(&Dial.count_zeros_after_rotation/1)
    |> IO.inspect(label: "part 1")

    instructions
    |> Dial.get_password(&Dial.count_all_zeros/1)
    |> IO.inspect(label: "part 2")
  end
end
