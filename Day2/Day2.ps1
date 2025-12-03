
$inp = Get-Content input.txt

$global:invalidIDS = 0

$ranges = $inp.Split(',')
#$ranges = @("11-22","95-115","998-1012","1188511880-1188511890","222220-222224","1698522-1698528","446443-446449","38593856-38593862")
foreach($range in $ranges){

    $bounds = $range.Split('-')

    for($i = [int64]$bounds[0]; $i -le [int64]$bounds[1]; $i++){
        
        $value = [string]$i
    
        
        if(($value.Length % 2) -eq 0){
            
            if($value.Length -eq 2){
                
                [string]$lastHalf = $value[1]
                
            }
            else{
                
                $substring = $value.Length /2
                
                [string]$lastHalf = [string]$value.Substring($substring)
                
            }

            if($value.StartsWith($lastHalf)){
                
                $global:invalidIDS = $global:invalidIDS + $i

            }
        
        }
     
    }

}

$global:invalidIDS

