import strutils
#start of main code
echo "Enter current sensitivity: "
var currentSens: float = parseFloat(readLine(stdin))

echo "Enter percentage spacing (0.01 would be 1%): "
var spacing: float = parseFloat(readLine(stdin))

echo "Enter percentage step size (smaller = more accurate, bigger = faster, 0.01 would be 1%): "
let stepSize: float = parseFloat(readLine(stdin))

#once first input set is gotten, it breaks for procs
proc displayNextSenses(lowSens: float, currentSens: float, highSens: float) = 
    echo "=================================="
    echo "Low Sensitivity: " & $(lowSens)
    echo "Middle Sensitivity: " & $(currentSens)
    echo "High Sensitivity: " & $(highSens)
    echo "=================================="

proc displayFinalSensitivity(finalSens: float) = 
    echo ""
    echo "=================================="
    echo "Sensitivity Calculation Complete"
    echo "Final Sensitivity: " & $(finalSens)
    echo "Thank you for using PSA Calculator by bob80333"
    echo "Bye!"
    echo "=================================="

proc calculateNextSenses(chosenSens: float, currentSens: float) : seq[float] = 
    let nextSens: float = (chosenSens + currentSens) / 2
    spacing += stepSize
    let lowSens = nextSens * spacing
    let highSens = nextSens * ((1 - spacing) + 1)
    var nextSenses = newSeq[float](3)
    nextSenses[0] = lowSens
    nextSenses[1] = nextSens
    nextSenses[2] = highSens
    return nextSenses

proc chooseNextSens(): bool = 
    echo "Did you prefer the low sens (1) or the higher sens (2)"
    let ans = parseInt(readLine(stdin))
    if ans == 1:
        return false
    elif ans == 2:
        return true
    else:
        return false #assume lower lol

# return back to main code after procs
var lowSens: float = currentSens * spacing
var highSens: float = currentSens * ((1 - spacing) + 1)

displayNextSenses(lowSens, currentSens, highSens)

var choice: bool = false
var newSens: float = 0
var senses: seq[float]
while (spacing < 1.0):
    choice = chooseNextSens()
    if choice:
        newSens = highSens
    else:
        newSens = lowSens
    senses = calculateNextSenses(newSens, currentSens)
    lowSens = senses[0]
    currentSens = senses[1]
    highSens = senses[2]
    if spacing < 1.0:
        displayNextSenses(lowSens, currentSens, highSens)

displayFinalSensitivity(currentSens)
echo "Type anything to exit"
discard readLine(stdin)