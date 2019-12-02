# Benchmark datasets

## Reads simulated from 3,269 gut-derived MAGs
The metagenome-assembled genomes (MAGs) were reconstructed from human gut microbiomes.
Please refer to `metadata_gut-derived_MAGs.txt` for detailed information of each MAG.

We simulated 10,000 pair-end reads per MAG with ART simulator: -ss HS25 -m 400 -s 50 <br>
This 150bp dataset is available [here](https://mail2sysueducn-my.sharepoint.com/:u:/g/personal/liangqx7_mail2_sysu_edu_cn/ESn6U1mtyi9LlK5AV_1tYlsBVGNLfXCmoUIxtYtNC_tGJQ?e=NaPhyV).

<b>To trim the 150bp reads from 3'end to 75-150bp:</b> 
```
python random_trim.py -i input_fastq -o output_fasta -f fastq -l 150 -min 0 -max 75
```
Arguments:  
`-i` input fastq/fasta sequences (fixed-length) <br>
`-o` output fasta sequences (variable-length) <br>
`-f` input file type (fastq/fasta) <br>
`-l` length of the input sequences <br>
`-min` minimum number of trimmed bases <br>
`-max` maximum number of trimmed bases <br>


The other fixed-length datasets can be downloaded here:
* [75bp](https://mail2sysueducn-my.sharepoint.com/:u:/g/personal/liangqx7_mail2_sysu_edu_cn/ESNSL4NKyoZGhHVx4ZIEpVEBip1jBVoR89Fpy1BiLO_FYg?e=41M3xc)
* [100bp](https://mail2sysueducn-my.sharepoint.com/:u:/g/personal/liangqx7_mail2_sysu_edu_cn/EQRDB48RU0NGvxA_F6EXS5ABnWFuMvxOKMGV5lN9ugKI6A?e=jLZGw5)
* [125bp](https://mail2sysueducn-my.sharepoint.com/:u:/g/personal/liangqx7_mail2_sysu_edu_cn/EZfonx-_OxJDqzrwfsz6k-0BpN1KRSpcZ6Tcw-AiwTM6JA?e=k5T5Wn)
* [250bp](https://mail2sysueducn-my.sharepoint.com/:u:/g/personal/liangqx7_mail2_sysu_edu_cn/Ee4myhQScZZBg_5LhAs7AqsBmmWRGw1ordbXVswsTskypQ?e=kAmrDf)


## Mock communities

The number of reads sampled from each bacterial isolate sequencing run was generated using `gold_standard_random.R`

The fastq sequences of the ten mock communities can be download [here](https://mail2sysueducn-my.sharepoint.com/:f:/g/personal/liangqx7_mail2_sysu_edu_cn/EqFHilmYdLFLq-HXuExMWZsBObz8ovyjydfgqEvV2mUk5g?e=vQ1nFd).

## Reads simulated from species absent from reference databases

The variable-length 1x coverage reads for each of the 121 absent genomes can be downloaded [here](https://mail2sysueducn-my.sharepoint.com/:u:/g/personal/liangqx7_mail2_sysu_edu_cn/EQyqDjMN7SpHrvkaTbCAMnMBktnbWdsBupFwSc7PnvSlEA?e=4mXttO).
