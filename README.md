Intrudução ao DOSIMPRIME:							   
   ==============================================================
                                                                  
   Este sistema tem o intuito de permitir impressões, através dos drivers de impressoras que estiverem instalas no Windows, solicitadas por programas desenvolvidos em 16Bits, para ambiênte de Prompt de Comando, que não consiga acesso aos recursos da API do Windows. O programa deverá gravar um arquivo, em formato de texto não formatado com o texto que desejar imprimir, para cada impressão solicitada.

   Iniciado em: 02/04/2007
   Por: Luiz Carlos Costa Rodrigues
   Linguagem de programação: Object Pascal
   IDE: DELPHI 4
   Atualizado com IDE DELPHI XE
   Local: Caxias do Sul / RS
   Contato: luiz@dataprol.com.br
            Skype DATAPROL
            +55 51 993-988-725
            www.dataprol.com.br


   Instruções:
   ==============================================================
 
   Grave arquivos contendo os textos desejados com comandos de impressão do protocolo ESC/P(da EPSON), pois, ainda, aceita poucos comandos PCL(HP) e só foi testado baseando-se nos comandos da ESC/P, até o momento.
   Os arquivos devem ser gravados na pasta em que estiver indicado no programa, como padrão ou, então, numa pasta personalizada. Sendo que deverá informar o caminho da pasta personalizada, no Dosimprime, para que a solicitação de impressão seja encaminha.
   A primeira linha do arquivo que gravar, para a impressão, deverá conter o seguinte:
 

   NNX
   | |
   |  -> 1 byte informando o número representante dos padrões de impressão
   |     1(ESC/P) ou 2(PCL).
    -> 2 bytes informando o número do tamanho inicial padrão dos caracteres.


   Exemplo:
   -------
   061
   Tamanho de caracteres = 06
   Padrão de impressão = 1 - ESC/P


   Na subpasta Demo, da pasta do Dosimprime, há um arquivo de exemplo de impressão o qual você poderá utilizar como teste e referência.
   O nome do arquivo é EXEMPLO.PRN, ele foi gravado contendo comandos da impressora ESC/P.
