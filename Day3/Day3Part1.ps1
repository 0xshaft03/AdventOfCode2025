
$inp = Get-Content .\input.txt
#$inp = @("987654321111111","811111111111119","234234234234278","818181911112111")

class PowerBank{

    [System.Collections.ArrayList]$powerBank

    PowerBank([string]$inputString){
        $this.powerBank = [System.Collections.ArrayList]@()
        $t = $inputString.ToCharArray()
        $t.ForEach({$this.powerBank.Add([int]::Parse($_))})
        
    }

    [System.Collections.ArrayList]getPowerBank(){
        return $this.powerBank
    }

    [int]getJoltage(){
        $firstMax = 0
        $secondMax = 0
        $indexOfFirstMax = 0
        $indexOfSecondMax = 0
        
        
        $firstMax = [int]::Parse(($this.powerBank | Measure-Object -Maximum).Maximum)
        Write-Host "First Max:" $firstMax

        $indexOfFirstMax = $this.powerBank.IndexOf([int]::Parse($firstMax))
        Write-Host "Index of First Max:" $indexOfFirstMax

        if([int]::Parse($indexOfFirstMax) -eq [int]::Parse($this.powerBank.Count -1)){
            $indexOfSecondMax = $indexOfFirstMax
            $secondMax = $firstMax
            $indexOfFirstMax = 0

            $tempPowerBank = $this.powerBank.GetRange(0, $this.powerBank.Count -1)
            write-host $tempPowerBank
            $firstMax = [int]::Parse(($tempPowerBank| Measure-Object -Maximum).maximum)
            $indexOfFirstMax = $this.powerBank.IndexOf([int]::Parse($firstMax))

        }else{
            
            $secondMax = [int]::Parse((($this.powerBank.GetRange($indexOfFirstMax+1, $this.powerBank.Count - ($indexOfFirstMax+1)))| Measure-Object -Maximum).maximum)
            write-host "Second Max:" $secondMax
        }
        

        $joltage = [int]::Parse([string]$firstMax + [string]$secondMax)
        write-host "Joltage:" $joltage "`n"
        return $joltage


    }

}



$powerBankArray = [System.Collections.ArrayList]@()

foreach($i in $inp){
    $t = New-Object -TypeName PowerBank $i
    $powerBankArray.Add($t) | Out-Null
}


$sum = 0
foreach($powerBank in $powerBankArray){
    $sum = $sum + $powerBank.getJoltage()
}

$sum