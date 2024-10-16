$pa='C:\SigmaStream\KingFisher\server\log'
echo "Please select log file to view"
echo "1.KingFisher.log"
echo "2.root.log"
echo "3.sto.log"
echo "4.csv.log"
echo "5.yh.log"
$name = Read-Host 'Enter number to view log file'
echo "==================================================================================================================="
switch($name)
{
    #KingFisher.log {
    1{   
    $log= Get-Item -Path $pa\KingFisher*.log | select 'Name' -ExpandProperty Name -last 1 
    #$log = ls $pa\King*.log |select 'name' -ExpandProperty Name -Last 1 
    gc -Path $pa\$log -Tail 100 -wait
    }


    #root.log {
    2{
    $root= Get-Item -Path $pa\root*.log | select 'Name' -ExpandProperty Name -last 1
    #Get-Item -Path $pa\root*.log | select 'Name' -ExpandProperty Name -last 1 >> $root
    Get-Content -Path $pa\$root -Tail 20 -wait
    }       

    #sto.log {
    3{
    $sto= Get-Item -Path $pa\sto*.log | select 'Name' -ExpandProperty Name -last 1
    #echo $log
    Get-Content -Path $pa\$sto -Tail 20 -wait
    }

   #csv.log{
    4{
    $csv=Get-Item -Path $pa\csv*.log | select 'Name' -ExpandProperty Name -last 1
    Get-Content -Path $pa\$csv -Tail 20 -wait
    }
     
    #yh.log{
    5{
    $yh =Get-Item -Path $pa\yh*.log | select 'Name' -ExpandProperty Name -last 1
    Get-Content -Path $pa\$yh -Tail 20 -wait
    }
    
    default{
        echo "Please select valid option!"
        echo "1= KingFisher.log || 2= root.log || 3= csv.log || 4= sto.log || 5= yh.log"
        echo "==================================================================================================================="
        }
}