defmodule AOC23.Day5 do
  def to_numbers(s) do
    s
    |> String.split(~r/\D+/)
    |> Enum.filter(&(String.trim(&1) != ""))
    |> Enum.map(&String.to_integer/1)
  end

  def part1(file) do
    {_key, range} =
      file
      |> Enum.map(&String.trim/1)
      |> Enum.reject(&(&1 == ""))
      |> Enum.reduce({"", %{}}, fn line, {key, acc} ->
        case {key, line} do
          {_, "seeds: " <> data} ->
            {"", Map.put(acc, :seeds, to_numbers(data))}

          {_, "seed-to-soil map:"} ->
            {:seed_to_soil, Map.put(acc, :seed_to_soil, [])}

          {_, "soil-to-fertilizer map:"} ->
            {:soil_to_fertilizer, Map.put(acc, :soil_to_fertilizer, [])}

          {_, "fertilizer-to-water map:"} ->
            {:fertilizer_to_water, Map.put(acc, :fertilizer_to_water, [])}

          {_, "water-to-light map:"} ->
            {:water_to_light, Map.put(acc, :water_to_light, [])}

          {_, "light-to-temperature map:"} ->
            {:light_to_temperature, Map.put(acc, :light_to_temperature, [])}

          {_, "temperature-to-humidity map:"} ->
            {:temperature_to_humidity, Map.put(acc, :temperature_to_humidity, [])}

          {_, "humidity-to-location map:"} ->
            {:humidity_to_location, Map.put(acc, :humidity_to_location, [])}

          {key, data} ->
            {key, Map.update!(acc, key, fn v -> [to_numbers(data) | v] end)}
        end
      end)

    %{
      :seeds => seeds
    } = range

    keys = [
      :seed_to_soil,
      :soil_to_fertilizer,
      :fertilizer_to_water,
      :water_to_light,
      :light_to_temperature,
      :temperature_to_humidity,
      :humidity_to_location
    ]

    Enum.map(seeds, fn seed ->
      Enum.reduce(keys, seed, fn key, acc ->
        matched =
          Enum.filter(Map.get(range, key), fn [_d, s, l] ->
            s <= acc and acc <= s + l
          end)

        case matched do
          [] ->
            acc

          [[d, s, _l] | _] ->
            d + (acc - s)
        end
      end)
    end)
    |> Enum.min()
  end
end

File.stream!("day5/input.txt") |> AOC23.Day5.part1() |> IO.inspect()
