#!/bin/bash
#
# Test the influence of the dfs.replication configuration parameter on the
# write and read results of TestDFSIO.  Each replication factor is tested 3
# times.

OUTPUTFILE=~/TestDFSIO_results_dfs_replication.log

cd /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce

for repfac in 1 2 3
do
  for i in 1 2 3
  do
    hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -D dfs.replication=$repfac -write -nrFiles 10 -fileSize 1000 -resFile $OUTPUTFILE
    hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -D dfs.replication=$repfac  -read -nrFiles 10 -fileSize 1000 -resFile $OUTPUTFILE
    hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -clean
  done
done

# TODO: post-processing of the output log file to nicely summarize the results.
#
# To view output of write tests:
#
#   cat TestDFSIO_results_dfs_replication.log | grep Throughput | awk 'NR%2==1'
