Set-ExecutionPolicy Unrestricted
$pa='C:\SigmaStream\YellowHammer\YellowHammer-Server\YellowHammer-Server\yellowhammer\yellowhammer-base\logs'
echo "Please select log file to view"
echo "1.jettyStartup.log"
echo "2.yhsource.log"
$name = Read-Host 'Enter number to view log file'
echo "==================================================================================================================="
switch($name)
{
    #jettyStartup.log.log {
    1{
    $jetty= Get-Item -Path $pa\jettyStartup*.log | select 'Name' -ExpandProperty Name -last 1
    #echo $log
    Get-Content -Path $pa\$jetty -Tail 70 -wait
    }

   #yh-source.log{
    2{
    $source=Get-Item -Path $pa\yh_source*.log | select 'Name' -ExpandProperty Name -last 1
    Get-Content -Path $pa\$source -Tail 70 -wait
    }
    
    default{
    echo "Please select valid option! 1= jettyStartup.log || 2= yh_Source.log"
    echo "==================================================================================================================="
    }

}