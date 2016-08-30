#!/usr/bin/env ruby
#
# Ionar Rafael Michielin - irm@ionar.com.br
# Conversor XML CUTPLANNING > BIESSE
#
# Ordem dos itens para arquivo CSV a ser transferido para Biesse
# num_pedido;ordem-de-compra;cliente;cod-item;descritivo-item;largura;compriment;quantidade;cod-barras;cod-biesse
#

require 'nokogiri'
#require 'active_support/core_ext/hash/conversions'
#require 'awesome_print'
require 'colorize'

#Abre arquivo
arquivo = File.open("TESTE CA.cutplanning")

arquivo_csv = File.open('Biesse-export.csv', 'w')

#Guarda conteudo
conteudo = arquivo.read

#Manda p nokogiri
conteudo_xml = Nokogiri::XML(conteudo)


conteudo_xml.xpath("//com.geeksystem.cutplanning.cutplan.material.program[@iswaste='false'][@quantity!='0'][@lenght>'2746.0'][@width>'1839.0']").each_with_index do |program, index|
  totalizador = index + 1
  puts ('CHAPA NOVA: ' + totalizador.to_s + '  | Comprimento: ' + program['lenght'].to_s + '  | Largura: ' + program['width'].to_s).colorize(:color => :white, :background => :red) 

  program.children.each do |cut|
		cut.xpath("com.geeksystem.cutplanning.cutplan.material.program.cut.data[@template='4']").each do |data|
			puts "CORTE".colorize(:color => :white, :background => :green) 
=begin
				data.xpath("
				com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='34']|
				com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='42']|
				com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='39']|
				com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='35']|
				com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='36']|
				com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='37']|
				com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='38']|
				com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='48']|
				com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='40']|
				com.geeksystem.cutplanning.cutplan.material.program.cut.data.field[@name='43']
			").each do |field|
=end	
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

# Fechando os arquivos
arquivo.close
arquivo_csv.close
