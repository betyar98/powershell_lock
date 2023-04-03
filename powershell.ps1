#Run As Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -WindowStyle hidden -File `"$PSCommandPath`"" -Verb RunAs; exit }


$code = @"
    [DllImport("user32.dll")]
    public static extern bool BlockInput(bool fBlockIt);
"@

$userInput = Add-Type -MemberDefinition $code -Name UserInput -Namespace UserInput -PassThru

function Disable-UserInput($seconds) {
    $userInput::BlockInput($true)
    Start-Sleep $seconds
    $userInput::BlockInput($false)
}

Start-Process chrome https://youtu.be/xm3YgoEiEDc?t=1 ; Start-Sleep -Milliseconds 750 ; [void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') ;Start-Sleep -s 2; [System.Windows.Forms.SendKeys]::SendWait("f")

Disable-UserInput -seconds 30 | Out-Null
