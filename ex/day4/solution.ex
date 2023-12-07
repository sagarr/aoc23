defmodule AOC23.Day4 do
  def part1(file) do
    file
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, "|"))
    |> Enum.map(fn [head | my_nums] ->
      [_card | winning_nums] = String.split(head, ":")

      [
        hd(winning_nums)
        |> String.split(~r/\s+/, trim: true)
        |> Enum.map(&String.to_integer/1),
        hd(my_nums)
        |> String.split(~r/\s+/, trim: true)
        |> Enum.map(&String.to_integer/1)
      ]
    end)
    |> Enum.map(fn [winning_nums | [my_nums | _]] ->
      Enum.reduce(winning_nums, 0, fn n, acc ->
        case {acc, Enum.any?(my_nums, fn x -> x == n end)} do
          {0, true} -> 1
          {_, true} -> acc + acc
          _ -> acc
        end
      end)
    end)
    |> Enum.sum()
  end

  def part2(file) do
    file
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, "|"))
    |> Enum.map(fn [head | my_nums] ->
      [_card | winning_nums] = String.split(head, ":")

      [
        hd(winning_nums)
        |> String.split(~r/\s+/, trim: true)
        |> Enum.map(&String.to_integer/1),
        hd(my_nums)
        |> String.split(~r/\s+/, trim: true)
        |> Enum.map(&String.to_integer/1)
      ]
    end)
    |> Enum.map(fn [winning_nums | [my_nums | _]] ->
      Enum.reduce(winning_nums, 0, fn n, acc ->
        if Enum.any?(my_nums, fn x -> x == n end) do
          acc + 1
        else
          acc
        end
      end)
    end)
    |> Enum.with_index(1)
    |> Enum.reduce(%{}, fn {extra_cards, i}, acc ->
      acc_card = Map.update(acc, i, 1, fn val -> val + 1 end)

      case extra_cards do
        0 ->
          acc_card

        n ->
          (i + 1)..(i + n)
          |> Enum.reduce(acc_card, fn card, acc ->
            Map.update(acc, card, acc_card[i], fn val -> val + acc_card[i] end)
          end)
      end
    end)
    |> then(&Map.values/1)
    |> Enum.sum()
  end
end

File.stream!("day4/input.txt") |> AOC23.Day4.part1() |> IO.inspect()
File.stream!("day4/input.txt") |> AOC23.Day4.part2() |> IO.inspect()
