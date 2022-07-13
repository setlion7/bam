#!/usr/bin/env bash
set -x

if [ $# -ne 3 ]
then
	echo Usage $0 numssd gpuid tbsize && exit 1
fi

CTRL=$1
GPU=$2
TB=32
CS=8589934592
#T=4194304
E=137438953472
S=4096
#P=32768
NQ=128
QD=256
#for P in 32768 131072
#do
#    echo "++++++++++++++++++ $P Page size ++++++++++++++++++" 
    #for S in 512 1024 2048 4096
    #do
    #    echo "++++++++++++++++++ $S Sector size ++++++++++++++++++"
        for C in 4 #1 2 3 4
        do
            #echo "++++++++++++++++++ $C Controller ++++++++++++++++++"
            for P in 65536 #4096 8192 16384 32768 65536 131072 262144
            do
                echo "++++++++++++++++++ $P Page size ++++++++++++++++++"
            #for NQ in 32 64 96 128
            #do
            #    echo "++++++++++++++++++ $NQ Num queues ++++++++++++++++++"
                #for QD in 32 64 128 256 512 1024
                #do
                #echo "++++++++++++++++++ $QD Queue Depth ++++++++++++++++++"
                for T in 1024 2048 4096 8192 16384 32768 65536 131072 262144 524288 1048576 2097152 4194304 8388608
                do
                    echo "++++++++++++++++++ $T threads ++++++++++++++++++"
                    ./bin/nvm-pattern-bench --input_a /home/vsm2/bafsdata/GAP-kron.bel --memalloc 6 --n_ctrls $C -p $P --sectorsize $S --gpu $GPU --threads $T --n_elems $E --impl_type 1 --queue_depth $QD --num_queues $NQ --blk_size 128   | grep -e P:0 -e P:10 -e IOs -e Hit
                #done
            done
        done
    done 
#done
