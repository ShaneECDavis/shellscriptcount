#! /bin/bash
# shell script to count lines or rename files in a directory

# $1 - stores the name of the directory
# $list - stores lists of files in $1 directory
# $file - stores name of file give from user
# $answer - stores input from user
# $count - stores how many lines in given file
# $changes - stores what changes has been made display old file tab new filename and then new line

# Directory name given as comman line argument
if [ $# -lt 1  ]; then
    echo "Usage: tool directory"
    exit 1
fi

# -d checks to makes sure directory is the argument entered, $1 <-- is the input, inputs get saved as $1, $2, and so on
if [ ! -d "$1"  ]; then
    echo "$1 is not a directory"
    exit 2
fi
# -r returns if it is readable or not.
if [ ! -r "$1" ]; then
    echo "$1 is not readable"
    exit 3
fi

# loope over file - For each file ask user whether to count lines in a file
# `` <- back tics means run this on command line then spit it out to be used in this scope. So lists will hold ls results as if ran on command line itself
list=`ls "$1"`
# this loops over $list with access to each part under file which you named. Similar to array.forEach(item => {}) item = file in this scope
for file in $list; do

    #ask user whether to rename or count
    echo "Give new file name for $file,"
    echo " or press Enter to get a line count: "
    # read <- is input and sets it into var -> answer
    read answer

    # handle count
    if [ "$answer" = ""  ]; then
        # getting line count
        # cat command gets name of file and the '|' causes what is given back to be used for wc -l. saves it all to count.
        count=`cat "$1"/$file | wc -l`

        # If count is different from a previous count, also display old count
        echo "$file has $count lines"

    else
        # To rename file
        mv "$1/$file" "$1/$answer"
        changes="$changes$file\t$answer\n"
    fi
# one ends the loop or in this case for just reads who inputs or data from $variable sent in
done
# Print list of files that were renamed
