import strutils
from strformat import fmt

const input = block:
  var result: seq[string]
  for line in staticRead("input").splitLines:
    if line != "": result.add line
  result

proc partOne =
  var
    position: int
    depth: int

  for s in input:
    let c = s.split(' ')
    case c[0]:
    of "forward":
      position += c[1].parseInt
    of "down":
      depth += c[1].parseInt
    of "up":
      depth -= c[1].parseInt

  echo fmt"Part One: position {position} depth {depth} = {position * depth}"

proc partTwo =
  var
    position: int
    depth: int
    aim: int

  for s in input:
    let c = s.split(' ')
    case c[0]:
    of "forward":
      position += c[1].parseInt
      depth += c[1].parseInt * aim
    of "down":
      aim += c[1].parseInt
    of "up":
      aim -= c[1].parseInt

  echo fmt"Part Two: position {position} depth {depth} = {position * depth}"

partOne()
partTwo()
