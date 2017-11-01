#!/bin/bash

export INPUTFILE=/work/input.txt
export PAPLOT_NAME=paplot

#############
# optional
#############
export OUTPUTFILE=/work/pmsignature
export TRDIRFLAG=FALSE
export TRIALNUM=10
#export BGFLAG=TRUE
export BS_GENOME="BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19"
export TXDB_TRANSCRIPT="TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene"
export OUTPUTPAPLOT=/work/${PAPLOT_NAME}

#############
# run
#############

for SIGNUM in `seq 2 6`
do
    # full
    R --vanilla --slave --args ${INPUTFILE} ${OUTPUTFILE}.${SIGNUM}.full.RData ${SIGNUM} ${TRDIRFLAG} ${TRIALNUM} FALSE ${BS_GENOME} ${TXDB_TRANSCRIPT} <  /home/docker/genomon_Rscripts-0.1.3/pmsignature/run_pmsignature_full.R
    R --vanilla --slave --args ${OUTPUTFILE}.${SIGNUM}.full.RData ${OUTPUTFILE}.${SIGNUM}.full.json < /home/docker/genomon_Rscripts-0.1.3/pmsignature/convert_toJson_full.R
    paplot signature ${OUTPUTFILE}.${SIGNUM}.full.json ${OUTPUTPAPLOT} ${PAPLOT_NAME} -c /home/docker/paplot-0.5.5/paplot.cfg

    # ind
    R --vanilla --slave --args ${INPUTFILE} ${OUTPUTFILE}.${SIGNUM}.ind.RData ${SIGNUM} ${TRDIRFLAG} ${TRIALNUM} TRUE ${BS_GENOME} ${TXDB_TRANSCRIPT} < /home/docker/genomon_Rscripts-0.1.3/pmsignature/run_pmsignature_ind.R
    R --vanilla --slave --args ${OUTPUTFILE}.${SIGNUM}.ind.RData ${OUTPUTFILE}.${SIGNUM}.ind.json < /home/docker/genomon_Rscripts-0.1.3/pmsignature/convert_toJson_ind.R
    paplot pmsignature ${OUTPUTFILE}.${SIGNUM}.ind.json ${OUTPUTPAPLOT} ${PAPLOT_NAME} -c /home/docker/paplot-0.5.5/paplot.cfg
done
