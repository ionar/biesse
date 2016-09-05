#!/usr/bin/env ruby
require 'tk'

# Cria janela
root = TkRoot.new { 
	title "Imobal"
	minsize(400,50)
	maxsize(400,50)
	geometry '400x50+300+40'
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
		puts selected_directory
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
				nome = File.basename(filename)
				arquivo_csv = File.open(selected_directory + '/' + nome + '.BIESSE.csv', 'w')
				conteudo = file.read
				arquivo_csv.print conteudo
				arquivo_csv.close

				puts 'NOME: ' + filename
				puts conteudo
			end
		end
		Tk::messageBox :message => "#{arquivos.to_a.length} arquivos processados"
	}
)

# Executa o loop
Tk.mainloop