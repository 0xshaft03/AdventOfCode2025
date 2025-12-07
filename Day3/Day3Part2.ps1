
#$inp = Get-Content .\input.txt
#$inp = @("987654321111111","811111111111119","234234234234278","818181911112111")
$inp = @("234234234234278","818181911112111")

class Battery{
    [int]$index
    [int]$charge

    Battery($index, $charge){
        $this.index = $index
        $this.charge = $charge
    }

}

class PowerBank{

    #[System.Collections.ArrayList]$powerBank
    [System.Collections.Hashtable]$powerBank

    PowerBank([string]$inputString){
        $this.powerBank = [System.Collections.hashtable]@{}
        $batteries = $inputString.ToCharArray()

        for($i = 0; $i -lt $batteries.Length;$i++){
            $temp = New-Object -TypeName Battery $i,$([int]::parse($batteries[$i]))
            $this.powerBank.Add($temp.index, $temp.charge) | Out-Null
        }
        
    }

    [System.Collections.hashtable]getPowerBank(){
        return $this.powerBank
    }

    <#
        What i want to do is scan through and find the current max that i am looking for.
        So i would scan through and find 9 and have to handle 3 conditions:
        1. 9 is at the last index, return a new array with all but the last index
        2. 9 is at index 0, return a new array with all but the first index
        3. 9 is somewhere else, return a new array with range (index of 9, end of input array)
    #>
    [System.Collections.ArrayList]getJoltageArray(){
        $joltageArray = [System.Collections.ArrayList]@()
        write-host "Getting Joltage!"

        for([int]$i = 9; $i -gt 0; $i--){

            $t = $this.powerBank.GetEnumerator().Where({$_.value -eq $i}) | sort name -Descending
            
            foreach($j in $t){
                if($joltageArray.Count -eq 12){
                    return $joltageArray
                } else {
                    $joltageArray.Add($j)
                }

                
                
            }
 
        }
        return $joltageArray

    }

}



$powerBankArray = [System.Collections.ArrayList]@()

foreach($i in $inp){
    $t = New-Object -TypeName PowerBank $i
    $powerBankArray.Add($t) | Out-Null
}

<#
$sum = 0
foreach($powerBank in $powerBankArray){
    $sum = $sum + $powerBank.getJoltage()
}

$sum
#>