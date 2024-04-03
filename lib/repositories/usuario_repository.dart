import 'package:calculadoraimcdio/model/usuario_model.dart';
import 'package:hive/hive.dart';

class UsuarioRepository {
  static late Box _box;

  UsuarioRepository._criar();

  static Future<UsuarioRepository> carregar() async {
    if (Hive.isBoxOpen('usuarioModel')) {
      _box = Hive.box('usuarioModel');
    } else {
      _box = await Hive.openBox('usuarioModel');
    }
    return UsuarioRepository._criar();
  }

  void salvar(UsuarioModel usuarioModel) {
    _box.put(1, usuarioModel);
  }

  UsuarioModel? obterUsuario() {
    return _box.get(1);
  }

  void remove(UsuarioModel usuarioModel) {
    usuarioModel.delete();
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
