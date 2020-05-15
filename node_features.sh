#!/bin/sh

###
# Determine slurm node features
###
# -- CPU features
#   * CPU_GEN: CPU generation: SNB|IVB|HSW|BDW|SKX|CNL
#   * CPU_SKU: CPU model     : E5-2640v2
#   * CPU_FRQ: CPU frequency : 2.60GHz
#
# -- GPU features
#   * GPU_GEN: GPU generation: KPL|MXW|PSC|VLT
#   * GPU_SKU: GPU model     : TITAN_{BLACK,X,Xp}|TESLA_{K{20,80},P40,P100}
#   * GPU_MEM: GPU memory    : 8GB
#   * GPU_CC:  GPU Compute Capability : 3.5|3.7|6.1

# use https://en.wikipedia.org/wiki/CUDA to detrmine CC

cat /proc/cpuinfo | sort | uniq | awk '
/model name/ {split($0,a,":"); split(a[2],b," @ "); 
  print "CPU_FRQ:"b[2]; 
  split(b[1],c," CPU "); 
    if( c[2] == "" ){ gsub(/[^0-9]/,"",c[1]); print "CPU_SKU:"c[1] }
    else{ gsub(" ", "", c[2]); print "CPU_SKU:"c[2] }
}
#/flags/ && /avx2/ { print $0 }
/flags/ && /avx2/ && !/avx512/{ print "CPU_GEN:HSW" }
/flags/ && /avx512/ { print "CPU_GEN:SKX" }
'

if [ "$1" == "--no-gpu" ]; then
  exit 0;
fi

if which nvidia-smi 2>&1 >/dev/null; then
  nvidia-smi --query-gpu=gpu_name,memory.total,driver_version --format=csv,noheader | sort | uniq | awk '{ split($0,a,", ");
    gsub(" ", "", a[1]); split(a[1],b,"-");
    if( b[1] ~ /Tesla/ ){
      gsub("Tesla","",b[1])
      if( b[1] ~ /P100/ ){ gen="PSC"; cc="6.0" }
      else if( b[1] ~ /K80/ ){ gen="KPL"; b[3]="12GB"; cc="3.7" }
      else if( b[1] ~ /V100/ ){ gen="VLT"; cc="7.0" }
    }
    else if( b[1] ~ /TITAN/ ){
      if( b[1] ~ /Xp/ ){ gen="PSC"; b[3]="12GB"; cc="6.1" }
    }
    else if( b[1] ~ /GeForce/ ){
      gsub("GeForce","",b[1])
      if( b[1] ~ /1080Ti/ ){ gen="PSC"; b[3]="11GB"; cc="6.1" }
      if( b[1] ~ /2080Ti/ ){ gen="TUR"; b[3]="11GB"; cc="7.5"; b[1]="RTX2080Ti" }
    }
    gsub(" ","",b[1])
    print "GPU_SKU:"b[1]
    print "GPU_GEN:"gen
    print "GPU_MEM:"b[3]
    print "GPU_DRV:"a[3]
    print "GPU_CC:"cc
  }'
fi
