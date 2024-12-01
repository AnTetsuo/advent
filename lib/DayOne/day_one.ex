defmodule DayOne do
  def part_one do
    get_stream()
    |> set_location_ids_list()
    |> sort_location_ids()
    |> Enum.map(fn {first, second} -> abs(second - first) end)
    |> Enum.sum()
  end

  def part_two do
    [first_location_ids, second_location_ids] =
      get_stream()
      |> set_location_ids_list()

    first_location_ids
    |> Enum.filter(fn id -> id in second_location_ids end)
    |> Enum.map(fn location_id -> get_similarity_score(location_id, second_location_ids) end)
    |> Enum.sum()
  end

  def get_stream() do
    {_, base_path} = File.cwd()
    input_file = "#{base_path}/inputs/01.txt"
    File.stream!(input_file)
  end

  def set_location_ids_list(stream) do
    stream
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [first, second] -> {String.to_integer(first), String.to_integer(second)} end)
    |> Enum.unzip()
    |> Tuple.to_list()
  end

  def sort_location_ids([first, second]) do
    Enum.zip([Enum.sort(first), Enum.sort(second)])
  end

  def get_similarity_score(location_id, second_location_ids) do
    location_id * Enum.count(second_location_ids, fn x -> x == location_id end)
  end
end
