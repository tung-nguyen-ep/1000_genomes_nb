
source("./get_started.R");

library(bigrquery);
library(ISBCGCExamples);

library(RColorBrewer);
library(plotly);



# ==================================================================================================
# figure 1 - using 1000_genomes table and Tute table annotations


#result <- DisplayAndDispatchQuery("./sql/variant_annotations.sql");
result <- read.csv(gzfile('./output/results-fig1.csv.gz','rt'), header=TRUE, sep=",", stringsAsFactors=FALSE);
head(result)


# extract count statistic data
chr = c(1:22, "X", "Y");
types = c(unique(result$ExonicFunc), "disease", "GWAS_disease");
types = types[types!=""];
data = c();
for (i in 1:length(chr)){
	idx = which(result$chromosome==chr[i]);
	count = c(0, length(types));
	for (j in 1:length(types)){
		if (types[j]=="disease"){
			idx2 = which(result$ClinVar_DIS[idx]!="");
		} else if (types[j]=="GWAS_disease"){
			idx2 = which(result$GWAS_DIS[idx]!="");
		} else { 
			idx2 = which(result$ExonicFunc[idx]==types[j]);
		}
		count[j] = length(idx2);
	}
	data = rbind(data, c(chr[i], count));
}

df = data.frame(chr=paste("chr",data[,1],sep=""), stringsAsFactors=FALSE);
for (j in 1:length(types)){ df[types[j]] = as.numeric(data[,j+1]); }


# plotting
xaxis <- list(title="", showgrid=F, zeroline=T, showline=T,
			  showticklabels=T, tickmode='array', tickvals=c(0:nrow(df)), ticktext=df[,1]);
yaxis <- list(title="Count", showgrid=T, zeroline=F, showline=F, linewidth=2,
			  showticklabels=T, autotick=T, ticks='outside', range = c(0,2000));


title = "Distribution of annotated variants with their phenotypic functions";
plot_ly(df, x= ~chr, y= ~missense, name='missense', type='bar') %>%
	add_trace(y= ~nonsense, name='nonsense') %>%
	add_trace(y= ~silent,   name='silent') %>%
	add_trace(y= ~stoploss, name='stoploss') %>%
	add_trace(y= ~disease,  name='disease') %>%
	add_trace(y= ~GWAS_disease, name='GWAS_disease') %>%
	layout(title=title, xaxis=xaxis, yaxis=yaxis, barmode='group');





# ==================================================================================================
# figure 2 - using 1000_genomes table: 1000_genomes.variants & 1000_genomes.sample_info


#result <- DisplayAndDispatchQuery("./sql/brca1_allelic_population_effect.sql");
result <- read.csv(gzfile('./output/results-fig2.csv.gz','rt'), header=TRUE, sep=",", stringsAsFactors=FALSE);
head(result)


# prepare plot data
df = data.frame(x=c(1:nrow(result)), start=result$start, freq=result$alt_freq, pop=result$population);
pop = sort(unique(df$pop));
cols = colorRampPalette(c("red", "green", "blue"))(n=length(pop));
df$color = cols[1];
for (i in 2:length(cols)){
	df$color[which(df$pop==pop[i])] = cols[i];
}
df$text = paste("Pop: ", df$pop, '<br>start: ', df$start, sep="");


# plotting
xaxis <- list(title=paste("variants 1 -> ",nrow(df),sep=""), showgrid=F, zeroline=F, showline=T,
			  showticklabels=F, tickmode='array', tickvals=c(1:nrow(df)), ticktext=c(1:nrow(df)));
yaxis <- list(title="Alternate allelic frequency", showgrid=F, zeroline=F, showline=T, linewidth=2,
			  showticklabels=T, autotick=T, ticks='outside');


title = "Population effect to mutation frequency of variants in BRCA1-a human tumor suppressor gene";
plot_ly(df, x= ~x, y= ~freq,  name='', type='scatter', color= ~pop, colors=cols, text= ~text, mode='markers', 
		marker=list(sizemode='diameter', size=5)) %>%
		layout(title=title, showlegend=T, xaxis=xaxis, yaxis=yaxis);


# 

