import sequtils
import strutils
import sets
import algorithm

const input = block:
  var result: seq[string]
  for line in staticRead("input").splitLines:
    if line != "": result.add line
  result
 
proc partOne: int =
  var
    Stack: seq[char]

  for l in input:
    Stack = @[]
    for c in l.toSeq:
      case c:
      of '(': Stack.add c
      of '[': Stack.add c
      of '{': Stack.add c
      of '<': Stack.add c
      else:
        case c:
        of ')':
          if Stack[Stack.high] != '(':
            result += 3
            break;
          else:
            discard Stack.pop()
        of ']':
          if Stack[Stack.high] != '[':
            result += 57
            break;
          else:
            discard Stack.pop()
        of '}':
          if Stack[Stack.high] != '{':
            result += 1197
            break;
          else:
            discard Stack.pop()
        of '>':
          if Stack[Stack.high] != '<':
            result += 25137
            break;
          else:
            discard Stack.pop()
        else:
          discard
      discard

proc partTwo: int =
  var
    Stack: seq[char]
    points: int
    score: seq[int]

  for l in input:
    points = 0
    Stack = @[]
    for c in l.toSeq:
      case c:
      of '(': Stack.add c
      of '[': Stack.add c
      of '{': Stack.add c
      of '<': Stack.add c
      else:
        case c:
        of ')':
          if Stack[Stack.high] != '(':
            points += 3
            break;
          else:
            discard Stack.pop()
        of ']':
          if Stack[Stack.high] != '[':
            points += 57
            break;
          else:
            discard Stack.pop()
        of '}':
          if Stack[Stack.high] != '{':
            points += 1197
            break;
          else:
            discard Stack.pop()
        of '>':
          if Stack[Stack.high] != '<':
            points += 25137
            break;
          else:
            discard Stack.pop()
        else:
          discard
      discard
    if points == 0:
      var line = l
      for c in Stack.reversed.items:
        case c:
        of '(': 
          line.add ')'
          points *= 5
          points += 1
        of '[': 
          line.add ']'
          points *= 5
          points += 2
        of '{': 
          line.add '}'
          points *= 5
          points += 3
        of '<': 
          line.add '>'
          points *= 5
          points += 4
        else: 
          discard
      score.add points
    score = score.sorted
    
  if score.len mod 2 == 0:
    result = score[(score.len div 2) - 1]
  else:
    result = score[(score.len div 2)]
      

echo partOne()
echo partTwo()