Estou organizando minhas fotos e criando álbuns no picasa para compartilhar com minha família, só que muitas fotos estão com as datas erradas por que a câmera estava configurado com a data errada na hora que a foto foi tirada.

Para corrigir as datas das fotos criei esse Shell Script que funciona tanto no OS X quando no Linux.

Ele tem como dependência o exiftool que por padrão não vem instalado nem no OS X quando no Linux. No OS X instalei usando o brew e no Linux o apt-get.

Para executar o script basta mudar a permissão do arquivo e executa-lo passando como parâmetro a data, hora e a pasta com as fotos::

	$ chmod 755 dataFotos.sh
	$ ./dataFotos.sh 25/10/2014 08:00:00 /caminho/das/fotos

Dúvidas e Sugestões favor mandar um e-mail falecom@guilhermejr.net