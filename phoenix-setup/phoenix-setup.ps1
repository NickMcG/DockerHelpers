if ($args.length -eq 0)
{
	Write-Host "You need to specify a name for the Phoenix project"
	Exit
}

$name = $args[0]

$add_args = ""
for ($counter = 1; $counter -lt $args.length; ++$counter)
{
	$add_args = $add_args + " " + $args[$counter]
}
$add_args = $add_args.Trim()

if ($add_args -ne "")
{
	$add_args = "-e ADD_ARGS=""" + $add_args + """"
}

$cmd = "docker run --rm -e PHXNAME=$name $add_args -v ${pwd}:/var/output phoenix-setup:local"
Invoke-Expression $cmd

# Use this command for debugging:
#Write-Host $cmd
