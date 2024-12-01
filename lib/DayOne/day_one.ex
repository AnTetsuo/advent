defmodule DayOne do
  def part_one do
    {_, base_path} = File.cwd()
    input_file = "#{base_path}/inputs/01.txt"
    stream = File.stream!(input_file)

      stream
      |> Enum.map(&String.split/1)
      |> Enum.map(fn [first, second] -> {String.to_integer(first), String.to_integer(second)} end)
      |> Enum.unzip()
      |> Tuple.to_list()
      |> sort_location_ids()
      |> Enum.map(fn {first, second} -> abs(second - first) end)
      |> Enum.sum()
  end

  def sort_location_ids([first, second]) do
    Enum.zip([Enum.sort(first), Enum.sort(second)])
  end
end
