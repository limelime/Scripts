# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"
 
# Doing some intensive work
sleep 3s

  # Test
  T=$((T-2*86400))  # Add 2 days
  T=$((T-4*3600))   # Add 4 hours
  T=$((T-51*60))    # Add 51 minutes
  
 
# Get total elapsed time
T="$(($(date +%s)-T))"
printf "Elapsed time[DD:HH:MM:SS]: %02d:%02d:%02d:%02d \n" \
          "$((T/86400))" \
          "$((T/3600%24))" \
          "$((T/60%60))" \
          "$((T%60))"