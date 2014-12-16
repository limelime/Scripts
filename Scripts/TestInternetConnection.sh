let SecondsInOneDay=60*60*24

# Predefined startup variables.
TimeInSeconds=`date +%s`
CurrentDate=`date +%Y-%m-%d_%H.%M.%S`
InternetConnectionTest="InternetConnectionTest_"$CurrentDate".txt"

while( true )
do
	sleep 60m

	#--------------------------------------------------
	# Update result file name. 1 result file per day.
	#--------------------------------------------------
	CurrentTimeInSeconds=`date +%s`
	let DifferenceInSeconds=$CurrentTimeInSeconds-$TimeInSeconds
	
	if [ $DifferenceInSeconds -gt $SecondsInOneDay ]
	then
		CurrentDate=`date +%Y-%m-%d_%H.%M.%S`
		InternetConnectionTest="InternetConnectionTest_"$CurrentDate".txt"
		TimeInSeconds=$CurrentTimeInSeconds
	fi

	#--------------------------------------------------
	# Test internet connection.
	#--------------------------------------------------
	# Ping deadline= 5 seconds
	if ping -c1 -w 5 -q 4.2.2.2
	then
		echo "`date +%Y-%m-%d_%H.%M.%S` Connected" >> $InternetConnectionTest
	else
		echo "`date +%Y-%m-%d_%H.%M.%S` Disconnected" >> $InternetConnectionTest
	fi
done
exit 0
