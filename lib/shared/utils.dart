import 'dart:math';

import 'package:calculadoraimcdio/model/enums.dart';
import 'package:flutter/material.dart';

class Utils {
  static double calcularIMC(double peso, double altura) {
    return double.tryParse((peso / pow(altura, 2)).toStringAsFixed(2)) ?? 0.0;
  }

  static String calcularIMCFormatado(String peso, String altura) {
    double nuPeso = double.tryParse(peso.replaceAll(",", ".")) ?? 0.0;
    double nuAltura = double.tryParse(altura.replaceAll(",", ".")) ?? 0.0;

    double imc = calcularIMC(nuPeso, nuAltura);

    if (imc.isNaN || imc.isInfinite) {
      return "";
    }

    return imc.toString();
  }

  static ClassificacaoIMCEnum verificarClassificao(double imc) {
    if (imc < 16) {
      return ClassificacaoIMCEnum.magrezaGrave;
    }

    if (imc >= 16 && imc < 17) {
      return ClassificacaoIMCEnum.magrezaModerada;
    }

    if (imc >= 17 && imc < 18.5) {
      return ClassificacaoIMCEnum.magrezaLeve;
    }

    if (imc >= 18.5 && imc < 25) {
      return ClassificacaoIMCEnum.saudavel;
    }

    if (imc >= 25 && imc < 30) {
      return ClassificacaoIMCEnum.sobrepeso;
    }

    if (imc >= 30 && imc < 35) {
      return ClassificacaoIMCEnum.obesidadeGrau1;
    }

    if (imc >= 35 && imc < 40) {
      return ClassificacaoIMCEnum.obesidadeGrau2;
    }

    return ClassificacaoIMCEnum.obesidadeGrau3;
  }

  static Color? getIMCAvatarColor(ClassificacaoIMCEnum? classificacaoIMC) {
    switch (classificacaoIMC) {
      case ClassificacaoIMCEnum.saudavel:
        return Colors.green;
      case ClassificacaoIMCEnum.magrezaLeve:
      case ClassificacaoIMCEnum.sobrepeso:
        return Colors.amber;
      case ClassificacaoIMCEnum.magrezaModerada:
      case ClassificacaoIMCEnum.obesidadeGrau1:
        return Colors.orange;
      case ClassificacaoIMCEnum.magrezaGrave:
      case ClassificacaoIMCEnum.obesidadeGrau2:
        return Colors.red;
      case ClassificacaoIMCEnum.obesidadeGrau3:
        return Colors.black;
      default:
        return Colors.blue;
    }
  }
}
