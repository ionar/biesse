#!/usr/bin/env ruby
require 'tk'
require 'nokogiri'
require 'colorize'

# Cria janela
root = TkRoot.new { 
	title "Imobal"
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
				nome = File.basename(filename)
				arquivo_csv = File.open(selected_directory + '/' + nome + '.BIESSE.csv', 'w')
				conteudo = file.read
				conteudo_xml = Nokogiri::XML(conteudo)
				conteudo_xml.xpath("//com.geeksystem.cutplanning.cutplan.material.program[@iswaste='false'][@quantity!='0'][@lenght>'2746.0'][@width>'1839.0']").each_with_index do |program, index|
				  totalizador = index + 1
				  puts ('CHAPA NOVA: ' + totalizador.to_s + '  | Comprimento: ' + program['lenght'].to_s + '  | Largura: ' + program['width'].to_s).colorize(:color => :white, :background => :red) 

				  program.children.each do |cut|
						cut.xpath("com.geeksystem.cutplanning.cutplan.material.program.cut.data[@template='4']").each do |data|
							puts "CORTE".colorize(:color => :white, :background => :green) 
								#1
								data.xpath("com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='34']").each do |field|
									puts field			
									arquivo_csv.print field['value'] + ';'
								end
								#2
								data.xpath("com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='42']").each do |field|
									puts field			
									arquivo_csv.print field['value'] + ';'
								end
								#3
								data.xpath("com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='39']").each do |field|
									puts field			
									arquivo_csv.print field['value'] + ';'
								end
								#4
								data.xpath("com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='35']").each do |field|
									puts field			
									arquivo_csv.print field['value'] + ';'
								end
								#5
								data.xpath("com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='36']").each do |field|
									puts field			
									arquivo_csv.print field['value'] + ';'
								end
								#6
								data.xpath("com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='37']").each do |field|
									puts field			
									arquivo_csv.print field['value'] + ';'
								end
								#7
								data.xpath("com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='38']").each do |field|
									puts field			
									arquivo_csv.print field['value'] + ';'
								end
								#8
								data.xpath("com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='48']").each do |field|
									puts field			
									arquivo_csv.print field['value'] + ';'
								end
								#9
								data.xpath("com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='40']").each do |field|
									puts field			
									arquivo_csv.print field['value'] + ';'
								end
								#10
								data.xpath("com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='43']").each do |field|
									puts field			
									arquivo_csv.print field['value']
								end

							arquivo_csv.print "\n"
						end
				  end
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