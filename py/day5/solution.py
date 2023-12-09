def part2():
    Ts = open("py/day5/input.txt").read().split("\n\n")

    seeds = list(map(int, Ts[0].split(":")[1].strip().split()))
    T = {}

    for t in Ts[1:]:
        p = t.splitlines()
        k = tuple(p[0].split()[0].split("-to-"))
        T[k] = []

        for c_map in p[1:]:
            T[k].append(list(map(int, c_map.split())))

    current_state = "seed"

    while current_state != "location":
        for state in T.keys():
            if state[0] == current_state:
                current_state = state[1]
                mappings = T[state]
                break

        to_map = []
        for i in range(len(seeds) // 2):
            loc = seeds[2 * i]
            rng = seeds[2 * i + 1]
            to_map.append((loc, rng))

        new_seeds = []
        while to_map:
            loc, rng = to_map.pop(0)
            mapped = False
            for c_map in mappings:
                c_src_beg = c_map[1]
                c_src_end = c_map[1] + c_map[2]
                c_dst_ref = c_map[0]

                if (
                    c_src_beg <= loc <= c_src_end
                    or c_src_beg <= loc + rng <= c_src_end
                    or loc <= c_src_beg <= loc + rng
                    or loc <= c_src_end <= loc + rng
                ):
                    n_l = max(loc, c_src_beg)
                    n_e = min(loc + rng, c_src_end)
                    new_seeds += [c_dst_ref + (n_l - c_src_beg), n_e - n_l]
                    if loc < c_src_beg:
                        to_map.append((loc, c_src_beg - loc - 1))
                    if loc + rng > c_src_end:
                        to_map.append((c_src_end + 1, (loc + rng) - c_src_end))
                    mapped = True
                    break
            if not mapped:
                new_seeds += [loc, rng]

        seeds = new_seeds
    print(min([seeds[2 * i] for i in range(len(seeds) // 2)]))

part2()
