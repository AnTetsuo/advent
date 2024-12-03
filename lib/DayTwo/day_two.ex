defmodule DayTwo do
  def part_one do
    get_stream()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn report -> Enum.map(report, &String.to_integer/1) end)
    |> Enum.map(fn report -> safe_check(report) end)
    |> Enum.filter(fn {_, _, safe} -> safe == :safe end)
    |> Enum.count()
  end

  def get_stream do
    {_, base_path} = File.cwd()
    input_file = "#{base_path}/inputs/02.txt"
    File.stream!(input_file)
  end

  def safe_check(report) do
    Enum.reduce_while(report, {0, :initial, :safe}, fn x, {value, is_increase, _safe} ->
      increase_check = x > value

      cond do
        value == 0 ->
          {:cont, {x, is_increase, :safe}}

        value == x ->
          {:halt, {value, is_increase, :unsafe}}

        abs(value - x) > 3 ->
          {:halt, {value, is_increase, :unsafe}}

        is_increase != :initial and increase_check != is_increase ->
          {:halt, {value, is_increase, :unsafe}}

        true ->
          {:cont, {x, increase_check, :safe}}
      end
    end)
  end
end
