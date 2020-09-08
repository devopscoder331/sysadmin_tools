#---------------------------------------------------------------------------------
#The sample scripts are not supported under any Microsoft standard support
#program or service. The sample scripts are provided AS IS without warranty
#of any kind. Microsoft further disclaims all implied warranties including,
#without limitation, any implied warranties of merchantability or of fitness for
#a particular purpose. The entire risk arising out of the use or performance of
#the sample scripts and documentation remains with you. In no event shall
#Microsoft, its authors, or anyone else involved in the creation, production, or
#delivery of the scripts be liable for any damages whatsoever (including,
#without limitation, damages for loss of business profits, business interruption,
#loss of business information, or other pecuniary loss) arising out of the use
#of or inability to use the sample scripts or documentation, even if Microsoft
#has been advised of the possibility of such damages
#---------------------------------------------------------------------------------

Function Send-OSCLockOutUser
{
	param
	(
		[Parameter(Mandatory=$true,Position=0)]
	    [String]$From,
		[Parameter(Mandatory=$true,Position=1)]
	    [String[]]$To,
		[Parameter(Mandatory=$true,Position=2)]
	    [String]$SMTPServer
	)
	try
	{
		#Get newest event 4740
		$Event = Get-EventLog -LogName Security -InstanceId 4740 -Newest 1
		#Store the newest log into email boy
		$EmailBody= $Event.Message + "`r`n`t" + $Event.TimeGenerated
		#Email subject
		$EmailSubj= "User Account locked out"
		#Create SMTP client
		$SMTPClient = New-Object Net.Mail.SMTPClient($SmtpServer)
		#Create mailmessage object
		$emailMessage = New-Object System.Net.Mail.MailMessage
		$emailMessage.From = "$From"
		Foreach($EmailTo in $To)
		{
		 $emailMessage.To.Add($EmailTo)
		}
		$emailMessage.Subject = $EmailSubj
		$emailMessage.Body = $EmailBody
		#Send email
		$SMTPClient.Send($emailMessage)
	}
	Catch
	{
		Write-Error $_
	}

}

Send-OSCLockOutUser -From  -To  -SMTPServer
