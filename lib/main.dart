import 'package:calculadoraimcdio/model/imc_model.dart';
import 'package:calculadoraimcdio/model/usuario_model.dart';
import 'package:calculadoraimcdio/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(ImcModelAdapter());
  Hive.registerAdapter(UsuarioModelAdapter());
  runApp(const MyApp());
}
