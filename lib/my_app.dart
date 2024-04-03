import 'package:calculadoraimcdio/model/usuario_model.dart';
import 'package:calculadoraimcdio/pages/main_page.dart';
import 'package:calculadoraimcdio/pages/usuario_page.dart';
import 'package:calculadoraimcdio/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late UsuarioRepository _usuarioRepository;
  late UsuarioModel? _usuarioModel;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    _usuarioRepository = await UsuarioRepository.carregar();
    _usuarioModel = _usuarioRepository.obterUsuario();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue,
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: GoogleFonts.roboto(fontSize: 18)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.blue, foregroundColor: Colors.white),
        textTheme: GoogleFonts.robotoTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _usuarioModel == null
              ? const UsuarioPage(
                  isInicio: true,
                )
              : const MainPage(),
    );
  }
}
