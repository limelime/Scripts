# Description: Test regex to comment out the root(/) entry.
#               Make sure it works when ran multiple times.
#               The regex has to work for all supported OS.

# List of fstab files
fstab_files=( fstab-mint-201403 fstab-debian-7.x )

for fstab in "${fstab_files[@]}"
do
    echo "********************************************"
    echo "********  ${fstab}  ********"
    
    # Copy original fstab for processing.
    yes|cp ${fstab}.original ${fstab}
    
    # Apply the regex twice.
    sed -i "/^#/b; s/\(^.*[ \t]\/[ \t].*\)/#\1\nnone \/ tmpfs defaults 0 0/" ${fstab}
    sed -i "/^#/b; s/\(^.*[ \t]\/[ \t].*\)/#\1\nnone \/ tmpfs defaults 0 0/" ${fstab}
    
    # Show the end results.
    cat ${fstab}
done
