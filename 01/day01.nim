import strutils
from math import sum
from strformat import fmt
from sequtils import map

const input = block:
  var result: seq[string]
  for line in staticRead("input").splitLines:
    if line != "": result.add line
  result

var
  increased = 0
  last = 0

let input_parsed = input.map(parseInt)

# Part One
for i in input_parsed:
  if last == 0:
    last = i
  else:
    if i > last:
      inc(increased)
    last = i

echo fmt"Part One: {increased}"

# Part Two
increased = 0
last = 0

for i in 0..(input_parsed.high - 3):
  let t = input_parsed[i..(i+2)].sum()

  if t > last: inc(increased)
  last = t

echo fmt"Part Two: {increased}"