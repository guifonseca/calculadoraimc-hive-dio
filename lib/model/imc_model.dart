import 'package:calculadoraimcdio/model/enums.dart';
import 'package:flutter/material.dart';

class ImcModel {
  final String _id = UniqueKey().toString();
  String _nome;
  double _peso;
  double _altura;
  double _imc;
  ClassificacaoIMCEnum _classificacaoIMC;
  DateTime horario = DateTime.now();

  ImcModel(
      this._nome, this._peso, this._altura, this._imc, this._classificacaoIMC);

  String get id => _id;

  String get nome => _nome;
  set nome(String nome) => _nome = nome;

  double get peso => _peso;
  set peso(double peso) => _peso = peso;

  double get altura => _altura;
  set altura(double altura) => _altura = altura;

  double get imc => _imc;
  set imc(double imc) => _imc = imc;

  ClassificacaoIMCEnum get classificacaoIMC => _classificacaoIMC;
  set classificacaoIMC(ClassificacaoIMCEnum imc) =>
      _classificacaoIMC = classificacaoIMC;
}
