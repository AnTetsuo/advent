defmodule DayFour do
  def part_one do
    xwords = String.split(get_stream(), "\n", trim: true)

    xmas_and_samx_x =
      Enum.map(xwords, fn x -> count_xmas(x) end)
      |> Enum.sum()

    max_len =
      Enum.map(xwords, fn x -> String.length(x) end)
      |> Enum.max()

    lists_char =
      xwords
      |> Enum.map(fn x -> String.split(x, "", trim: true) end)

    xmas_and_samx_y =
      for index <- 0..(max_len - 1) do
        Enum.map(lists_char, fn list_char ->
          Enum.at(list_char, index)
        end)
      end
      |> Enum.map(&Enum.join/1)
      |> Enum.map(fn x -> count_xmas(x) end)
      |> Enum.sum()

    xmas_and_samx_diag_l =
      for _ <- 0..(max_len - 1) do
        Enum.map(lists_char, fn list_char ->
          list_char
          |> Enum.with_index()
          |> Enum.map(fn {x, _i} -> x end)
        end)
      end

    for pdx <- 0..(max_len - 1) do
      matrix =
        if pdx > 0,
          do:
            Enum.take(lists_char, - (max_len - 1 - pdx)),
          else: lists_char

      for {row, idx} <- Enum.with_index(matrix), {col, ^idx} <- Enum.with_index(row), do: col
      # xmas_and_samx_x + xmas_and_samx_y
    end
  end

  def get_stream do
    {_, base_path} = File.cwd()
    input_file = "#{base_path}/inputs/04.txt"
    File.read!(input_file)
  end

  def count_xmas(line) do
    xmas = Regex.scan(~r/XMAS/, line)
    samx = Regex.scan(~r/XMAS/, String.reverse(line))

    nxmas = if Enum.empty?(xmas), do: 0, else: Enum.count(Enum.flat_map(xmas, fn x -> x end))
    nsamx = if Enum.empty?(samx), do: 0, else: Enum.count(Enum.flat_map(samx, fn x -> x end))

    nxmas + nsamx
  end
end
