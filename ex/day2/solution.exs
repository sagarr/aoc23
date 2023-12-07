defmodule AOC23.Day2 do
  def part1(file) do
    file
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ":"))
    |> Stream.map(fn [game | [records | _]] ->
      [_ | [number | _]] =
        game
        |> String.split(~r/\D+/)

      cube_set =
        String.split(records, ";")
        |> Enum.map(&String.trim/1)
        |> Enum.flat_map(&String.split(&1, ~r/,/))
        |> Enum.map(&String.trim/1)
        |> Enum.map(fn str ->
          [number | [color | _]] = String.split(str, " ")
          {String.trim(color), String.to_integer(number)}
        end)

      {String.to_integer(number), cube_set}
    end)
    |> Enum.reject(fn {_game, sets} ->
      Enum.any?(sets, fn {color, num} ->
        (color == "blue" && num > 14) ||
          (color == "red" && num > 12) ||
          (color == "green" && num > 13)
      end)
    end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def part2(file) do
    file
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ":"))
    |> Stream.map(fn [_game | [records | _]] ->
      String.split(records, ";")
      |> Enum.map(&String.trim/1)
      |> Enum.flat_map(&String.split(&1, ~r/,/))
      |> Enum.map(&String.trim/1)
      |> Enum.map(fn str ->
        [number | [color | _]] = String.split(str, " ")
        {String.trim(color), String.to_integer(number)}
      end)
    end)
    |> Enum.map(
      &Enum.reduce(&1, %{}, fn {color, number}, acc ->
        case Map.fetch(acc, color) do
          {:ok, _existing_number} ->
            Map.update!(acc, color, fn current -> max(current, number) end)

          :error ->
            Map.put(acc, color, number)
        end
      end)
    )
    |> Enum.map(&Enum.reduce(&1, 1, fn {_k, v}, acc -> acc * v end))
    |> Enum.sum()
  end
end

File.stream!("day2/input.txt") |> AOC23.Day2.part1() |> IO.inspect()
File.stream!("day2/input.txt") |> AOC23.Day2.part2() |> IO.inspect()
