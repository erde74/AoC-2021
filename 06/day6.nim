import strutils
import sequtils
import strformat

const input = block:
  var result: seq[string]
  for line in staticRead("input").splitLines:
    if line != "": result.add line
  result

proc partOne =
  var
    fish: seq[int] = input[0].split(',').map(parseInt)

  for d in 0..<80:
    var born = 0
    for i in 0..fish.high:
      dec fish[i]
      if fish[i] < 0:
        fish[i] = 6
        inc born

    for i in 1..born:
      fish.add(8)

  echo fmt"Part One: {fish.len}"

proc sim(days: int) =
  var
    fish: array[0..8, int]

  let data = input[0].split(',').map(parseInt)

  for f in data:
    fish[f] += 1

  for i in 0..<days:
    var tmp: array[0..8, int]
    for f in countdown(8, 1):
      tmp[f-1] = fish[f]
    tmp[8] = fish[0]
    tmp[6] += fish[0]
    fish = tmp


  var result = 0
  for r in fish:
    result += r

  echo fmt"after {days}: {result}"

partOne()

sim(80)
sim(256)
