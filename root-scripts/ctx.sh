#!/bin/bash
# ctx.sh ADDR [N]  -- show N instructions around ADDR in dec32_clean.txt
A=$1; N=${2:-10}
awk -v t="$A" -v n="$N" '
  { a=strtonum("0x" substr($1,1)); if (a>=t-n*4 && a<=t+n*4) print }
' dec32_clean.txt
