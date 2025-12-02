$inp = Get-Content .\input.txt

class Lock {
    [int[]]$dial = @()
    [int]$pointer
    [int]$numberOfZeros
    
    Lock(){
        $this.dial = 0..99
        $this.pointer = $this.dial[50]
        $this.numberOfZeros = 0
    }

    [int]getPointer(){
        return $this.pointer
    }

    [int[]]getDial(){
        return $this.dial
    }

    [int]getNumberOfZeros(){
        return $this.numberOfZeros
    }

    turnLeft([int]$numberOfClicks){
        for($i = 0; $i -lt $numberOfClicks; $i++){
            
            $this.pointer = $this.dial[$this.pointer - 1]
            
            if($this.pointer -eq 0){
                
                $this.numberOfZeros ++
            
            } elseif($this.pointer -eq -1){

                $this.pointer = $this.dial[99]

            }

        }

    }

    turnRight([int]$numberOfClicks){
        for($i = 0; $i -lt $numberOfClicks; $i++){
            
            $this.pointer = $this.dial[$this.pointer + 1]

            if($this.pointer -eq 0){
                
                $this.numberOfZeros++
            
            } elseif($this.pointer -eq 100){
            
                $this.pointer = $this.dial[0]
            
            }

        }
    
    }
}


$lock = New-Object Lock

foreach($rotation in $inp){

    $numberOfClicks = [int]$rotation.substring(1)

    if ($rotation.StartsWith("L")){
        
        $lock.turnLeft($numberOfClicks)
        
    } elseif ($rotation.StartsWith("R")){
        
        $lock.turnRight($numberOfClicks)
    } 

}

$lock.numberOfZeros
