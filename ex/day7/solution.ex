defmodule AOC23.Day7 do
  @strengths ?2..?9
             |> Map.new(&{&1, &1 - ?0})
             |> Map.merge(%{
               ?T => 10,
               ?J => 11,
               ?Q => 12,
               ?K => 13,
               ?A => 14
             })

  @strengths2 %{@strengths | ?J => 1}

  def part1(input) do
    input
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [hand, bid] ->
      cards = String.to_charlist(hand)
      freqs = cards |> Enum.frequencies() |> Map.values() |> Enum.sort(:desc)
      scores = Enum.map(cards, &@strengths[&1])
      {freqs, scores, String.to_integer(bid)}
    end)
    |> Enum.sort()
    |> Enum.map(&elem(&1, 2))
    |> Enum.with_index(1)
    |> Enum.map(fn {bid, rank} -> bid * rank end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [hand, bid] ->
      cards = String.to_charlist(hand)
      freqs = cards |> Enum.frequencies()
      {jokers, freqs} = Map.pop(freqs, ?J, 0)
      freqs = Map.values(freqs) |> Enum.sort(:desc)
      freqs = (freqs == [] && [5]) || [hd(freqs) + jokers, tl(freqs)]
      scores = Enum.map(cards, &@strengths2[&1])
      {freqs, scores, String.to_integer(bid)}
    end)
    |> Enum.sort()
    |> Enum.map(&elem(&1, 2))
    |> Enum.with_index(1)
    |> Enum.map(fn {bid, rank} -> bid * rank end)
    |> Enum.sum()
  end
end

File.stream!("day7/input.txt") |> AOC23.Day7.part1() |> IO.inspect()
File.stream!("day7/input.txt") |> AOC23.Day7.part2() |> IO.inspect()
