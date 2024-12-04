defmodule DayThree do
  def part_one do
    get_stream()
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.flat_map(fn x -> mul_finder(x) end)
    |> Enum.map(fn [_, first, second] -> String.to_integer(first) * String.to_integer(second) end)
    |> Enum.sum()
  end

  def get_stream do
    {_, base_path} = File.cwd()
    input_file = "#{base_path}/inputs/03.txt"
    File.stream!(input_file)
  end

  def mul_finder(memory) do
    exp = ~r/mul\((\d{1,3}),(\d{1,3})\)/
    Regex.scan(exp, memory)
  end
end
