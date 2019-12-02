random_read_count <- function(seed_number, source_table, 
                             m=1, s=2, total_reads=10000000){
        set.seed(seed = seed_number)
        sample_times <- nrow(source_table)
        rd <- rlnorm(sample_times, m, s)
        rd_sum <- sum(rd)
        rd <- round(rd / rd_sum * total_reads)
        gold_standard_tab <- source_table
        gold_standard_tab$read_count <- rd
        # ensure sum to total_reads
        gold_standard_tab$read_count[sample_times] <- total_reads - sum(gold_standard_tab$read_count[1:(sample_times-1)])
        gold_standard_tab$abundance <- gold_standard_tab$read_count / sum(gold_standard_tab$read_count) * 100
        print(sum(gold_standard_tab$read_count))
        print(sum(gold_standard_tab$abundance))
        return(gold_standard_tab)
}




templete <- read.csv('mock_ground_truth_templete.csv')

# community-01
c01 <- random_read_count(11, templete)
write.table(c01, file = 'gold_standard_count_01.txt', 
            row.names = FALSE, quote = FALSE, sep = '\t')

# community-02
c02 <- random_read_count(2, templete)
write.table(c02, file = 'gold_standard_count_02.txt', 
            row.names = FALSE, quote = FALSE, sep = '\t')

# community-03
c03 <- random_read_count(333, templete)
write.table(c03, file = 'gold_standard_count_03.txt', 
            row.names = FALSE, quote = FALSE, sep = '\t')

# community-04
c04 <- random_read_count(44, templete)
write.table(c04, file = 'gold_standard_count_04.txt', 
            row.names = FALSE, quote = FALSE, sep = '\t')

# community-05
c05 <- random_read_count(5555, templete)
write.table(c05, file = 'gold_standard_count_05.txt', 
            row.names = FALSE, quote = FALSE, sep = '\t')

# community-06
c06 <- random_read_count(666, templete)
write.table(c06, file = 'gold_standard_count_06.txt', 
            row.names = FALSE, quote = FALSE, sep = '\t')

# community-07
c07 <- random_read_count(77, templete)
write.table(c07, file = 'gold_standard_count_07.txt', 
            row.names = FALSE, quote = FALSE, sep = '\t')

# community-08
c08 <- random_read_count(88, templete)
write.table(c08, file = 'gold_standard_count_08.txt', 
            row.names = FALSE, quote = FALSE, sep = '\t')

# community-09
c09 <- random_read_count(99, templete)
write.table(c09, file = 'gold_standard_count_09.txt', 
            row.names = FALSE, quote = FALSE, sep = '\t')

# community-10
c10 <- random_read_count(1010, templete)
write.table(c10, file = 'gold_standard_count_10.txt', 
            row.names = FALSE, quote = FALSE, sep = '\t')
