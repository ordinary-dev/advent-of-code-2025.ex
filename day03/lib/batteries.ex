defmodule Batteries do
  def total_joitage(packs, active_batteries_per_pack) do
    packs
    |> Stream.map(fn pack -> max_pack_joitage(pack, active_batteries_per_pack) end)
    |> Enum.sum()
  end

  defp max_pack_joitage(pack, active_batteries_per_pack) do
    digits =
      pack
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)

    {total_joitage, _} =
      1..active_batteries_per_pack
      |> Enum.reduce({0, 0}, fn n, {sum, start_idx} ->
        {joitage, new_start_idx} =
          pick_nth_battery(digits, n, active_batteries_per_pack, start_idx)

        {sum * 10 + joitage, new_start_idx + 1}
      end)

    total_joitage
  end

  defp pick_nth_battery(digits, n, active_batteries_per_pack, start_idx) do
    end_idx = -active_batteries_per_pack - 1 + n

    {max_element, max_idx} =
      digits
      |> Enum.slice(start_idx..end_idx//1)
      |> max()

    {max_element, start_idx + max_idx}
  end

  defp max(digits) do
    max(digits, 0, 0, -1)
  end

  defp max([], _head_idx, max_element, max_index), do: {max_element, max_index}

  defp max([9 | _tail], head_idx, _max_element, _max_index), do: {9, head_idx}

  defp max([hd | tail], head_idx, max_element, max_index) do
    if hd > max_element do
      max(tail, head_idx + 1, hd, head_idx)
    else
      max(tail, head_idx + 1, max_element, max_index)
    end
  end
end
