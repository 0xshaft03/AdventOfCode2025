
$inp = Get-Content .\input.txt

$global:answer = 0
$global:pointer = 50


function turn($rotation){

    $r = [int]$rotation.substring(1)
    Write-host "Rotate:" $r

    if ($rotation.StartsWith("L")){
        Write-host "Rotating Left"
        $global:pointer = ((($global:pointer - $r) % 100) + 100) % 100


        
    } elseif ($rotation.StartsWith("R")){
        Write-host "Rotating Right"
        
        $global:pointer = (($global:pointer + $r) % 100) 
    } 

    if ($global:pointer -eq 0) {
        $global:answer++
    }
}





foreach($rotation in $inp){
    
    Write-Host "Pointer is at:" $global:pointer

    turn($rotation)
}

$answer