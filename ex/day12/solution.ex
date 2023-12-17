defmodule AOC23.Day12 do
  def count(arrangement) do
    {curr, acc} =
      String.codepoints(arrangement)
      |> Enum.reduce({0, []}, fn ch, {curr, acc} ->
        case ch do
          "." ->
            if curr > 0 do
              {0, [curr | acc]}
            else
              {0, acc}
            end

          "#" ->
            {curr + 1, acc}
        end
      end)

    if curr > 0 do
      [curr | acc]
    else
      acc
    end
  end

  def arrangements(group, numbers, i) do
    cond do
      i == String.length(group) ->
        c = Enum.reverse(count(group))

        if length(c) == length(numbers) && c == numbers do
          1
        else
          0
        end

      String.at(group, i) == "?" ->
        a =
          String.slice(group, 0, i) <>
            "#" <>
            String.slice(group, i + 1, String.length(group))

        b =
          String.slice(group, 0, i) <>
            "." <>
            String.slice(group, i + 1, String.length(group))

        arrangements(a, numbers, i + 1) + arrangements(b, numbers, i + 1)

      true ->
        arrangements(group, numbers, i + 1)
    end
  end

  def arrangements([record | _]) do
    [group, numbers] = String.split(record, " ", trim: true)

    numbers =
      String.split(numbers, ",", trim: true)
      |> Enum.map(&String.to_integer/1)

    arrangements(group, numbers, 0)
  end

  def part1(input) do
    input
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(&arrangements/1)
    |> Enum.sum()
  end
end

File.stream!("ex/day12/input.txt") |> AOC23.Day12.part1() |> IO.inspect()
