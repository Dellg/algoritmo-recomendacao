require_relative './src/colaborativo'

class Main
  colab = Colaborativo.new

  # inicialização dos usuários e filmes com rating inicial = 0
  usuarios = []
  for i in 0...943
    usuarios[i] = []
    for j in 0...1682
      usuarios[i][j] = 0
    end
  end

  # lendo dados do arquivo u1.base e associando o rating de cada filme a cada usuário
  arquivo = File.open("./dados/u1.base", "r")
  arquivo.each_line do |linha|
    linha = linha.split("\t")
    usuarios[linha[0].to_i - 1][linha[1].to_i - 1] = linha[2].to_i
  end

  vizinhos = colab.similaridadeCossenos(usuarios)

  while wait = gets
    p usuarios[wait.to_i]
  end
end
