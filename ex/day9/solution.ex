defmodule AOC23.Day9 do
  def extrapolate_forward(hist) do
    [_ | rem] = hist
    diff = Enum.zip_with([hist, rem], fn [a, b] -> b - a end)

    if(Enum.all?(diff, fn x -> x == 0 end)) do
      List.last(hist)
    else
      List.last(hist) + extrapolate_forward(diff)
    end
  end

  def extrapolate_backward(hist) do
    [_ | rem] = hist
    diff = Enum.zip_with([hist, rem], fn [a, b] -> b - a end)

    if(Enum.all?(diff, fn x -> x == 0 end)) do
      List.first(hist)
    else
      List.first(hist) - extrapolate_backward(diff)
    end
  end

  def part1(input) do
    input
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn line ->
      line
      |> Enum.flat_map(&String.split(&1, " ", trim: true))
      |> Enum.map(&String.to_integer(&1))
    end)
    |> Enum.map(fn hist ->
      extrapolate_forward(hist)
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn line ->
      line
      |> Enum.flat_map(&String.split(&1, " ", trim: true))
      |> Enum.map(&String.to_integer(&1))
    end)
    |> Enum.map(fn hist ->
      extrapolate_backward(hist)
    end)
    |> Enum.sum()
  end
end

File.stream!("day9/input.txt") |> AOC23.Day9.part1() |> IO.inspect()
File.stream!("day9/input.txt") |> AOC23.Day9.part2() |> IO.inspect()
