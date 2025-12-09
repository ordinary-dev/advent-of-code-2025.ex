# This solution is slow.
defmodule Forklift do
  @roll "@"
  @square_size 3
  @padding_size 1
  @threshold 4

  def count_available_rolls_once(grid) do
    padded_grid = pad_grid(grid)

    get_coords_of_available_rolls(padded_grid)
    |> Enum.count()
  end

  def count_available_rolls(grid) do
    padded_grid = pad_grid(grid)
    count_available_rolls(padded_grid, 0)
  end

  defp pad_grid(grid) do
    grid
    |> Enum.map(&String.graphemes/1)
    |> add_padding(@padding_size)
  end

  defp get_coords_of_available_rolls(grid) do
    rows = length(grid)

    cols =
      grid
      |> hd()
      |> length()

    available_rolls =
      for row <- @padding_size..(rows - @padding_size * 2),
          col <- @padding_size..(cols - @padding_size * 2) do
        square = extract_square(grid, row, col)
        if is_available(square), do: {row, col}, else: nil
      end

    available_rolls
    |> Enum.reject(&Kernel.is_nil/1)
  end

  defp count_available_rolls(padded_grid, sum) do
    coords = get_coords_of_available_rolls(padded_grid)

    case coords do
      [] ->
        sum

      _ ->
        new_grid = remove_rolls(padded_grid, coords)
        count_available_rolls(new_grid, sum + Enum.count(coords))
    end
  end

  defp add_padding(grid, size) do
    row_len = Enum.count(hd(grid)) + size * 2
    empty_row = List.duplicate(".", row_len)
    vertical_padding = List.duplicate(empty_row, size)

    h_padding = List.duplicate(".", size)

    padded_rows =
      grid
      |> Enum.map(fn row -> h_padding ++ row ++ h_padding end)

    vertical_padding ++ padded_rows ++ vertical_padding
  end

  defp remove_rolls(grid, coords) do
    rows = length(grid)
    cols = length(hd(grid))

    for x <- 0..(rows - 1) do
      for y <- 0..(cols - 1) do
        element =
          grid
          |> Enum.at(x)
          |> Enum.at(y)

        if element == @roll and Enum.member?(coords, {x, y}), do: ".", else: element
      end
    end
  end

  defp extract_square(grid, row, col) do
    row_range = get_range(row)
    col_range = get_range(col)

    grid
    |> Enum.slice(row_range)
    |> Enum.map(fn row -> Enum.slice(row, col_range) end)
  end

  defp get_range(idx) do
    range_start = idx - @padding_size
    range_end = range_start + @square_size - 1
    range_start..range_end
  end

  defp is_available(square) do
    middle_idx = div(Enum.count(square), 2)

    middle =
      square
      |> Enum.at(middle_idx)
      |> Enum.at(middle_idx)

    if middle == @roll do
      count_rolls(square) - 1 < @threshold
    else
      false
    end
  end

  defp count_rolls(square) do
    square
    |> Enum.map(&count_rolls_in_row/1)
    |> Enum.sum()
  end

  defp count_rolls_in_row(row) do
    row
    |> Enum.map(fn x -> x == @roll end)
    |> Enum.count(fn x -> x end)
  end
end
