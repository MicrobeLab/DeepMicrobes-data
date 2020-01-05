library(tidyverse)
library(export)

classi <- read.csv('unk_classified.csv')
simi <- read.csv('unk_similar_metadata.csv')

simi$genome_prefix <- gsub('_genomic.fna', '', simi$qname)

tab_info <- merge(classi, simi)
write.csv(tab_info, file = 'unk_merge_info.csv')

#classified_percent_tab <- tab_info[, c(1,2,4,6,8,10, 15,16,17,19,20,21)]

# -- x:ani y:percent
percent_ani <- ggplot(tab_info) +
        
        # deeplearning
        geom_point(aes(x=ani_to_train, y=deep_classified_percent), color=color_list[2],
                   size=0.35) +
        geom_smooth(aes(x=ani_to_train, y=deep_classified_percent), 
                    color=color_list[2], method='lm', size=0.6) +
        
        # kraken2
        geom_point(aes(x=ani_to_refseq, y=kraken2_classified_percent), color=color_list[4],
                   size=0.35) +
        geom_smooth(aes(x=ani_to_refseq, y=kraken2_classified_percent), 
                    color=color_list[4], method='lm', size=0.6) +
        
        # kraken
        geom_point(aes(x=ani_to_refseq, y=kraken_classified_percent), color=color_list[3],
                   size=0.35) +
        geom_smooth(aes(x=ani_to_refseq, y=kraken_classified_percent), 
                    color=color_list[3], method='lm', size=0.6) +
        
        # clark
        geom_point(aes(x=ani_to_refseq, y=clark_classified_percent), color=color_list[7],
                   size=0.35) +
        geom_smooth(aes(x=ani_to_refseq, y=clark_classified_percent), 
                    color=color_list[7], method='lm', size=0.6) +
        
        # clark-s
        geom_point(aes(x=ani_to_refseq, y=clark.s_classified_percent), color=color_list[8],
                   size=0.35) +
        geom_smooth(aes(x=ani_to_refseq, y=clark.s_classified_percent), 
                    color=color_list[8], method='lm', size=0.6) +
        
        theme_classic() +
        scale_y_continuous(expand = c(0,0), limits = c(0,100),
                           breaks = c(0,20,40,60,80,100)) +
        scale_x_continuous(limits = c(82.945,90),
                           breaks = c(83,84,85,86,87,88,89,90)) +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        xlab('ANI to the closest genome in database (%)') +
        ylab('Classification rate (%)') +
        ggtitle('Proportion of reads classified\nat the species level') 
        

graph2ppt(percent_ani, file='unk.pptx', append=TRUE, width=4.0, height=3.0)   



# -- x:qalign y:percent
percent_qalign <- ggplot(tab_info) +
        
        # deeplearning
        geom_point(aes(x=qalign_to_train, y=deep_classified_percent), color=color_list[2],
                   size=0.35) +
        geom_smooth(aes(x=qalign_to_train, y=deep_classified_percent), 
                    color=color_list[2], method='lm', size=0.6) +
        
        # kraken2
        geom_point(aes(x=qalign_to_refseq, y=kraken2_classified_percent), color=color_list[4],
                   size=0.35) +
        geom_smooth(aes(x=qalign_to_refseq, y=kraken2_classified_percent), 
                    color=color_list[4], method='lm', size=0.6) +
        
        # kraken
        geom_point(aes(x=qalign_to_refseq, y=kraken_classified_percent), color=color_list[3],
                   size=0.35) +
        geom_smooth(aes(x=qalign_to_refseq, y=kraken_classified_percent), 
                    color=color_list[3], method='lm', size=0.6) +
        
        # clark
        geom_point(aes(x=qalign_to_refseq, y=clark_classified_percent), color=color_list[7],
                   size=0.35) +
        geom_smooth(aes(x=qalign_to_refseq, y=clark_classified_percent), 
                    color=color_list[7], method='lm', size=0.6) +
        
        # clark-s
        geom_point(aes(x=qalign_to_refseq, y=clark.s_classified_percent), color=color_list[8],
                   size=0.35) +
        geom_smooth(aes(x=qalign_to_refseq, y=clark.s_classified_percent), 
                    color=color_list[8], method='lm', size=0.6) +
        
        theme_classic() +
        scale_y_continuous(expand = c(0,0), limits = c(0,100),
                           breaks = c(0,20,40,60,80,100)) +
        scale_x_continuous(limits = c(10, 60),
                           breaks = c(10,20,30,40,50,60)) +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        xlab('Genome aligned to the closest genome in database (%)') +
        ylab('Classification rate (%)') +
        ggtitle('Proportion of reads classified\nat the species level') 


graph2ppt(percent_qalign, file='unk.pptx', append=TRUE, width=4.0, height=3.0)  




