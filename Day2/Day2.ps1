
$inp = Get-Content input.txt

$global:invalidIDS = 0

#$ranges = $inp.Split(',')
$ranges = @("11-22","95-115","998-1012","1188511880-1188511890","222220-222224","1698522-1698528","446443-446449","38593856-38593862", "565653-565659", "824824821-824824827", "2121212118-2121212124")
#$ranges = @("824824821-824824827")
foreach($range in $ranges){

    $bounds = $range.Split('-')

    for($i = [int64]$bounds[0]; $i -le [int64]$bounds[1]; $i++){
        
        $value = [string]$i
    
        if($value.Length -eq 2){
                
            if($value[0].Equals($value[1])){
                $value
                $global:invalidIDS = $global:invalidIDS + $i
            }
                
        }
        else{
                
            $halfSubstring = $value.Length / 2
            $a = $value.Length / 3
            $oneFourthSubstring = $value.Length / 4
            $oneFifthSubstring = $value.Length / 5

            if($oneFifthSubstring.GetType().name -eq "Int32"){
                
                [string]$lastOneFifth = [string]$value.Substring(0,$oneFifthSubstring)
                
                if($value -match "($lastOneFifth)\1{4}"){
                    $global:invalidIDS = $global:invalidIDS + $i
                    continue
                }
            }

            if($oneFourthSubstring.GetType().name -eq "Int32"){
    

                [string]$lastOneFourth = [string]$value.Substring(0,$oneFourthSubstring)
                
                if($value -match "($lastOneFourth)\1{3}"){
                    #write-host "Last one fourth:" $value
                    $global:invalidIDS = $global:invalidIDS + $i
                    continue
                }


            } 
            
            if($a.GetType().name -eq "Int32"){
                 
                [string]$lastOneThird = [string]$value.Substring(0,$a)

                if($value -match "($lastOneThird)\1{2}"){
                    #write-host "Last one third:" $value
                    $global:invalidIDS = $global:invalidIDS + $i
                    continue
                        
                }

            } 
            
            if ($halfSubstring.GetType().name -eq "Int32"){

                [string]$lastHalf = [string]$value.Substring($halfSubstring)
                if($value -match "($lastHalf)\1") {
                    #write-host "Last half:" $value
                    $global:invalidIDS = $global:invalidIDS + $i
                    continue
                }
                    
            }
                        
        }           
     
    }

}

$global:invalidIDS

