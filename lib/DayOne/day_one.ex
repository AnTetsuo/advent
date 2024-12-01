defmodule DayOne do
  def input do
    {_, base_path} = File.cwd()
    input_file = "#{base_path}/inputs/01.txt"
    stream = File.stream!(input_file)

    stream
    |> Enum.map(&String.trim/1)
  end
end
