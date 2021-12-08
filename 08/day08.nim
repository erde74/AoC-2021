import strutils
import strformat
import sets

const input = block:
  var result: seq[string]
  for line in staticRead("input").splitLines:
    if line != "": result.add line
  result

const
  one = "cf"
  four = "bcdf"
  seven = "acf"
  eight = "abcdefg"

proc partOne: int =
  for i in input:
    let output = i.split(" | ")[1].split(" ")
    for o in output:
      case o.len:
      of one.len: inc result
      of four.len: inc result
      of seven.len: inc result
      of eight.len: inc result
      else:
        discard   

proc deduceZero(data: seq[string], t: array[0..9, HashSet[char]]): Hashset[char] =
  let a = t[9] - t[4] + t[1]
  let b = t[8] - t[3]
  result = a + b

proc deduceThree(data: seq[string], t: array[0..9, HashSet[char]]): Hashset[char] =
  let a = t[9] - t[4] + t[1]
  for d in data:
    let dhs = d.toHashset()
    if len(dhs - a) == 1:
      result = a + (dhs - a)

proc deduceFive(data: seq[string], t: array[0..9, HashSet[char]]): Hashset[char] =
  let a = t[9] - t[1]
  for d in data:
    let dhs = d.toHashset()
    if len(dhs - a) == 1:
      result = a + (dhs - a)

proc deduceSix(data: seq[string], t: array[0..9, HashSet[char]]): Hashset[char] =
    let ef = t[8] - t[5]
    let en = t[8] - t[9]
    result = t[8] - (ef - en)

proc deduceNine(data: seq[string], t: array[0..9, HashSet[char]]): Hashset[char] =
  let s = t[4] + t[7]
  for d in data:
    let dhs = d.toHashset()
    if len(dhs - s) == 1:
      result = s + (dhs - s)

proc deduceTwo(data: seq[string], t: array[0..9, HashSet[char]]): Hashset[char] =
  let f = t[6] * t[1]
  let b = t[9] - t[3]
  result = t[8] - f - b

proc partTwo: int =
  var
    t: array[0..9, HashSet[char]]

  for i in input:
    let input = i.split(" | ")[0].split(" ")
    let output = i.split(" | ")[1].split(" ")
    for o in input:
      case o.len:
      of one.len: 
        t[1] = o.toHashSet()
      of four.len: 
        t[4] = o.toHashSet()
      of seven.len:
        t[7] = o.toHashSet()
      of eight.len:
        t[8] = o.toHashSet()
      else:
        discard
    t[9] = deduceNine(input, t)
    t[3] = deduceThree(input, t)
    t[0] = deduceZero(input, t)
    t[5] = deduceFive(input, t)
    t[6] = deduceSix(input, t)
    t[2] = deduceTwo(input, t)

    var tmp: string
    for o in output:
      for i in 0..t.high:
        if o.toHashSet() == t[i]:
          tmp &= fmt"{i}"
    result += parseInt(tmp)
    
    
echo partOne()
echo partTwo()
