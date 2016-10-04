#!/usr/bin/env ruby
#
# Ionar Rafael Michielin - irm@ionar.com.br
# Conversor BIESSE XML > CUTPLANNING
#
# Ordem dos itens para arquivo CSV a ser transferido para o Cutplanning
# ref; largura; comprimento; quantidade
#
require 'tk'
require 'nokogiri'
require 'colorize'

# Cria janela
root = TkRoot.new { 
	title "Biesse -> Cutplanning"
	minsize(300,50)
	maxsize(300,50)
	geometry '300x50+300+40'
	resizable = false, false
}

# Criando os botoes
btn_salvar = TkButton.new(root) {
	state 'active'
	text "Pasta destino..."
	pack("side" => "left",  "padx"=> "5", "pady"=> "5")
}

btn_abrir = TkButton.new(root){
	state 'disabled'
	text 'Arquivos a processar...'
	pack("side" => "left",  "padx"=> "5", "pady"=> "5")
}

# Botao escolher diretorio - comando
def chooseDirectory
	return Tk::chooseDirectory
end
selected_directory = TkVariable.new()
btn_salvar.command(
	Proc.new{
		selected_directory = chooseDirectory
		##puts selected_directory
		if selected_directory != ''
			btn_abrir.state = 'normal'
		end
	}
)

# Botao abrir arquivos
def openFiles
	return Tk.getOpenFile(  'title' => 'Selecione os arquivos',
                        'multiple' => true)
end
arquivos = TkVariable.new()
btn_abrir.command(
	proc{
		arquivos.value = openFiles;
		arquivos.to_a.each do |filename|
			#puts filename
			File.open(filename) do |file|
				nome = File.basename(filename, ".xml")
				arquivo_csv = File.open(selected_directory + '/' + nome + '.txt', 'w')
				conteudo = file.read
				conteudo_xml = Nokogiri::XML(conteudo)
				conteudo_xml.xpath("//Part").each_with_index do |part, index|
				  totalizador = index + 1
				  puts ('PEÇA: ' + totalizador.to_s + ' | Referencia: ' + part['Material'] + ' | Comprimento: ' + part['L'].to_s + '  | Largura: ' + part['W'].to_s + '  | Quantidade: ' + part['qMin'].to_s ).colorize(:color => :white, :background => :red) 
				  arquivo_csv.print part['Material']+ ';' + part['L'] + ';' + part['W'] + ';' + part['qMin']
				  arquivo_csv.print "\n"
				end

				##arquivo_csv.print conteudo
				arquivo_csv.close

				##puts 'NOME: ' + filename
				##puts conteudo
			end
		end
		Tk::messageBox :message => "#{arquivos.to_a.length} arquivos processados"
	}
)

# Executa o loop
Tk.mainloop



=begin
#--------------------------------------------
#Abre arquivo
arquivo = File.open("103-16-008015-TR_W_lbl.xml")

arquivo_csv = File.open('Export-para-cut-planning.txt', 'w')

#Guarda conteudo
conteudo = arquivo.read

#Manda p nokogiri
conteudo_xml = Nokogiri::XML(conteudo)

conteudo_xml.xpath("//Part").each_with_index do |part, index|
  totalizador = index + 1
  puts ('PEÇA: ' + totalizador.to_s + ' | Referencia: ' + part['Material'] + ' | Comprimento: ' + part['L'].to_s + '  | Largura: ' + part['W'].to_s).colorize(:color => :white, :background => :red) 
end

# Fechando os arquivos
arquivo.close
arquivo_csv.close
#-----------------------------------
=end