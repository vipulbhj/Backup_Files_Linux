#!/bin/bash


# Checks if some arguments are passed to the program.
if [ $# -gt 0 ]; then 
        # Checks each flag and based on the flag
        # Gives a appropriate response
        case "$1" in
                -s)     
                        source_prog=$2
                        touch /home/vipul/Desktop .__source
                        echo $source_prog > /home/vipul/Desktop.__source
                        cat /home/vipul/Desktop.__source
                        ;;
                -d)
                        des_prog=$2
                        mkdir -p $des_prog
                        touch /home/vipul/Desktop .__des
                        echo $des_prog > /home/vipul/Desktop.__des
                        cat /home/vipul/Desktop.__des
                        ;;
                -r)
                        source=$(</home/vipul/Desktop.__source)
                        des=$(<//home/vipul/Desktop.__des)
                        echo $source,$des
                        readme_loc="$des/README.txt"
                        touch $readme_loc
                        # User that ran the script
                        name="$USER"
                        time=`date`
                        echo "##################################" >> $readme_loc
                        echo "Username:-  $name" >> $readme_loc
                        echo "Time:- $time" >> $readme_loc
                        echo "Source Directory:- $source_prog" >> $readme_loc
                        echo "Backup Directory:- $des_prog" >> $readme_loc
                        ;;   
                *)
                        echo "no such flag"
                        exit 0
                        ;;                   
        esac
else
    source=$(</home/vipul/Desktop.__source)
    des=$(<//home/vipul/Desktop.__des)
    # echo "No parameters, Actual backup job"
    # Find the base directory from -s address
    echo $source,$des
    source_dir=$(basename $source)
    # Making directory inside backup of the name sourcedirectory.
    backup_source="$des/$source_dir"
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
        mv -v $file_2 $file_3
    fi
    # Check if .1 exists
    if [ -d $file_1 ]; then
        # Delete the file
        mv -v $file_1 $file_2
    fi
    # copy sourcedir current state into .1
    cp -R $source $file_1
fi
