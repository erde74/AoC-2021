import strutils
from strformat import fmt

const input = block:
  var result: seq[string]
  for line in staticRead("input").splitLines:
    if line != "": result.add line
  result

var
  position: int
  depth: int
  position2: int
  depth2: int
  aim: int

for s in input:
  let c = s.split(' ')

  case c[0]:
  of "forward":
    position += c[1].parseInt
    position2 += c[1].parseInt
    depth2 += c[1].parseInt * aim

  of "down":
    depth += c[1].parseInt
    aim += c[1].parseInt
    
  of "up":
    depth -= c[1].parseInt
    aim -= c[1].parseInt

echo fmt"Part One: position {position} depth {depth} = {position * depth}"
echo fmt"Part Two: position {position2} depth {depth2} = {position2 * depth2}"
