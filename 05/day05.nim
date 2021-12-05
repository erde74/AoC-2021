import strutils
from strformat import fmt

const input = block:
  var result: seq[string]
  for line in staticRead("input").splitLines:
    if line != "": result.add line
  result

type
  Line = object
    diag*: bool
    x1: int
    y1: int
    x2: int
    y2: int

var
  lines: seq[Line]
  field: array[0..1000, array[0..1000, int]]

proc prepare =
  for i in input:
    let l = i.split(" -> ")
    let xy = l[0].split(",")
    let xy2 = l[1].split(",")

    var li: Line = Line(
        x1: xy[0].parseInt,
        y1: xy[1].parseInt,
        x2: xy2[0].parseInt,
        y2: xy2[1].parseInt
      )

    if xy[0] == xy2[0] or xy[1] == xy2[1]:
      li.diag = false
    else:
      li.diag = true

    lines.add(li)

proc getCount: int =
  var overlap: int
  for a in 0..1000:
    for b in 0..1000:
      if field[a][b] >= 2:
        inc overlap
  return overlap

proc partOne =
  for l in lines:
    if not l.diag:
      for a in min(l.x1, l.x2)..max(l.x1, l.x2):
        for b in min(l.y1, l.y2)..max(l.y1, l.y2):
          inc field[a][b]

  echo fmt"Part One: {getCount()}"

proc partTwo =
  for l in lines:
    if l.diag:
      let diagLen = abs(l.x1 - l.x2)
      for i in 0..diagLen:
        let offX = (if (l.x1 - l.x2) > 0: i else: -i)
        let offY = (if (l.y1 - l.y2) > 0: i else: -i)
        inc field[l.x2 + offX][l.y2 + offY]

  echo fmt"Part Two: {getCount()}"

prepare()
partOne()
partTwo()
