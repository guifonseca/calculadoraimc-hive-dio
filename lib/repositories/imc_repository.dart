import 'package:calculadoraimcdio/model/imc_model.dart';

class ImcRepository {
  final List<ImcModel> _imcs = [];

  Future<void> adicionar(ImcModel imc) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.add(imc);
  }

  Future<List<ImcModel>> listarImcs() async {
    await Future.delayed(const Duration(seconds: 2));
    return _imcs;
  }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _imcs.remove(_imcs.where((element) => element.id == id).first);
  }
}
