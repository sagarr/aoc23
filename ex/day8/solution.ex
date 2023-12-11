defmodule AOC23.Day8 do
  def part1(input) do
    [dirs | map] =
      input
      |> Enum.flat_map(&String.split(&1, "\n", trim: true))
      |> Enum.reject(&(&1 == []))

    map =
      Enum.map(map, &String.split(&1, " = "))
      |> Enum.map(fn [from, values] ->
        left_right =
          Regex.scan(~r/[A-Z]+/, values)
          |> Enum.map(fn [match] -> match end)

        {from, left_right}
      end)
      |> Map.new()

    String.codepoints(dirs)
    |> Stream.cycle()
    |> Enum.reduce_while({"AAA", 1}, fn dir, {from, hop} ->
      [left, right] = Map.get(map, from)

      to =
        if dir == "L" do
          left
        else
          right
        end

      if to == "ZZZ" do
        {:halt, {"ZZZ", hop}}
      else
        {:cont, {to, hop + 1}}
      end
    end)
    |> then(&elem(&1, 1))
  end

  def follow(map, dirs, [], key, n) do
    follow(map, dirs, dirs, key, n)
  end

  def follow(map, dirs, [dir | rest], key, n) do
    i =
      case dir do
        "L" -> 0
        "R" -> 1
      end

    key = elem(map[key], i)

    if(String.ends_with?(key, "Z")) do
      n + 1
    else
      follow(map, dirs, rest, key, n + 1)
    end
  end

  def part2(input) do
    [dirs | map] =
      input
      |> Enum.flat_map(&String.split(&1, "\n", trim: true))
      |> Enum.reject(&(&1 == []))

    map =
      Enum.map(map, &String.split(&1, " = "))
      |> Enum.map(fn [from, values] ->
        [left, right] =
          Regex.scan(~r/[a-zA-Z0-9]+/, values)
          |> Enum.map(fn [match] -> match end)

        {from, {left, right}}
      end)
      |> Map.new()

    dirs = String.codepoints(dirs)

    Map.keys(map)
    |> Enum.filter(&String.ends_with?(&1, "A"))
    |> Enum.map(&follow(map, dirs, [], &1, 0))
    |> Enum.reduce(fn x, y -> div(x * y, Integer.gcd(x, y)) end)
  end
end

File.stream!("day8/input.txt") |> AOC23.Day8.part1() |> IO.inspect()
File.stream!("day8/input.txt") |> AOC23.Day8.part2() |> IO.inspect()
