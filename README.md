duplicates.sh
=============

Make sure that all the scripts handle errors in a reasonable way and test for valid user input. You should give the user a meaningful error message in case he/she misused the script or if an error occurred.

###Problem 1:

Write a shell script “duplicates.sh” that will find duplicate files in a given directory tree. This utility will check duplicate files based on content and not name.
It shall take exactly 1 command line argument:
1.	A path to a directory on the file system

This script will generate a report which is displayed on stdout and should contain the following
+	For each set of duplicate files, print a header that states:
 + The number of instances of that file
 + The size of each instance of the file (in a human readable format — e.g. B, K, M, G) (they should all have the same size!)
+	For each set of duplicate files, after the header, the report shall list each file (path + filename)

At the end the script should output the total number of duplicate files and their total size (also in a human readable form).

The number of duplicates is not the total number of files because the user would want to keep at least one copy out of each group. So, the duplicate count is the total number of files - the number of groups.

For the purposes of this assignment 1K = 1000B, 1M = 1000K, 1G = 1000M.
