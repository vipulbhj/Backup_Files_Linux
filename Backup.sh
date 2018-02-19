# Checks if some arguments are passed to the program.
if [ $# -gt 0 ]; then 
        # Checks each flag and based on the flag
        # Gives a appropriate response
        case "$1" in
                -s)
                        export source_prog=$2
                        ;;
                -d)
                        export destination_prog=$2
                        mkdir -p $destination_prog
                        ;;
                -r)
                        readme_loc="$destination_prog/README.txt"
                        touch $readme_loc
                        # User that ran the script
                        name="$USER"
                        time=`date`
                        echo "##################################" >> $readme_loc
                        echo "Username:-  $name" >> $readme_loc
                        echo "Time:- $time" >> $readme_loc
                        echo "Source Directory:- $source_prog" >> $readme_loc
                        echo "Backup Directory:- $destination_prog" >> $readme_loc
                        ;;   
                *)
                        echo "no such flag"
                        exit 0
                        ;;                   
        esac
else
    # "No parameters, Actual backup job"
    # Find the base directory from -s address
    source_dir=$(basename $source_prog)
    # Making directory inside backup of the name sourcedirectory.
    backup_source="$destination_prog/$source_dir"
    # using three file addresses for {.1,.2,.3} directories.
    file_1="$backup_source.1"
    file_2="$backup_source.2"
    file_3="$backup_source.3"
    # Check if .3 exists
    if [ -d $file_3 ]; then
        # Delete the file
        rm -rf $file_3
    fi
    # Check if .2 exists
    if [ -d $file_2 ]; then
        # Delete the file
        mv $file_2 $file_3
    fi
    # Check if .1 exists
    if [ -d $file_1 ]; then
        # Delete the file
        mv $file_1 $file_2
    fi
    # copy sourcedir current state into .1
    cp -R $source_prog $file_1
fi
