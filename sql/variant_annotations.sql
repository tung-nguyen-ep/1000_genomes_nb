# The following query join variants from 1000_genomes table and their annotations from Tute databases
# then filter to display relevant clinical diseases

SELECT
  annots.Chr AS chromosome,
  annots.Start AS start,
  annots.End AS end,
  annots.Ref AS reference_bases,
  annots.Alt AS alternate_bases,
  Gene,
  ExonicFunc,
  ClinVar_DIS,
  GWAS_DIS
FROM
  [silver-wall-555:TuteTable.hg19] AS annots
JOIN EACH
  FLATTEN ((
    SELECT
      reference_name,
      start,
      reference_bases,
      alternate_bases,
    FROM
      [genomics-public-data:1000_genomes.variants] 
    ),
    alternate_bases) AS vars
ON
  vars.reference_name = annots.Chr 
  AND vars.start = annots.Start 
  AND vars.reference_bases = annots.Ref 
  AND vars.alternate_bases = annots.Alt 
WHERE
  ClinVar_DIS IS NOT NULL OR ExonicFunc IS NOT NULL OR GWAS_DIS IS NOT NULL
GROUP BY
  chromosome,
  start,
  end,
  reference_bases,
  alternate_bases,
  Gene,
  ExonicFunc,
  ClinVar_DIS,
  GWAS_DIS
ORDER BY
  chromosome,
  start

