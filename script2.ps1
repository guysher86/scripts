param ($taskname,$status,$waitSeconds)

function createTask {param($taskname)
    $taskAction = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument 'C:\Users\ishay\Desktop\script1.ps1'
	$taskTrigger = New-ScheduledTaskTrigger -Once -At (Get-Date).Date -RepetitionInterval (New-TimeSpan -Minutes 1)

	$null = $taskTrigger
	$null = $taskAction
	$null = Register-ScheduledTask -TaskName $taskName -Action $taskAction -Trigger $taskTrigger
}

function changeTaskStatus {param($taskName,$status)
	if ($status -eq "disable"){
		Disable-ScheduledTask -TaskName "$taskName"
	}
	elseif ($status -eq "enable"){
		Enable-ScheduledTask -TaskName "$taskName"
	}
	else {
		write-host "status can be only enable or disable"
	}	
}

function getAllTaskF{
	$allTask = Get-ScheduledTask -TaskPath "\"
	foreach ($i in $allTask){
		write-host $i.TaskName
	} 
}

if ($status){
	changeTaskStatus $taskName $status
}
elseif ($taskName -and -not $waitSeconds){
	createTask $taskName
}
elseif ($waitSeconds){
	write-host $waitSeconds
	createTask $taskName
	Start-Sleep -Seconds $waitSeconds
	$statusD = "disable"
	changeTaskStatus $taskName $statusD
}
else {
	getAllTaskF
}
