#!/bin/bash

#Verifica se o diretorio log existe ou nao
if [ ! -d log ]
then
    mkdir log
fi


processos_memoria(){

    #Listar os processos com maior quantidade de memória alocada. 
    #Pegando os 10 primeiros e que so tenha numeros 
    processos=$(ps -e -o pid --sort -size | head -n 11 | grep [0-9])

    for pid in processos
    do
        # Pegar o nome do processo
        nome_processo=$(ps -p $pid -o comm=)

        #Salva no arquivo e não sobrepoe as informações
        echo -n $(date +%F,%H:%M:%S,) >> log/$nome_processo.log

        #Pega o tamanho do processo
        tamanho_processo=$(ps -p $pid -o size | grep [0-9])

        # Operação de divisão com a ferramenta bc que vai realizar a divisão entre os valores e passaremos os parâmetros da divisão, através de >>>:
        echo "$(bc <<< "scale=2,$tamanho_processo/1024 ") MB"  >> log/$nome_processo.log


    done
}

processos_memoria

if [ $? -eq 0 ]
then
    echo "Os arquivos foram salvos com sucesso"
else
    echo "Houve um problema na hora de salvar os arquivos"
fi