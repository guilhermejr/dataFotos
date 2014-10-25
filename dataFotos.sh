#!/bin/bash
#
# Desenvolvido por: Guilherme Jr. http://www.guilhermejr.net
# Licença de uso: GPL
#

# --- Formata data para ser usada no comando ---
DIA=$(echo $1 | cut -d/ -f 1)
MES=$(echo $1 | cut -d/ -f 2)
ANO=$(echo $1 | cut -d/ -f 3)
DATAFORMATADA="$ANO:$MES:$DIA"

# --- Função para a exibição do erro e sair ---
erro() {
   local MSG=$1
   echo "$MSG" >&2
   exit 1
}

# --- Valida número de parâmetros ---
if [ $# -ne 3 ]; then 
   erro "Modo de uso: $0 dd/mm/yyyy hh:mm:ss /caminho/das/fotos"
fi

# --- Valida data e hora ---
DATA="$1 $2"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
   date -d "$DATA UTC + 1 min" +"%d/%m/%Y %T" &> /dev/null
   test $? -eq 0 || erro "'$DATA': esta data é inválida."
elif [[ "$OSTYPE" == "darwin"* ]]; then
   TEST_DATETIME=$(date -v+1M -v-1M -jf "%d/%m/%Y %T" "$DATA" +"%d/%m/%Y %T" 2> /dev/null)
   if [[ "$TEST_DATETIME" != "$DATA" ]]; then
      erro "'$DATA': esta data é inválida."
   fi
fi

# --- Valida pasta ---
PASTA=$3
if [ ! -d "$PASTA" ]; then
   erro "Não foi possível acessar a pasta '$PASTA'"
fi

# --- Modifica a data ---
exiftool -AllDates=\'"$DATAFORMATADA $2"\' "$PASTA" 1>/dev/null 2>/dev/null

# --- Apaga os arquivos originais ---
exiftool -delete_original! "$PASTA" 1>/dev/null 2>/dev/null