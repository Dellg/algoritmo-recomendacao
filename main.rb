require_relative './src/colaborativo'

class Main
  colab = Colaborativo.new

  # inicialização dos usuários e filmes com rating inicial = 0
  puts "\nCriando usuários...\n\n"
  usuarios = []
  dados = []
  for i in 1..943
    usuarios[i] = []
    dados[i] = {}
    for j in 1..1682
      usuarios[i][j] = 0
    end
  end

  for iteracao in 1..5
    puts "\tIteração #{iteracao}:"

    # lendo dados do arquivo base e associando o rating de cada filme a cada usuário
    puts "Lendo arquivo u#{iteracao}.base com os ratings e associando a cada usuário..."
    arquivo = File.open("./dados/u#{iteracao}.base", "r")
    arquivo.each_line do |linha|
      linha = linha.split("\t")
      usuarios[linha[0].to_i][linha[1].to_i] = linha[2].to_i
    end

    puts "Calculando os 10 vizinhos mais próximos de cada usuário..."
    vizinhos = colab.similaridadeCossenos(usuarios)

    puts "Calculando os ratings previstos para cada usuário com base nos ratings dos vizinhos..."
    previsao = colab.calcularPrevisao(usuarios, vizinhos)

    # lendo dados do arquivo de teste para ser possível comparar com os dados base
    puts "Lendo arquivo u#{iteracao}.test com os ratings de teste para comparar..."
    arquivo2 = File.open("./dados/u#{iteracao}.test", "r")
    arquivo2.each_line do |linha|
      linha = linha.split("\t")
      dados[linha[0].to_i][linha[1].to_i] = linha[2].to_i
    end

    # comparando dados base com teste
    puts "Comparando dados base com dados teste..."
    rmse = colab.rootMeanSquareError(previsao, dados)
    puts "Root Mean Square Error = #{rmse}\n\tFinalizando Iteração #{iteracao}\n\n"
  end
  puts "Digite algo para finalizar..."
  gets
end
