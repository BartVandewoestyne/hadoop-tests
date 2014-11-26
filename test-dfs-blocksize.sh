#!/bin/bash
#
# Test the influence of the dfs.blocksize configuration parameter on the
# write and read results of TestDFSIO.  Each blocksize is tested 3 times.

OUTPUTFILE=~/TestDFSIO_results_dfs_blocksize.log

cd /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce

#                64 MB    128 MB    256 MB    512 MB
for blocksize in 67108864 134217728 268435456 536870912
do
  for i in 1 2 3
  do
    hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -D dfs.blocksize=$blocksize -write -nrFiles 10 -fileSize 1000 -resFile $OUTPUTFILE
    hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -D dfs.blocksize=$blocksize  -read -nrFiles 10 -fileSize 1000 -resFile $OUTPUTFILE
    hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -clean
  done
done
