require_relative './src/colaborativo'

class Main
  colab = Colaborativo.new

  # inicialização dos usuários e filmes com rating inicial = 0
  # para facilitar a manipulação dos dados, o primeiro usuário (índice 0) será nil
  # o primeiro filme (índice 0) de cada usuário também será nil
  usuarios = []
  for i in 1..943
    usuarios[i] = []
    for j in 1..1682
      usuarios[i][j] = 0
    end
  end

  # lendo dados do arquivo u1.base e associando o rating de cada filme a cada usuário
  arquivo = File.open("./dados/u1.base", "r")
  arquivo.each_line do |linha|
    linha = linha.split("\t")
    usuarios[linha[0].to_i][linha[1].to_i] = linha[2].to_i
  end

  vizinhos = colab.similaridadeCossenos(usuarios)

  while wait = gets
    p usuarios[wait.to_i]
  end
end