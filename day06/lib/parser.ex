defmodule Parser do
  def parse_horizontal_worksheet(lines) do
    {lists_of_strs, [signs]} =
      lines
      |> Enum.map(&String.split/1)
      |> Enum.split(-1)

    lists_of_ints =
      lists_of_strs
      |> Enum.map(fn list ->
        Enum.map(list, &String.to_integer/1)
      end)

    {lists_of_ints, signs}
  end

  def parse_vertical_worksheet(lines) do
    {strings, [signs]} = Enum.split(lines, -1)

    lists_of_chars =
      strings
      |> Enum.map(fn line -> String.split(line, "", trim: true) end)

    numbers =
      parse_vertical_numbers([], lists_of_chars, true)
      |> Enum.reverse()

    sign_list = String.split(signs)

    {numbers, sign_list}
  end

  defp parse_vertical_numbers(acc, lists, start_new_group) do
    if Enum.count(hd(lists)) == 0 do
      acc
    else
      column =
        lists
        |> extract_first_column()
        |> Enum.join()
        |> String.trim()

      tail = extract_tail_columns(lists)

      # TODO: extract into separate function.
      if column == "" do
        parse_vertical_numbers(acc, tail, true)
      else
        num = String.to_integer(column)
        if start_new_group do
          new_hd = [num]
          new_acc = [new_hd | acc]
          parse_vertical_numbers(new_acc, tail, false)
        else
          [hd|tl] = acc
          new_hd = [num|hd]
          new_acc = [new_hd | tl]
          parse_vertical_numbers(new_acc, tail, false)
        end
      end
    end
  end

  defp extract_first_column(lists) do
    Enum.map(lists, &Kernel.hd/1)
  end

  defp extract_tail_columns(lists) do
    Enum.map(lists, &Kernel.tl/1)
  end
end
