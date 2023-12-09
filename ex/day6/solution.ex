defmodule AOC23.Day6 do
  def part1(input) do
    input
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> tl
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.zip()
    |> Enum.map(fn {time, dist} ->
      Enum.filter(1..time, fn ms ->
        ms * (time - ms) > dist
      end)
      |> Enum.count()
    end)
    |> Enum.product()
  end

  def part2(input) do
    [time, dist] =
      input
      |> Enum.map(&String.trim/1)
      |> Enum.map(fn line ->
        line
        |> String.split(" ", trim: true)
        |> tl
        |> Enum.join()
        |> then(&String.to_integer/1)
      end)

    Enum.filter(1..time, fn ms ->
      ms * (time - ms) > dist
    end)
    |> Enum.count()
  end
end

File.stream!("day6/input.txt") |> AOC23.Day6.part1() |> IO.inspect()
File.stream!("day6/input.txt") |> AOC23.Day6.part2() |> IO.inspect()
