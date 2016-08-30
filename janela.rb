#!/usr/bin/env ruby
require 'tk'

# Cria janela
root = TkRoot.new { 
	title "Imobal"
	minsize(500,500)
	geometry '500x500'
}

# Botao abrir arquivos
def openFiles
	return Tk.getOpenFile(  'title' => 'Selecione os arquivos',
                        'multiple' => true)
end

arquivos = TkVariable.new()
arquivo_csv = TkVariable.new()

btn_abrir = TkButton.new(root){
	text 'Importar arquivos'
	command (proc {
		arquivos.value = openFiles;
		arquivos.to_a.each do |filename|
			puts filename + " ionar"
			File.open(filename) do |file|
				conteudo = file.read
				puts conteudo
				arquivo_csv.print conteudo
			end
		end
		})
	pack("side" => "left",  "padx"=> "5", "pady"=> "5")
}



btn_salvar = TkButton.new(root) {
	text "Selecionar diretorio"
	command Proc.new {
		Tk::chooseDirectory
	}
	pack("side" => "left",  "padx"=> "5", "pady"=> "5")
}

# Executa o loop
Tk.mainloop