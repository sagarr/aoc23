defmodule AOC23.Day1 do
  def part1(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn line ->
      case Regex.scan(~r/\d/, line) do
        [[first | _] | []] ->
          String.to_integer(first <> first)

        [[first | _] | tail] ->
          [last | _] = List.last(tail)
          String.to_integer(first <> last)
      end
    end)
    |> Enum.sum()
  end

  def replace(line) do
    line
    |> String.replace("eighthree", "83")
    |> String.replace("eightwo", "82")
    |> String.replace("fiveight", "58")
    |> String.replace("threeight", "38")
    |> String.replace("sevenine", "79")
    |> String.replace("oneight", "18")
    |> String.replace("twone", "21")
  end

  def part2(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&replace/1)
    |> Stream.map(fn line ->
      case Regex.scan(~r/\d|one|two|three|four|five|six|seven|eight|nine/, line) do
        [["one" | _] | []] ->
          11

        [["two" | _] | []] ->
          22

        [["three" | _] | []] ->
          33

        [["four" | _] | []] ->
          44

        [["five" | _] | []] ->
          55

        [["six" | _] | []] ->
          66

        [["seven" | _] | []] ->
          77

        [["eight" | _] | []] ->
          88

        [["nine" | _] | []] ->
          99

        [[first | _] | []] ->
          String.to_integer(first <> first)

        [[first | _] | tail] ->
          f =
            case first do
              "one" ->
                "1"

              "two" ->
                "2"

              "three" ->
                "3"

              "four" ->
                "4"

              "five" ->
                "5"

              "six" ->
                "6"

              "seven" ->
                "7"

              "eight" ->
                "8"

              "nine" ->
                "9"

              _ ->
                first
            end

          [last | _] = List.last(tail)

          l =
            case last do
              "one" ->
                "1"

              "two" ->
                "2"

              "three" ->
                "3"

              "four" ->
                "4"

              "five" ->
                "5"

              "six" ->
                "6"

              "seven" ->
                "7"

              "eight" ->
                "8"

              "nine" ->
                "9"

              _ ->
                last
            end

          String.to_integer(f <> l)
      end
    end)
    |> Enum.sum()
  end
end

File.stream!("day1/input.txt") |> AOC23.Day1.part1() |> IO.puts()
File.stream!("day1/input.txt") |> AOC23.Day1.part2() |> IO.puts()
