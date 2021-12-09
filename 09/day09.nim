import sequtils
import strutils
import algorithm

const input = block:
  var result: seq[seq[int]]
  for line in staticRead("input").splitLines:
    if line != "": result.add line.toSeq().mapIt(parseInt($it)).toSeq()
  result

proc partOne: int =
  for y in 0..input.high:
    for x in 0..input[0].high:
      let value: int = input[y][x]
      var x1 = x + 1
      var x2 = x - 1
      var y1 = y + 1
      var y2 = y - 1

      if x == 0: x2 = x1
      if x == input[0].high: x1 = x2
    
      if y == 0: y2 = y1
      if y == input.high: y1 = y2

      if value < input[y1][x] and
         value < input[y2][x] and
         value < input[y][x1] and
         value < input[y][x2]:
        result += value + 1

proc findBasin(x1,y1: int, map: var seq[seq[int]]): int =
  var start_x = x1
  var end_x = x1
  for x in countdown(x1, 0):
    if map[y1][x] != 9:
      start_x = x
    else: break
  for x in x1..map[0].high:
    if map[y1][x] != 9:
      end_x = x
    else: break
  
  result = end_x - start_x + 1

  for x in start_x .. end_x:
    map[y1][x] = 9

  for x in start_x .. end_x:
    for y in y1 + 1..map.high:
      if map[y][x] != 9:
        result += findBasin(x, y, map)
      else: break

    if y1 - 1 > 0:
      for y in y1 - 1..map.high:
        if map[y][x] != 9:
          result += findBasin(x, y, map)
        else: break
  
proc partTwo: int =
  var map = input
  var basin: seq[int]

  for y in 0..input.high:
    for x in 0..input[0].high:
      if input[y][x] != 9:
        basin.add(findBasin(x,y, map))

  basin.sort()
  basin.reverse()
  
  result = basin[0] * basin[1] * basin[2]

echo partOne()
echo partTwo()