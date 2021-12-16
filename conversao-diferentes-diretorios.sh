#!/bin/bash

converte_imagem(){
	# Recebe o parametro 1 na variavel caminho_imagem
	local caminho_imagem=$1
	
	# A variavel imagem_sem_extensao recebe o caminho completo do arquivo sem a extensao
	local imagem_sem_extensao=$(ls $caminho_imagem | awk -F. '{ print $1 }')

	echo "Convertendo o arquivo: ${imagem_sem_extensao}.jpg para ${imagem_sem_extensao}.png"
	convert $imagem_sem_extensao.jpg $imagem_sem_extensao.png 

}

varrer_diretorio(){
	cd $1

	# itera entre todos os arquivos existentes no diretorio
	for arquivo in * 
	do
		# Passar o caminho completo do arquivo para que não percamos a referência de sua localização
		local caminho_arquivo=$(find ~/Documents/Cursos/ShellScripting/imagens-novos-livros -name $arquivo)
		
		# Verifica se o arquivo é um diretorio 
		if [ -d $caminho_arquivo ]
		then 
			#Entrar no diretorio e fazer varredura de conteudo
			varrer_diretorio $caminho_arquivo
			
		else 
			converte_imagem $caminho_arquivo
		fi
	done
}


echo "################################################################################################################################################################"
echo "Inicio do Processo"
echo "################################################################################################################################################################"

echo ""
# Chamada da funcao varrer_diretorio
varrer_diretorio ~/Documents/Cursos/ShellScripting/imagens-novos-livros

# Caso ocorra sucesso o scritp retorna 0
if [ $? -eq 0 ] 
then
    echo "Conversão realizada com sucesso"
else
    echo "Houve uma falha no processo"
fi
