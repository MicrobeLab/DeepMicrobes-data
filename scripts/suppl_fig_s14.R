library(tidyverse)
library(export)

# l2 norm

tab_l2_norm <- read.csv('custom_kaiju_l2_norm_genus.csv')
df_l2_norm <- gather(tab_l2_norm, key = 'mock_sample', value = 'l2_norm', -Tool)

summer_l2_norm <- summarySE(df_l2_norm, measurevar = 'l2_norm', groupvars = 'Tool')

summer_l2_norm$Tool <- factor(summer_l2_norm$Tool,
                              levels = c('Kaiju', 'Kaiju-gut', 'DeepMicrobes'))

distance_bar_genus <- ggplot(summer_l2_norm, aes(x=Tool, y=l2_norm, fill=Tool)) +
        geom_bar(stat = 'identity', color='black') +
        geom_errorbar(aes(ymin=l2_norm-se, ymax=l2_norm+se),
                      width=0.25) +
        theme_classic() +
        xlab(NULL) + ylab('L2 distance') + 
        ggtitle('Genus\nquantification') +
        theme(legend.position = 'none') +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust = 1)) +
        scale_y_continuous(expand = c(0,0), limits = c(0,0.004),
                           breaks = c(0,0.001,0.002,0.003,0.004)) +
        scale_fill_manual(values = c("#B15928",'gold',"#1F78B4")) 

graph2ppt(distance_bar_genus, file='custom_kaiju.pptx', append=TRUE, width=3.0, height=3.0)       


# classification rate

tab_classi_rate <- read.csv('custom_kaiju_classification_rate_genus.csv')
df_classi_rate <- gather(tab_classi_rate, key = 'mock_sample', value = 'classi_rate', -Tool)

summer_classi_rate <- summarySE(df_classi_rate, measurevar = 'classi_rate', groupvars = 'Tool')

summer_classi_rate$Tool <- factor(summer_classi_rate$Tool,
                                  levels = c('Kaiju', 'Kaiju-gut', 'DeepMicrobes'))

classi_rate_bar_genus <- ggplot(summer_classi_rate, aes(x=Tool, y=classi_rate, fill=Tool)) +
        geom_bar(stat = 'identity', color='black') +
        geom_errorbar(aes(ymin=classi_rate-se, ymax=classi_rate+se),
                      width=0.25) +
        theme_classic() +
        xlab(NULL) + ylab('Classification rate (%)') + 
        ggtitle('Proportion of reads\nclassified at the genus level') +
        theme(legend.position = 'none') +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust = 1)) +
        scale_y_continuous(expand = c(0,0), limits = c(0,100),
                           breaks = c(0,20,40,60,80,100)) +
        scale_fill_manual(values = c("#B15928",'gold',"#1F78B4")) 

graph2ppt(classi_rate_bar_genus, file='custom_kaiju.pptx', append=TRUE, width=3.0, height=3.0)   


# precision/recall abun 0.01 0.0001

precision_tab_high <- read.csv('custom_kaiju_precision_abun0_01.csv')
recall_tab_high <- read.csv('custom_kaiju_recall_abun0_01.csv')

precision_tab_low <- read.csv('custom_kaiju_precision_abun0_0001.csv')
recall_tab_low <- read.csv('custom_kaiju_recall_abun0_0001.csv')

# -- high
precision_high.gather <- precision_tab_high %>%
        gather(key='dataset', value = 'precision', -genus_identify)
precision_high.gather$cutoff <- rep('0.01%', 30)

recall_high.gather <- recall_tab_high %>%
        gather(key='dataset', value = 'recall', -genus_identify)
recall_high.gather$cutoff <- rep('0.01%', 30)

metric_tab_high <- merge(precision_high.gather, recall_high.gather)

# -- low
precision_low.gather <- precision_tab_low %>%
        gather(key='dataset', value = 'precision', -genus_identify)
precision_low.gather$cutoff <- rep('0.0001%', 30)

recall_low.gather <- recall_tab_low %>%
        gather(key='dataset', value = 'recall', -genus_identify)
recall_low.gather$cutoff <- rep('0.0001%', 30)

metric_tab_low <- merge(precision_low.gather, recall_low.gather)

# -- combine low and high

metric_tab <- rbind(metric_tab_high, metric_tab_low)

metric_tab$genus_identify <- factor(metric_tab$genus_identify,
                                    levels = c('Kaiju', 'Kaiju-gut', 'DeepMicrobes'))
metric_tab$cutoff <- factor(metric_tab$cutoff, levels = c('0.01%', '0.0001%'))

scatter_plot <- ggplot(metric_tab, aes(x=recall, y=precision, 
                                       color=genus_identify, shape=cutoff)) +
        geom_jitter(size=1.8, width = 0.005, height = 0.01) +
        theme_bw() +
        xlab('Recall') + ylab('Precision') + 
        ggtitle('Genus identification') +
        scale_x_continuous(limits = c(0.90,1.01),
                           breaks = c(0.90,0.92,0.94, 0.96, 0.98,1.00)) +
        scale_y_continuous(limits = c(0,1.0),
                           breaks = c(0.0, 0.2, 0.4, 0.6, 0.8, 1.0)) +
        theme(axis.title = element_text(size = 12, color = 'black')) +
        theme(axis.text = element_text(size = 12, color = 'black')) +
        theme(legend.text = element_text(size = 12, color = 'black')) +
        theme(legend.title = element_blank()) +
        theme(plot.title = element_text(hjust = 0.5, size = 12, color = 'black')) +
        theme(#panel.grid.minor = element_blank(),
                panel.grid.major = element_blank(),
                panel.border = element_rect(colour = "black")) +
        scale_color_manual(values = c("#B15928",'gold',"#1F78B4")) +
        scale_shape_manual(values = c(17, 20))

graph2ppt(scatter_plot, file='custom_kaiju.pptx', append=TRUE, width=4.6, height=3)


