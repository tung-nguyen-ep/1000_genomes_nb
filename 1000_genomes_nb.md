1000 Genomes: Exploration and Proposal Notebook
-----------------------------------------------

``` r
#head(result)
```

Population effects to mutation frequency of variants - a case of BRCA1
----------------------------------------------------------------------

``` r
result <- read.csv(gzfile('./output/results-fig2.csv.gz','rt'), header=TRUE, sep=",", stringsAsFactors=FALSE);
```

    ## Warning in read.table(file = file, header = header, sep = sep, quote =
    ## quote, : seek on a gzfile connection returned an internal error

    ## Warning in read.table(file = file, header = header, sep = sep, quote =
    ## quote, : seek on a gzfile connection returned an internal error

``` r
head(result)
```

    ##   reference_name    start population reference_bases alt
    ## 1             17 41196362        ASW               C   T
    ## 2             17 41196362        CEU               C   T
    ## 3             17 41196362        CHB               C   T
    ## 4             17 41196362        CHS               C   T
    ## 5             17 41196362        CLM               C   T
    ## 6             17 41196362        FIN               C   T
    ##   num_sample_alleles ref_cnt alt_cnt  ref_freq    alt_freq
    ## 1                122     122       0 1.0000000 0.000000000
    ## 2                170     167       3 0.9823529 0.017647059
    ## 3                194     194       0 1.0000000 0.000000000
    ## 4                200     200       0 1.0000000 0.000000000
    ## 5                120     120       0 1.0000000 0.000000000
    ## 6                186     185       1 0.9946237 0.005376344

<a href="figures/fig2.html" target="_blank"><img src='figures/fig2.png'> Hello, world!</a>

[![Figure](figures/fig2.png)](figures/fig2.html)

![](figures/fig2.png)
