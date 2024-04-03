import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'imc_model.g.dart';

@HiveType(typeId: 1)
class ImcModel extends HiveObject {
  @HiveField(0)
  final String _id = UniqueKey().toString();

  @HiveField(1)
  double _peso = 0.0;

  @HiveField(2)
  double _altura = 0.0;

  @HiveField(3)
  double _imc = 0.0;

  @HiveField(4)
  String _classificacaoIMC = "";

  @HiveField(5)
  String horario = "";

  ImcModel();

  ImcModel.criar(this._peso, this._altura, this._imc, this._classificacaoIMC,
      this.horario);

  String get id => _id;

  double get peso => _peso;
  set peso(double peso) => _peso = peso;

  double get altura => _altura;
  set altura(double value) => _altura = value;

  double get imc => _imc;
  set imc(double imc) => _imc = imc;

  String get classificacaoIMC => _classificacaoIMC;
  set classificacaoIMC(String imc) => _classificacaoIMC = classificacaoIMC;
}
