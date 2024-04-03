import 'package:calculadoraimcdio/model/imc_model.dart';
import 'package:hive/hive.dart';

class ImcRepository {
  static late Box _box;

  ImcRepository._criar();

  static Future<ImcRepository> carregar() async {
    if (Hive.isBoxOpen('imcModel')) {
      _box = Hive.box('imcModel');
    } else {
      _box = await Hive.openBox('imcModel');
    }
    return ImcRepository._criar();
  }

  void adicionar(ImcModel imc) {
    _box.add(imc);
  }

  List<ImcModel> listarImcs() {
    return _box.values.cast<ImcModel>().toList();
  }

  void remove(ImcModel imc) {
    imc.delete();
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
