#!/bin/bash
#
# Test the influence of the dfs.replication configuration parameter on the
# write and read results of TestDFSIO.  Each replication factor is tested 3
# times.

OUTPUTFILE=~/TestDFSIO_results_dfs_replication.log

cd /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce

# Replication factor 3.
for i in 1 2 3
do
  hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -D dfs.replication=3 -write -nrFiles 10 -fileSize 1000 -resFile $OUTPUTFILE
  hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -D dfs.replication=3  -read -nrFiles 10 -fileSize 1000 -resFile $OUTPUTFILE
  hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -clean
done

# Replication factor 2.
for i in 1 2 3
do
  hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -D dfs.replication=2 -write -nrFiles 10 -fileSize 1000 -resFile $OUTPUTFILE
  hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -D dfs.replication=2  -read -nrFiles 10 -fileSize 1000 -resFile $OUTPUTFILE
  hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -clean
done

# Replication factor 1.
for i in 1 2 3
do
  hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -D dfs.replication=1 -write -nrFiles 10 -fileSize 1000 -resFile $OUTPUTFILE
  hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -D dfs.replication=1  -read -nrFiles 10 -fileSize 1000 -resFile $OUTPUTFILE
  hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -clean
done

# TODO: post-processing of the output log file to nicely summarize the results.
