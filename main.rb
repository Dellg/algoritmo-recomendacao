require_relative './src/colaborativo'

class Main
  colab = Colaborativo.new

  for iteracao in 1..5
    # criando a matriz de usuários e filmes e inicializando todos os ratings com 0
    puts "Criando usuários e inicializando ratings com 0..."
    usuarios = []
    dados = []
    for i in 1..943
      usuarios[i] = []
      dados[i] = []
      for j in 1..1682
        usuarios[i][j] = 0
      end
    end

    # lendo o arquivo de dados e associando os ratings dos filmes aos respectivos usuários
    puts "Lendo arquivo u#{iteracao}.base com os ratings e associando a cada usuário..."
    arquivo = File.open("./dados/u#{iteracao}.base", "r")
    arquivo.each_line do |linha|
      linha = linha.split("\t")
      idUsuario = linha[0].to_i
      idFilme = linha[1].to_i
      ratingFilme = linha[2].to_i
      usuarios[idUsuario][idFilme] = ratingFilme
    end

    # chamando o método para calcular os 10 vizinhos mais próximos com base na medida dos cossenos
    puts "Calculando os 10 vizinhos mais próximos..."
    vizinhos = colab.similaridadeCossenos(usuarios)

    # chamando o método para calcular a previsão dos ratings com base na média dos ratings dos vizinhos
    puts "Calculando os ratings previstos para cada usuário com base nos ratings dos vizinhos..."
    previsao = colab.calcularPrevisao(usuarios, vizinhos)

    # lendo o arquivo de teste para ser feita a comparação dos dados previstos com os dados reais
    puts "Lendo arquivo u#{iteracao}.test com os ratings de teste para comparar..."
    arquivo2 = File.open("./dados/u#{iteracao}.test", "r")
    arquivo2.each_line do |linha|
      linha = linha.split("\t")
      idUsuario = linha[0].to_i
      idFilme = linha[1].to_i
      ratingFilme = linha[2].to_i
      dados[idUsuario][idFilme] = ratingFilme
    end

    # chamando o método para calcular o RMSQ com base nos dados previstos e nos dados reais
    puts "Comparando dados base com dados teste..."
    rmse = colab.rootMeanSquareError(previsao, dados)
    puts "Root Mean Square Error = #{rmse}\n\n"
  end
end
