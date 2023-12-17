defmodule AOC23.Day11 do
  def part1(input) do
    grid =
      input
      |> Enum.map(&String.split(&1, "\n", trim: true))
      |> Enum.map(fn [row | _] -> String.split(row, "", trim: true) end)

    empty_rows =
      Enum.with_index(grid)
      |> Enum.map(fn {row, r} ->
        if Enum.all?(row, fn ch -> ch == "." end) do
          r
        else
          nil
        end
      end)
      |> Enum.reject(&is_nil/1)
      |> IO.inspect()

    empty_cols =
      grid
      |> Enum.zip()
      |> Enum.with_index()
      |> Enum.map(fn {col, c} ->
        if Tuple.to_list(col) |> Enum.all?(fn ch -> ch == "." end) do
          c
        else
          nil
        end
      end)
      |> Enum.reject(&is_nil/1)
      |> IO.inspect()

    galaxies =
      grid
      |> Enum.with_index()
      |> Enum.map(fn {row, r} ->
        Enum.with_index(row)
        |> Enum.map(fn {ch, c} ->
          if ch == "#" do
            {r, c}
          else
            nil
          end
        end)
        |> Enum.reject(&is_nil/1)
      end)
      |> Enum.reject(&(length(&1) == 0))
      |> Enum.flat_map(& &1)
      |> IO.inspect()

    for {{r1, c1}, i} <- Enum.with_index(galaxies) do
      {_, rest} = Enum.split(galaxies, i + 1)

      for {r2, c2} <- rest do
        [min(r1, r2)..max(r1, r2)]
        |> Enum.reduce(0, fn r, acc ->
          nil
        end)
      end
    end
    |> Enum.flat_map(& &1)
    |> then(&length/1)
  end
end

File.stream!("ex/day11/input.txt") |> AOC23.Day11.part1() |> IO.inspect()
