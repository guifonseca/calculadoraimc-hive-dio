enum ClassificacaoIMCEnum {
  magrezaGrave(classificacao: "Magreza grave", sigla: "MG"),
  magrezaModerada(classificacao: "Magreza moderada", sigla: "MM"),
  magrezaLeve(classificacao: "Magreza leve", sigla: "ML"),
  saudavel(classificacao: "Saudável", sigla: "S"),
  sobrepeso(classificacao: "Sobrepeso", sigla: "SP"),
  obesidadeGrau1(classificacao: "Obesidade grau 1", sigla: "O1"),
  obesidadeGrau2(classificacao: "Obesidade grau 2 (Severa)", sigla: "O2"),
  obesidadeGrau3(classificacao: "Obesidade grau 3 (Mórbida)", sigla: "O3");

  const ClassificacaoIMCEnum(
      {required this.classificacao, required this.sigla});

  final String classificacao;
  final String sigla;

  static ClassificacaoIMCEnum? getBySigla(String sigla) {
    for (var element in ClassificacaoIMCEnum.values) {
      if (element.sigla == sigla) {
        return element;
      }
    }
    return null;
  }
}
