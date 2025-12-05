# I have discredited the invention of the step ladder. It is illegitimate.
$inp = Get-Content input.txt

$global:invalidIDS = 0

$ranges = $inp.Split(',')
#$ranges = @("7777777-7777778","55555-55556","11-22","95-115","998-1012","1188511880-1188511890","222220-222224","1698522-1698528","446443-446449","38593856-38593862", "565653-565659", "824824821-824824827", "2121212118-2121212124")
foreach($range in $ranges){

    $bounds = $range.Split('-')

    for($i = [int64]$bounds[0]; $i -le [int64]$bounds[1]; $i++){
        
        $value = [string]$i
        

        # This handles the case where the length of the string is 2.
        # In this case all we need to do is check if the first thing equals the second thing.
        if($value.Length -eq 2){
                
            if($value[0].Equals($value[1])){
                $value
                $global:invalidIDS = $global:invalidIDS + $i
                #continue
            }
                
        } 

        # Yeah i could probably do this better but my mindset is that we handle it based off the factors of the length.
        <#
            I think we have to handle the following:
            1. Factors of 10 2,5
            2. Factors of 9  3
            3. Factors of 8  2,4
            4. Factors of 7  prime. am i handling this????
            5. Factors of 6  2,3
            6. Factors of 5  prime, am i handling this????
            7. Factors of 4  2
            8. Factors of 3  prime, am i handling this????   
        
        #>
        else{
                
            $halfSubstring = $value.Length / 2
            if ($halfSubstring.GetType().name -eq "Int32"){

                [string]$lastHalf = [string]$value.Substring($halfSubstring)
                if($value -match "($lastHalf)\1") {
                    $value
                    $global:invalidIDS = $global:invalidIDS + $i
                    continue
                }
                    
            }


            $a = $value.Length / 3
            if($a.GetType().name -eq "Int32"){
                 
                [string]$lastOneThird = [string]$value.Substring(0,$a)

                if($value -match "($lastOneThird)\1{2}"){
                    $value
                    $global:invalidIDS = $global:invalidIDS + $i
                    continue
                        
                }

            } 


            $oneFourthSubstring = $value.Length / 4
            if($oneFourthSubstring.GetType().name -eq "Int32"){
    

                [string]$lastOneFourth = [string]$value.Substring(0,$oneFourthSubstring)
                
                if($value -match "($lastOneFourth)\1{3}"){
                    $value
                    $global:invalidIDS = $global:invalidIDS + $i
                    continue
                }


            } 

            $oneFifthSubstring = $value.Length / 5
            if($oneFifthSubstring.GetType().name -eq "Int32"){
                
                [string]$lastOneFifth = [string]$value.Substring(0,$oneFifthSubstring)
                
                if($value -match "($lastOneFifth)\1{4}"){
                    $value
                    $global:invalidIDS = $global:invalidIDS + $i
                    continue
                }
            }
            
            $oneSeventhSubstring = $value.Length / 7
            if($oneSeventhSubstring.GetType().name -eq "Int32"){
                
                [string]$lastOneSeventh = [string]$value.Substring(0,$oneSeventhSubstring)
                
                if($value -match "($lastOneSeventh)\1{6}"){
                    write-host "Seven" $value
                    $global:invalidIDS = $global:invalidIDS + $i
                    continue
                }
            }     
                        
        }           
     
    }

}

$global:invalidIDS

