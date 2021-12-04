import strutils
from strformat import fmt

const input = block:
  var result: seq[string]
  for line in staticRead("input").splitLines:
    if line != "": result.add line
  result

const
  nums = block:
    input[0].split(',')

type
  Board = object
    won*: bool
    nums*: array[0..4, array[0..4, (string, bool)]]

var
  boards: seq[Board]

proc prepare =
  var
    b: Board
    line: int

  for i in input:
    if i.len() > 0 and i.len() < 20:
      var c = 0
      for z in countup(0, i.high, 3):
        b.nums[line][c] = (i[z..z + 1].replace(" ", ""), false)
        inc c

      inc line
      if line > 4:
        boards.add(b)
        line = 0

proc check(i: int): int =
  for x in 0..4:
    var row = 0
    var col = 0
    for y in 0..4:
      if boards[i].nums[x][y][1]:
        inc row
    for y in 0..4:
      if boards[i].nums[y][x][1]:
        inc col
    if row == 5 or col == 5:
      return i
  return 0

proc mark(i: int, n: string) =
  for x in 0..4:
    for y in 0..4:
      if boards[i].nums[x][y][0] == n:
        boards[i].nums[x][y][1] = true

proc printBoard(b: int) =
  for x in 0..4:
    for y in 0..4:
      stdout.write(boards[b].nums[x][y])
    stdout.write("\n")
  stdout.write("\n")

proc calcSum(b: int): int =
  var sum: int = 0
  for x in 0..4:
    for y in 0..4:
      if not boards[b].nums[x][y][1]:
        sum += parseInt(boards[b].nums[x][y][0])
  return sum

prepare()

var
  won: seq[(int, int)]

for n in nums:
  for i in 0..boards.high:
    if not boards[i].won:
      mark(i, n)
      if check(i) != 0:
        boards[i].won = true
        won.add((i, calcSum(i) * parseInt(n)))
      # printBoard(i)

echo fmt"Part One: {won[0][1]}"
echo fmt"Part Two: {won[won.high][1]}"
