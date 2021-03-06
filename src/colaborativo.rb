class Colaborativo
  # construtor vazio
  def initialize()
  end

  # método que calcula a similaridade usando a medida dos cossenos
  def similaridadeCossenos(usuarios)
    vizinhos = []
    for i in 1...usuarios.length
      vizinhos[i] = []
      for j in 1...usuarios.length
        if i != j
          produto = produtoVetor(usuarios[i], usuarios[j])
          normaA = normaVetor(usuarios[i])
          normaB = normaVetor(usuarios[j])
          if normaA > 0 and normaB > 0
            medidaCosseno = produto / (normaA * normaB)
            # se tem menos de 10 vizinhos adiciona direto, caso contrário, substitui o último se a medida for maior
            if vizinhos[i].length < 10
              valores = [j, medidaCosseno]
              vizinhos[i].push(valores)
            else
              vizinhos[i] = vizinhos[i].sort_by { |v| v[1] }
              if medidaCosseno > vizinhos[i][0][1]
                valores = [j, medidaCosseno]
                vizinhos[i][0] = valores
              end
            end
          end
        end
      end
    end
    return vizinhos
  end

  # método que calcula a média dos erros
  def rootMeanSquareError(previsao, dados)
    somatorio = 0.0
    contador = 0
    for i in 1...dados.length
      if dados[i] != nil
        for j in 1...dados[i].length
          if dados[i][j] != nil and previsao[i][j] != nil
            somatorio += (dados[i][j] - previsao[i][j]) ** 2
            contador += 1
          end
        end
      end
    end
    rmse = (1.0/contador) * somatorio
    rmse = Math.sqrt(rmse)
    return rmse
  end

  # método que calcula o produto entre dois vetores
  def produtoVetor(vetorA, vetorB)
    somatorio = 0.0
    for i in 1...vetorA.length
      somatorio += vetorA[i] * vetorB[i]
    end
    return somatorio
  end

  # método que calcula a norma de um vetor
  def normaVetor(vetor)
    somatorio = 0.0
    for i in 1...vetor.length
      somatorio += vetor[i] ** 2
    end
    somatorio = Math.sqrt(somatorio)
    return somatorio
  end

  # calcular previsão dos ratings
  def calcularPrevisao(usuarios, vizinhos)
    previsao = []
    for i in 1...usuarios.length
      previsao[i] = []
      for j in 1...usuarios[i].length
        if usuarios[i][j] == 0
          previsao[i][j] = calcularMediaRating(usuarios, vizinhos[i], j)
        end
      end
    end
    return previsao
  end

  # calcular média dos ratings dos vizinhos
  def calcularMediaRating(usuarios, vizinhos, idFilme)
    somatorio = 0.0
    contador = 0
    for i in 0...vizinhos.length
      nota = usuarios[vizinhos[i][0]][idFilme]
      if nota > 0
        somatorio += nota
        contador += 1
      end
    end
    if contador == 0
      return 0
    else
      media = somatorio / contador
      return media
    end
  end
end
