import strutils
from strformat import fmt
import sequtils

const input = block:
  var result: seq[string]
  for line in staticRead("input").splitLines:
    if line != "": result.add line
  result

proc partOne =
  var
    gamma = ""
    epsilon = ""

  for j in 0..<input[0].len:
    var one = 0
    var zero = 0

    for i in input:
      if i[j] == '1':
        inc one
      else:
        inc zero

    if one > zero:
      gamma &= "1"
      epsilon &= "0"
    else:
      gamma &= "0"
      epsilon &= "1"

  echo fmt"Part One: {fromBin[int64](gamma) * fromBin[int64](epsilon)}"

proc partTwo* =
  var
    result: seq[string] = input
    oxygen: int64
    co2: int64

  # Oxygen
  for j in 0..result[0].high:
    let one = result.filterIt(it[j] == '1')
    let zero = result.filterIt(it[j] == '0')
    
    if one.len >= zero.len:
      result = one
    else:
      result = zero

  oxygen = fromBin[int64](result[0])
  
  # CO2
  result = input

  for j in 0..result[0].high:
    let one = result.filterIt(it[j] == '1')
    let zero = result.filterIt(it[j] == '0')

    if zero.len <= one.len and zero.len > 0:
        result = zero
    else:
      if one.len > 0:
        result = one

  co2 = fromBin[int64](result[0])
  
  echo fmt"Part Two: {oxygen * co2}"

partOne()
partTwo()
