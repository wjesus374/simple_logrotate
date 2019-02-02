#!/bin/bash

#Limite do arquivo em KB
LIMIT='307200'
#Arquivo/arquivos que será/serão rotacionado/s
FILE='messages.log'
#Sufixo do arquivo
SUFX='part'
#Nome da pasta do output
OUTDIR=$(date +"logrotate_%d-%m-%y-%s")
#Total do arquivo em KB
TOTAL=$(du -k $FILE | awk '{print $1}')

#Exemplos
#dd if=messages.log of=part2 bs=1024 count=307200 skip=307200
#split --verbose -a 4 -d --additional-suffix=.backup -b 200MB messages.log  msg

for FILEZ in $FILE
do
	mkdir -p $OUTDIR

	for SKIP in $(seq 0 $LIMIT $TOTAL)
	do
		VAR=$(($VAR+1))
		#echo "Parte $VAR: $SKIP"
		TEMPFILE=$(echo $FILEZ".$SUFX$VAR")
		#echo "dd if=$FILE of=$(echo "$TEMPFILE") bs=1024 count=$LIMIT skip=$SKIP"
		#echo "Gerando o arquivo: $TEMPFILE"
		dd if=$FILE of=$(echo "$TEMPFILE") bs=1024 count=$LIMIT skip=$SKIP 2> /dev/null
		#echo "gzip $TEMPFILE"
		echo "Compactando..."
		gzip $TEMPFILE
		echo "Removendo arquivo temporário"
		rm -f $TEMPFILE
		echo "Movendo..."
		mv $TEMPFILE.gz $OUTDIR
	done
	#Apagar o arquivo principal
	echo "Apagando o arquivo: $FILEZ"
	> $FILEZ
done
