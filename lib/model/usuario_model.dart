import 'package:hive/hive.dart';

part 'usuario_model.g.dart';

@HiveType(typeId: 0)
class UsuarioModel extends HiveObject {
  @HiveField(0)
  String? _nome;

  @HiveField(1)
  double? _altura;

  UsuarioModel();

  UsuarioModel.criar(this._nome, this._altura);

  String? get nome => _nome;
  set nome(String? value) => _nome = value;

  double? get altura => _altura;
  set altura(double? value) => _altura = value;
}
