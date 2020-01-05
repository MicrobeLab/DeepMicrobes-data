library(tidyverse)
library(export)
library(RColorBrewer)

color_list <- brewer.pal(12, 'Paired')
scaleFUN <- function(x) sprintf("%.2f", x)


# precision and recall, scatter plots

precision_tab <- read.csv('mock_precision_abun0_0001.csv')  # manually change to abun0_01
recall_tab <- read.csv('mock_recall_abun0_0001.csv')  # manually change to abun0_01

precision.gather <- precision_tab %>%
        gather(key='dataset', value = 'precision', -genus_identify)

recall.gather <- recall_tab %>%
        gather(key='dataset', value = 'recall', -genus_identify)

metric_tab <- merge(precision.gather, recall.gather)

metric_tab$genus_identify <- factor(metric_tab$genus_identify,
                                    levels = c('Kraken', 'Kraken 2',
                                               'CLARK', 'CLARK-S',
                                               'Centrifuge', 
                                               'Kaiju',
                                               'Diamond-MEGAN', 'BLAST-MEGAN',
                                               'DeepMicrobes'))

scatter_plot_0.01 <- ggplot(metric_tab, aes(x=recall, y=precision, color=genus_identify)) +
        #geom_point(size=1.8, shape=21, color='black', stroke = 0.35) +
        geom_jitter(size=2.0, width=0.005) +
        theme_bw() +
        xlab('Recall') + ylab('Precision') + 
        ggtitle('Genus identification') +
        scale_x_continuous(limits = c(0.68,1.01),
                           breaks = c(0.7, 0.8, 0.9, 1.0)) +
        scale_y_continuous(limits = c(0.14,1.0),
                           breaks = c(0.2, 0.4, 0.6, 0.8, 1.0)) +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(legend.text = element_text(size = 12, color = 'black')) +
        theme(legend.title = element_blank()) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        theme(#panel.grid.minor = element_blank(),
              panel.grid.major = element_blank(),
              panel.border = element_rect(colour = "black")) +
        scale_color_manual(values = c(color_list[c(3,4,7,8,10,12,5,6,2)]))

graph2ppt(scatter_plot_0.01, file='mock.pptx', append=TRUE, width=6, height=4.2)


scatter_plot_0.0001 <- ggplot(metric_tab, aes(x=recall, y=precision, 
                color=genus_identify)) +
        #geom_point(size=1.8, shape=21, color='black', stroke = 0.35) +
        #geom_jitter(size=2.5, width = 0.005, shape=21, stroke=0.0001) +
        geom_jitter(size=2.0, width=0.005) +
        theme_bw() +
        xlab('Recall') + ylab('Precision') + 
        ggtitle('Genus identification') +
        scale_x_continuous(limits = c(0.8,1.01),
                           breaks = c(0.8, 0.9, 1.0)) +
        scale_y_continuous(limits = c(0,0.33),
                           breaks = c(0.0, 0.1, 0.2, 0.3)) +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(legend.text = element_text(size = 12, color = 'black')) +
        theme(legend.title = element_blank()) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        theme(#panel.grid.minor = element_blank(),
                panel.grid.major = element_blank(),
                panel.border = element_rect(colour = "black")) +
        scale_color_manual(values = c(color_list[c(3,4,7,8,10,12,5,6,2)])) 
        

graph2ppt(scatter_plot_0.0001, file='mock.pptx', append=TRUE, width=6, height=4.2)


# l2 distance, genus

tab_l2_norm <- read.csv('mock_l2_norm_genus.csv')
df_l2_norm <- gather(tab_l2_norm, key = 'mock_sample', value = 'l2_norm', -Tool)

summer_l2_norm <- summarySE(df_l2_norm, measurevar = 'l2_norm', groupvars = 'Tool')

summer_l2_norm$Tool <- factor(summer_l2_norm$Tool,
                levels = c('Kraken', 'Kraken 2', 'CLARK', 'CLARK-S',
                                               'Centrifuge', 
                                               'Kaiju',
                                               'Diamond-MEGAN', 'BLAST-MEGAN',
                                               'DeepMicrobes'))

distance_bar_genus <- ggplot(summer_l2_norm, aes(x=Tool, y=l2_norm, fill=Tool)) +
        geom_bar(stat = 'identity', color='black') +
        #geom_point(data=df_l2_norm, mapping = aes(x=Tool, y=l2_norm),
                   #shape=21, color='gray', alpha=0.5) +
        geom_errorbar(aes(ymin=l2_norm-se, ymax=l2_norm+se),
                      width=0.25) +
        #theme_bw() +
        theme_classic() +
        xlab(NULL) + ylab('L2 distance') + 
        ggtitle('Genus quantification') +
        theme(legend.position = 'none') +
        #theme(panel.grid.minor = element_blank(),
              #panel.grid.major = element_blank(),
              #panel.border = element_rect(colour = "black")) +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust = 1)) +
        scale_y_continuous(expand = c(0,0), limits = c(0,0.01),
                           breaks = c(0,0.002,0.004,0.006,0.008,0.01)) +
        scale_fill_manual(values = c(color_list[c(3,4,7,8,10,12,5,6,2)])) 
        #geom_point(data=df_l2_norm, mapping = aes(x=Tool, y=l2_norm),
                  #shape=21, color='gray', alpha=0.5)


graph2ppt(distance_bar_genus, file='mock.pptx', append=TRUE, width=4.5, height=3.0)       


# classification rate, genus

