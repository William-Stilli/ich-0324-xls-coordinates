function ParseTable ([string]$Cell) {
    $result = ""
    $leftSide = ""
    $rightSide = ""
    $result+="["
    $numOfLetter=-1
    $passedLetter=$false
    
    foreach ($char in [char[]]$Cell) {
        if($char -match "^\d+$"){
            $passedLetter=$true
        } else {
            if($passedLetter -eq $true){
                throw New-Object System.ArgumentException "Parameter $Cell is invalid. Bad structure"
            }

            $leftSide+=$([int][char]$char - 64)
            $numOfLetter++
        }
    }

    if($numOfLetter -eq -1){
        throw New-Object System.ArgumentException "Parameter $Cell is invalid. Missing a letter"
    }

    $letterAddition=[int]0

    foreach ($char in $leftSide.ToCharArray()){
        $letterAddition += [int]::Parse($char)
    }

    $letterAddition+=$numOfLetter*26
    $letterAddition-=$numOfLetter
    $result+=$letterAddition
    $result+=","
    $numOfNumber=-1

    foreach ($char in [char[]]$Cell) {
        if($char -match "^\d+$"){
            $rightSide+=$char
            $numOfNumber++
        } else {
        }
    }
    if($numOfNumber -eq -1){
        throw New-Object System.ArgumentException "Parameter $Cell is invalid. Missing a number";
    }
    $result+=$rightSide
    $result+="]";
    return $result;
}

Export-ModuleMember -Function 'ParseTable'