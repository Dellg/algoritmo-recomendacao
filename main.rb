require_relative './src/colaborativo'

class Main
  colab = Colaborativo.new

  # inicialização dos usuários e filmes com rating inicial = 0
  puts "Criando usuários..."
  usuarios = []
  for i in 1..943
    usuarios[i] = []
    for j in 1..1682
      usuarios[i][j] = 0
    end
  end

  # lendo dados do arquivo u1.base e associando o rating de cada filme a cada usuário
  puts "Lendo arquivo dos ratings e associando a cada usuário..."
  arquivo = File.open("./dados/u1.base", "r")
  arquivo.each_line do |linha|
    linha = linha.split("\t")
    usuarios[linha[0].to_i][linha[1].to_i] = linha[2].to_i
  end

  puts "Calculando os 10 vizinhos mais próximos de cada usuário..."
  vizinhos = colab.similaridadeCossenos(usuarios)

  puts "Calculando os ratings previstos para cada usuário com base nos ratings dos vizinhos..."
  previsao = colab.calcularPrevisao(usuarios, vizinhos)

  puts "Digite um índice para ver as informações sobre um usuário:"
  while wait = gets
    p usuarios[wait.to_i]
    p vizinhos[wait.to_i]
    p previsao[wait.to_i]
  end
end
