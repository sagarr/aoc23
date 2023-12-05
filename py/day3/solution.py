with open('py/day3/input.txt', 'r') as f:
    engine = ['.{}.'.format(row) for row in f.read().split('\n')]
    engine = engine[:-1]

def get_adjacent(r, c):
    part_numbers = set()
    dirs = [(-1, -1), (1, 1), (-1, 0), (1, 0), (0, 1), (0, -1), (1, -1), (-1, 1)]
    for dx, dy in dirs:
      if engine[r+dx][c+dy].isdigit():
        left = right = c + dy
        while engine[r+dx][left-1].isdigit():
           left-=1
        while engine[r+dx][right+1].isdigit():
           right+=1
        part_numbers.add(int(engine[r+dx][left:right+1]))
    return part_numbers

all_parts = []

for r, row in enumerate(engine):
    for c, ch in enumerate(row):
        if ch != '.' and not ch.isdigit():
            all_parts.append((engine[r][c], get_adjacent(r, c)))

# part 1
print(sum(sum(part) for _, part in all_parts))

# part 2
result = 0
for ch, part in all_parts:
   if ch == '*' and len(part) == 2:
      result += (part.pop()*part.pop())
print(result)
