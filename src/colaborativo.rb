class Colaborativo
  # construtor vazio
  def initialize()
  end

  # método que calcula a similaridade usando a medida dos cossenos
  def similaridadeCossenos(usuarios)
    vizinhos = []
    for i in 0...usuarios.length
      vizinhos[i] = []
      for j in 0...usuarios[0].length
        produto = produtoVetor(usuarios[i], usuarios[j])
        normaA = normaVetor(usuarios[i])
        normaB = normaVetor(usuarios[j])
        medidaCosseno = produto / normaA * normaB
        # se a medida for maior ou igual a 90%, guardará o ID do vizinho similar
        if medidaCosseno >= 0.9
          vizinhos[i].push(j)
        end
      end
    end
    return vizinhos
  end

  # método que calcula a média dos erros
  def rootMeanSquareError()
  end

  # método que calcula o produto entre dois vetores
  def produtoVetor(vetorA, vetorB)
    somatorio = 0.0
    for i in 0...vetorA.length
      somatorio += vetorA[i] * vetorB[i]
    end
    return somatorio
  end

  # método que calcula a norma de um vetor
  def normaVetor(vetor)
    somatorio = 0.0
    for i in 0...vetor.length
      somatorio += vetor[i] ** 2
    end
    somatorio = Math.sqrt(somatorio)
    return somatorio
  end
end
