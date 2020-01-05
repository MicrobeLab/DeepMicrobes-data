# Scripts used to benchmark different taxonomic classification tools

The command lines used to run each taxonomic classification tool and the R scripts for plotting.


## Command lines

The commands below assume that: <br>
* The forward and reverse reads are contained in `reads_R1.fastq` and `reads_R2.fastq`.
* The number of threads is specified as `$threads`.
* The path to database is specified as `$database`.

### Kraken

```sh
kraken --db $database --threads $threads --output kraken.out --paired reads_R1.fastq reads_R2.fastq
kraken-report --db $database kraken.out > kraken.report
```

### Kraken 2

```sh
kraken2 --db $database --paired reads_R1.fastq reads_R2.fastq --report kraken2.report --threads $threads > kraken2.out
```

### CLARK

```sh
classify_metagenome.sh -P reads_R1.fastq reads_R2.fastq -R clark -n $threads
estimate_abundance.sh -D $database -F clark.csv > clark_report.csv
```

### CLARK-<i>S</i>

```sh
classify_metagenome.sh -P reads_R1.fastq reads_R2.fastq -R clark_s -n $threads --spaced
estimate_abundance.sh -D $database -F clark_s.csv > clark_s_report.csv
```

### Centrifuge

```sh
centrifuge -p ${threads} -x $database \
-1 reads_R1.fastq -2 reads_R2.fastq \
--report-file centrifuge.tsv \
-S centrifuge.detail 
```

### Kaiju

```sh
kaiju -z $threads -t nodes.dmp -f $database -i reads_R1.fastq -j reads_R2.fastq -o kaiju.out
kaijuReport -t nodes.dmp -n names.dmp -i kaiju.out -r $rank -l superkingdom,phylum,class,order,family,genus,species -o kaiju.summary
```

### DIAMOND-MEGAN

```sh
diamond blastx -d $database -q reads_R1.fasta \
-f 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore staxids \
-p $threads -o R1.diamond

diamond blastx -d $database -q reads_R2.fasta \
-f 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore staxids \
-p $threads -o R2.diamond

blast2lca -i R1.diamond -f BlastTAB -o R1.diamondmegan.txt -tp 10

blast2lca -i R2.diamond -f BlastTAB -o R2.diamondmegan.txt -tp 10
```

### BLAST-MEGAN

```sh
blastn -db $database -query reads_R1.fasta -num_threads $threads -task megablast -evalue 1e-20 \
-outfmt '6 std staxids scomnames sscinames sskingdoms' \
-out R1.blast

blastn -db $database -query reads_R2.fasta -num_threads $threads -task megablast -evalue 1e-20 \
-outfmt '6 std staxids scomnames sscinames sskingdoms' \
-out R2.blast

blast2lca -i R1.blast -f BlastTAB -o R1.blastmegan.txt -tp 10

blast2lca -i R2.blast -f BlastTAB -o R2.blastmegan.txt -tp 10
```

### DeepMicrobes

```sh
# tfrec
tfrec_predict_kmer.sh \
	-f reads_R1.fastq \
	-r reads_R2.fastq \
	-t fastq \
	-v tokens_12mers.txt \
	-o sample_prefix \
	-s 4000000 \
	-k 12
	
# predict
export CUDA_VISIBLE_DEVICES=0

predict_DeepMicrobes.sh \
	-i sample_prefix.tfrec \
	-b 8192 \
	-l $rank \
	-p $num_parallel_calls \
	-m $model_dir \
	-o sample_prefix
	
# report
report_profile.sh \
	-i sample_prefix.result.txt \
	-o sample_prefix.profile.txt \
	-t 50 \
	-l name2label_species.txt 	
```


## Plotting scripts

The R scripts used to generate figures related to the comparison with other taxonomic classification tools. <br>
* Figure 3
* Figure 4
* Supplementary Figure S14

Please refer to each script for data required for plotting.