# -- x:mash y:percent
percent_mash <- ggplot(tab_info) +
        
        # deeplearning
        geom_point(aes(x=mash_to_train, y=deep_classified_percent), color=color_list[2],
                   size=0.35) +
        geom_smooth(aes(x=mash_to_train, y=deep_classified_percent), 
                    color=color_list[2], method='lm', size=0.6) +
        
        # kraken2
        geom_point(aes(x=mash_to_refseq, y=kraken2_classified_percent), color=color_list[4],
                   size=0.35) +
        geom_smooth(aes(x=mash_to_refseq, y=kraken2_classified_percent), 
                    color=color_list[4], method='lm', size=0.6) +
        
        # kraken
        geom_point(aes(x=mash_to_refseq, y=kraken_classified_percent), color=color_list[3],
                   size=0.35) +
        geom_smooth(aes(x=mash_to_refseq, y=kraken_classified_percent), 
                    color=color_list[3], method='lm', size=0.6) +
        
        # clark
        geom_point(aes(x=mash_to_refseq, y=clark_classified_percent), color=color_list[7],
                   size=0.35) +
        geom_smooth(aes(x=mash_to_refseq, y=clark_classified_percent), 
                    color=color_list[7], method='lm', size=0.6) +
        
        # clark-s
        geom_point(aes(x=mash_to_refseq, y=clark.s_classified_percent), color=color_list[8],
                   size=0.35) +
        geom_smooth(aes(x=mash_to_refseq, y=clark.s_classified_percent), 
                    color=color_list[8], method='lm', size=0.6) +
        
        theme_classic() +
        scale_y_continuous(expand = c(0,0), limits = c(0,100),
                           breaks = c(0,20,40,60,80,100)) +
        scale_x_continuous(limits = c(10, 60),
                           breaks = c(10,20,30,40,50,60)) +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        xlab('Genome aligned to the closest genome in database (%)') +
        ylab('Classification rate (%)') +
        ggtitle('Proportion of reads classified\nat the species level') 


graph2ppt(percent_mash, file='unk.pptx', append=TRUE, width=4.0, height=3.0)  


# -- x:ani y:species_num
species.num_ani <- ggplot(tab_info) +
        
        # deeplearning
        geom_point(aes(x=ani_to_train, y=deep_identfied_species), color=color_list[2],
                   size=0.35) +
        geom_smooth(aes(x=ani_to_train, y=deep_identfied_species), 
                    color=color_list[2], method='lm', size=0.6) +
        
        # kraken2
        geom_point(aes(x=ani_to_refseq, y=kraken2_idenfied_species), color=color_list[4],
                   size=0.35) +
        geom_smooth(aes(x=ani_to_refseq, y=kraken2_idenfied_species), 
                    color=color_list[4], method='lm', size=0.6) +
        
        # kraken
        geom_point(aes(x=ani_to_refseq, y=kraken_idenfied_species), color=color_list[3],
                   size=0.35) +
        geom_smooth(aes(x=ani_to_refseq, y=kraken_idenfied_species), 
                    color=color_list[3], method='lm', size=0.6) +
        
        # clark
        geom_point(aes(x=ani_to_refseq, y=clark_identified_species), color=color_list[7],
                   size=0.35) +
        geom_smooth(aes(x=ani_to_refseq, y=clark_identified_species), 
                    color=color_list[7], method='lm', size=0.6) +
        
        # clark-s
        geom_point(aes(x=ani_to_refseq, y=clark.s_identified_species), color=color_list[8],
                   size=0.35) +
        geom_smooth(aes(x=ani_to_refseq, y=clark.s_identified_species), 
                    color=color_list[8], method='lm', size=0.6) +
        
        theme_classic() +
        scale_y_continuous(expand = c(0,0), limits = c(0,600),
                           breaks = c(0,100,200,300,400,500,600)) +
        scale_x_continuous(limits = c(82.945,90),
                           breaks = c(83,84,85,86,87,88,89,90)) +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        xlab('ANI to the closest genome in database (%)') +
        ylab('Count') +
        ggtitle('Number of identified species') 


graph2ppt(species.num_ani, file='unk.pptx', append=TRUE, width=4.0, height=3.0)   



# -- x:qalign y:species_num
species.num_qalign <- ggplot(tab_info) +
        
        # deeplearning
        geom_point(aes(x=qalign_to_train, y=deep_identfied_species), color=color_list[2],
                   size=0.35) +
        geom_smooth(aes(x=qalign_to_train, y=deep_identfied_species), 
                    color=color_list[2], method='lm', size=0.6) +
        
        # kraken2
        geom_point(aes(x=qalign_to_refseq, y=kraken2_idenfied_species), color=color_list[4],
                   size=0.35) +
        geom_smooth(aes(x=qalign_to_refseq, y=kraken2_idenfied_species), 
                    color=color_list[4], method='lm', size=0.6) +
        
        # kraken
        geom_point(aes(x=qalign_to_refseq, y=kraken_idenfied_species), color=color_list[3],
                   size=0.35) +
        geom_smooth(aes(x=qalign_to_refseq, y=kraken_idenfied_species), 
                    color=color_list[3], method='lm', size=0.6) +
        
        # clark
        geom_point(aes(x=qalign_to_refseq, y=clark_identified_species), color=color_list[7],
                   size=0.35) +
        geom_smooth(aes(x=qalign_to_refseq, y=clark_identified_species), 
                    color=color_list[7], method='lm', size=0.6) +
        
        # clark-s
        geom_point(aes(x=qalign_to_refseq, y=clark.s_identified_species), color=color_list[8],
                   size=0.35) +
        geom_smooth(aes(x=qalign_to_refseq, y=clark.s_identified_species), 
                    color=color_list[8], method='lm', size=0.6) +
        
        theme_classic() +
        scale_y_continuous(expand = c(0,0), limits = c(0,600),
                           breaks = c(0,100,200,300,400,500,600)) +
        scale_x_continuous(limits = c(10, 60),
                           breaks = c(10,20,30,40,50,60)) +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        xlab('Genome aligned to the closest genome in database (%)') +
        ylab('Count') +
        ggtitle('Number of identified species') 


graph2ppt(species.num_qalign, file='unk.pptx', append=TRUE, width=4.0, height=3.0)   