tab_classi_rate <- read.csv('mock_classification_rate_genus.csv')
df_classi_rate <- gather(tab_classi_rate, key = 'mock_sample', value = 'classi_rate', -Tool)

summer_classi_rate <- summarySE(df_classi_rate, measurevar = 'classi_rate', groupvars = 'Tool')

summer_classi_rate$Tool <- factor(summer_classi_rate$Tool,
                              levels = c('Kraken', 'Kraken 2', 'CLARK', 'CLARK-S',
                                         'Centrifuge', 
                                         'Kaiju',
                                         'Diamond-MEGAN', 'BLAST-MEGAN',
                                         'DeepMicrobes'))



classi_rate_bar_genus <- ggplot(summer_classi_rate, aes(x=Tool, y=classi_rate, fill=Tool)) +
        geom_bar(stat = 'identity', color='black') +
        #geom_point(data=df_l1_norm, mapping = aes(x=Tool, y=l1_norm),
        #shape=21, color='gray', alpha=0.5) +
        geom_errorbar(aes(ymin=classi_rate-se, ymax=classi_rate+se),
                      width=0.25) +
        #theme_bw() +
        theme_classic() +
        xlab(NULL) + ylab('Classification rate (%)') + 
        ggtitle('Proportion of reads classified at the genus level') +
        theme(legend.position = 'none') +
        #theme(panel.grid.minor = element_blank(),
        #panel.grid.major = element_blank(),
        #panel.border = element_rect(colour = "black")) +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust = 1)) +
        scale_y_continuous(expand = c(0,0), limits = c(0,100),
                           breaks = c(0,20,40,60,80,100)) +
        scale_fill_manual(values = c(color_list[c(3,4,7,8,10,12,5,6,2)])) 

graph2ppt(classi_rate_bar_genus, file='mock.pptx', append=TRUE, width=4.5, height=3.0)   


# l2 distance, species

tab_l2_norm_species <- read.csv('mock_l2_norm_species.csv')
df_l2_norm_species <- gather(tab_l2_norm_species, key = 'mock_sample', value = 'l2_norm_species', -Tool)

summer_l2_norm_species <- summarySE(df_l2_norm_species, measurevar = 'l2_norm_species', groupvars = 'Tool')

summer_l2_norm_species$Tool <- factor(summer_l2_norm_species$Tool,
                              levels = c('Kraken', 'Kraken 2', 'CLARK', 'CLARK-S',
                                         'Centrifuge', 
                                         'Kaiju',
                                         'Diamond-MEGAN', 'BLAST-MEGAN',
                                         'DeepMicrobes'))

distance_bar_species <- ggplot(summer_l2_norm_species, aes(x=Tool, y=l2_norm_species, fill=Tool)) +
        geom_bar(stat = 'identity', color='black') +
        #geom_point(data=df_l2_norm_species, mapping = aes(x=Tool, y=l2_norm_species),
        #shape=21, color='gray', alpha=0.5) +
        geom_errorbar(aes(ymin=l2_norm_species-se, ymax=l2_norm_species+se),
                      width=0.25) +
        #theme_bw() +
        theme_classic() +
        xlab(NULL) + ylab('L2 distance') + 
        ggtitle('Species quantification') +
        theme(legend.position = 'none') +
        #theme(panel.grid.minor = element_blank(),
        #panel.grid.major = element_blank(),
        #panel.border = element_rect(colour = "black")) +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust = 1)) +
        scale_y_continuous(expand = c(0,0), limits = c(0,0.03),
                           breaks = c(0,0.01,0.02,0.03)) +
        scale_fill_manual(values = c(color_list[c(3,4,7,8,10,12,5,6,2)])) 



graph2ppt(distance_bar_species, file='mock.pptx', append=TRUE, width=4.5, height=3.0)       


# classification rate, species

tab_classi_rate <- read.csv('mock_classification_rate_species.csv')
df_classi_rate <- gather(tab_classi_rate, key = 'mock_sample', value = 'classi_rate', -Tool)

summer_classi_rate <- summarySE(df_classi_rate, measurevar = 'classi_rate', groupvars = 'Tool')

summer_classi_rate$Tool <- factor(summer_classi_rate$Tool,
                              levels = c('Kraken', 'Kraken 2', 'CLARK', 'CLARK-S',
                                         'Centrifuge', 
                                         'Kaiju',
                                         'Diamond-MEGAN', 'BLAST-MEGAN',
                                         'DeepMicrobes'))

classi_rate_bar_species <- ggplot(summer_classi_rate, aes(x=Tool, y=classi_rate, fill=Tool)) +
        geom_bar(stat = 'identity', color='black') +
        #geom_point(data=df_l1_norm, mapping = aes(x=Tool, y=l1_norm),
        #shape=21, color='gray', alpha=0.5) +
        geom_errorbar(aes(ymin=classi_rate-se, ymax=classi_rate+se),
                      width=0.25) +
        #theme_bw() +
        theme_classic() +
        xlab(NULL) + ylab('Classification rate (%)') + 
        ggtitle('Proportion of reads classified at the species level') +
        theme(legend.position = 'none') +
        #theme(panel.grid.minor = element_blank(),
        #panel.grid.major = element_blank(),
        #panel.border = element_rect(colour = "black")) +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust = 1)) +
        scale_y_continuous(expand = c(0,0), limits = c(0,100),
                           breaks = c(0,20,40,60,80,100)) +
        scale_fill_manual(values = c(color_list[c(3,4,7,8,10,12,5,6,2)])) 

graph2ppt(classi_rate_bar_species, file='mock.pptx', append=TRUE, width=4.5, height=3.0)   


