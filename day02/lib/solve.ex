defmodule Mix.Tasks.Solve do
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    ranges =
      File.read!("input.txt")
      |> String.trim()
      |> String.split(",")
      |> Stream.map(&parse_range/1)

    ranges
    |> Validator.invalid_id_sum(&Validator.identical_halves?/1)
    |> IO.inspect(label: "part 1")

    ranges
    |> Validator.invalid_id_sum(&Validator.identical_parts?/1)
    |> IO.inspect(label: "part 2")
  end

  defp parse_range(s) do
    [i1, i2] =
      s
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)

    i1..i2
  end
end
