import strutils
import sequtils

const input = block:
  var result: seq[string]
  for line in staticRead("input").splitLines:
    if line != "": result.add line
  result

var
  crabs: seq[int] = input[0].split(',').map(parseInt)
  
proc countFuel(pos: seq[int], depth: int): int =
  for g in pos:
    result += abs(depth - g)

proc countFuel2(pos: seq[int], depth: int): int =
  for g in pos:
    for p in 1..abs(depth - g):
      result += p

proc partOne(): int =
  var maxi = max(crabs)
  result = -1
  for i in 0..maxi:
    if result == -1:
      result = countFuel(crabs, i)
    else:
      result = min(countFuel(crabs, i), result)

proc partTwo(): int =
  var maxi = max(crabs)
  result = -1
  for i in 0..maxi:
    if result == -1:
      result = countFuel2(crabs, i)
    else:
      result = min(countFuel2(crabs, i), result)

echo partOne()
echo partTwo()