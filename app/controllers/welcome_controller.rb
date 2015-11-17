class WelcomeController < ApplicationController

  ACAOA = {mes1: 0.09091, mes2: 0.07197, mes3: 0.09661, mes4: 0.04516, mes5: 0.05864,
    mes6: -0.00192, mes7: 0.11404, mes8: 0.06388, mes9: -0.05679, mes10: -0.03141, mes11: 0.05676, mes12: -0.08493}
  ACAOB = {mes1: 0.06793, mes2: 0.13972, mes3: -0.03546, mes4: -0.03109, mes5: 0.00760,
    mes6: -0.03879, mes7: 0.08453, mes8: -0.01656, mes9: -0.04000, mes10: 0.04320, mes11: -0.11790, mes12: 0.19367}
  ACAOC = {mes1: 0.00001, mes2: 0.00706, mes3: 0.07748, mes4: -0.01706, mes5: -0.06275,
    mes6: -0.00108, mes7: 0.03741, mes8: 0.00971, mes9: -0.03813, mes10: 0.09798, mes11: -0.04462, mes12: -0.02473}
  ACAOD = {mes1: 0.00007, mes2: 0.01756, mes3: 0.06318, mes4: -0.03906, mes5: 0.05511,
    mes6: -0.02143, mes7: -0.00141, mes8: -0.00782, mes9: -0.05137, mes10: 0.05783, mes11: 0.00111, mes12: -0.01565}
  ACAOE = {mes1: 0.00097, mes2: 0.01719, mes3: -0.04575, mes4: -0.01996, mes5: 0.03475,
    mes6: 0.00171, mes7: -0.00941, mes8: 0.00002, mes9: 0.00001, mes10: -0.01745, mes11: -0.00099, mes12: 0.02160}
  ACAOF = {mes1: 0.00091, mes2: 0.01362, mes3: 0.09048, mes4: 0.01006, mes5: -0.04350,
    mes6: -0.00023, mes7: 0.02541, mes8: -0.00879, mes9: -0.02313, mes10: 0.03133, mes11: 0.00112, mes12: -0.00113}
  ACAOG = {mes1: 0.00151, mes2: 0.05332, mes3: 0.05548, mes4: 0.00996, mes5: -0.04511,
    mes6: 0.00196, mes7: 0.03561, mes8: 0.06969, mes9: -0.01993, mes10: 0.00790, mes11: -0.07002, mes12: 0.02002}
  ACAOH = {mes1: -0.00011, mes2: -0.00011, mes3: 0.07655, mes4: -0.02306, mes5: -0.03350,
    mes6: -0.08787, mes7: 0.03871, mes8: 0.00697, mes9: 0.04545, mes10: 0.09798, mes11: -0.04462, mes12: -0.02473}
  ACAOI = {mes1: 0.00579, mes2: 0.01336, mes3: -0.04575, mes4: 0.00996, mes5: 0.01169,
    mes6: 0.00199, mes7: -0.03001, mes8: -0.00699, mes9: 0.00709, mes10: 0.09798, mes11: -0.04462, mes12: -0.02473}
  ACAOJ = {mes1: -0.00045, mes2: 0.07992, mes3: 0.09900, mes4: 0.00696, mes5: 0.00697,
    mes6: -0.00978, mes7: 0.03891, mes8: 0.00579, mes9: -0.03813, mes10: 0.09798, mes11: -0.04462, mes12: -0.02473}

  INVESTIMENTOSINICIAIS = [0.3, 0.25, 0.2, 0.15, 0.1, 0, 0, 0, 0, 0]

  def index
    inicial = INVESTIMENTOSINICIAIS.clone
    dadoInicial = {inicial: inicial, total: calculaInvestimentoAnual(inicial)}

    dadosVizinhos = []
    vizinhos = criaVizinhos(inicial)

    vizinhos.each do |vizinho|
      vizinho = {vizinho: vizinho, total: calculaInvestimentoAnual(vizinho)}
      dadosVizinhos << vizinho
    end

    @dadosView = {dadoInicial: dadoInicial, dadosVizinhos: dadosVizinhos, melhorVizinho: []}
  end

  def random
    inicial = INVESTIMENTOSINICIAIS.shuffle
    dadoInicial = {inicial: inicial, total: calculaInvestimentoAnual(inicial)}

    dadosVizinhos = []
    vizinhos = criaVizinhos(inicial)

    vizinhos.each do |vizinho|
      vizinho = {vizinho: vizinho, total: calculaInvestimentoAnual(vizinho)}
      dadosVizinhos << vizinho
    end

    @dadosView = {dadoInicial: dadoInicial, dadosVizinhos: dadosVizinhos, melhorVizinho: []}
  end

  private

  def criaVizinhos(investimentos)
    vizinhos = []
    (0..8).each do |i|
      ((i+1)..9).each do |j|
        if investimentos[i] != 0 || investimentos[j] != 0
          vizinhos << adicionaAosVizinhos(i, j, investimentos)
        end
      end
    end

    return vizinhos
  end

  def adicionaAosVizinhos(i, j, investimentos)
    vizinho = investimentos.clone

    valorI = investimentos[i]
    valorJ = investimentos[j]

    vizinho[i] = valorJ
    vizinho[j] = valorI

    return vizinho
  end

  def calculaInvestimentoAnual(investimentos)
    total = 0
    mes = 1

    12.times do
      total += calculaTotalMensal(:"mes#{mes}", investimentos)
      mes += 1
    end

    return total
  end

  def calculaTotalMensal(mes, investimentos)
    total = 0
    total += ACAOA[mes] * investimentos[0]
    total += ACAOB[mes] * investimentos[1]
    total += ACAOC[mes] * investimentos[2]
    total += ACAOD[mes] * investimentos[3]
    total += ACAOE[mes] * investimentos[4]
    total += ACAOF[mes] * investimentos[5]
    total += ACAOG[mes] * investimentos[6]
    total += ACAOH[mes] * investimentos[7]
    total += ACAOI[mes] * investimentos[8]
    total += ACAOJ[mes] * investimentos[9]

    return total
  end

end
