defmodule Math do
  def apply_operations(lists, operations) do
    add_result(0, lists, operations)
  end

  # TODO: transform the first part to reuse this function.
  def apply_operations_to_vertical_lists(lists, operations) do
    Enum.zip(lists, operations)
    |> Enum.reduce(0, fn {num_group, op}, acc ->
      op_fun = map_operation(op)
      acc + Enum.reduce(num_group, op_fun)
    end)
  end

  defp add_result(sum, _lists, []), do: sum

  defp add_result(sum, lists, [op|operations]) do
    {first_column, other_columns} = split(lists)
    op_fun = map_operation(op)
    res = Enum.reduce(first_column, op_fun)
    add_result(sum + res, other_columns, operations)
  end

  defp split(lists) do
    first_column =
      lists
      |> Enum.map(&Kernel.hd/1)

    other_columns =
      lists
      |> Enum.map(&Kernel.tl/1)

    {first_column, other_columns}
  end

  defp map_operation(op) do
    case op do
      "+" -> &Kernel.+/2
      "*" -> &Kernel.*/2
    end
  end
end
