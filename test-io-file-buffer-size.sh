# Test the influence of io.file.buffer.size on the TestDFSIO results.

cd /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce

hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -clean
for size in 4096 16384 32768 65536 131072
do
  hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -D io.file.buffer.size=$size -write -nrFiles 10 -fileSize 10000 -resFile ~/TestDFSIO_results_io_file_buffer_size.log
  hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -D io.file.buffer.size=$size  -read -nrFiles 10 -fileSize 10000 -resFile ~/TestDFSIO_results_io_file_buffer_size.log
  hadoop jar hadoop-*test*.jar TestDFSIO -D test.build.data=/user/bart/TestDFSIO -clean
done
