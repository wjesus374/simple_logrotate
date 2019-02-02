#!/bin/bash

#Diretório
#Usar o * (asterisco) para sub-diretórios e/ou expressão regular
#Exemplo: #LOGDIR='/pasta/*/diretorio[1-3]*'
LOGDIR='/home/wjesus/git/simplelogrotate/logs_exemplo'
#E/OU defina os arquivos
#Definindo os arquivos manualmente, não use sub-diretórios ou coringas na variável LOGDIR (não coloque / no final)
FILES='exemplo1.log exemplo2.log'
#Se achar necessário filtre novamente 
#FILEEXPR='^.*log$'
#Criar os arquivos de backup no diretório
BACKUPDIR='/home/wjesus/git/simplelogrotate/logs_exemplo/logsbackup'

#Checkdirs
#if [[ ! -d $LOGDIR ]]
#then
#	echo "Diretório de logs não encontrado: $LOGDIR"
#	echo "Saindo do script"
#	exit 1
#fi

#if [[ ! -d $BACKUPDIR ]]
#then
#	echo "Diretório de backup não encontrado! $BACKUPDIR"
#	echo "Criando diretório..."
#	mkdir -p $BACKUPDIR
#fi

if [[ -z $FILES ]]
then

	for FILE in $(ls -d $LOGDIR | egrep "$FILEEXPR")
	do
	#	echo $FILE
		BKPFILE="$FILE$(echo "_$(date +"%d-%m-%Y")"_backup)"
		cp $LOGDIR/$FILE $BACKUPDIR/$BKPFILE
		> $LOGDIR/$FILE
		gzip $BACKUPDIR/$BKPFILE
	done
else

	for FILESZ in $FILES
	do
	#	echo "$LOGDIR/$FILESZ"
		FILE="$(echo "$LOGDIR/$FILESZ")"
		BKPFILE="$FILE$(echo "_$(date +"%d-%m-%Y")"_backup)"
		cp $LOGDIR/$FILE $BACKUPDIR/$BKPFILE
		> $LOGDIR/$FILE
		gzip $BACKUPDIR/$BKPFILE
	done
fi

# Remover os arquivos mais antigos que 7 dias do backup
find $BACKUPDIR/*.gz -maxdepth 1 -mtime +7 -exec rm -rf {}\;
exit 0

