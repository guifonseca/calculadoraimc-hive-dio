import 'package:calculadoraimcdio/model/usuario_model.dart';
import 'package:calculadoraimcdio/my_app.dart';
import 'package:calculadoraimcdio/pages/main_page.dart';
import 'package:calculadoraimcdio/repositories/imc_repository.dart';
import 'package:calculadoraimcdio/repositories/usuario_repository.dart';
import 'package:flutter/material.dart';

class CadastroUsuarioForm extends StatefulWidget {
  final bool isInicio;

  const CadastroUsuarioForm({super.key, required this.isInicio});

  @override
  State<CadastroUsuarioForm> createState() => _CadastroUsuarioFormState();
}

class _CadastroUsuarioFormState extends State<CadastroUsuarioForm> {
  late ImcRepository _imcRepository;
  late UsuarioRepository _usuarioRepository;
  var _usuarioModel = UsuarioModel();

  final _nomeController = TextEditingController(text: "");
  final _alturaController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _carregarUsuario();
  }

  void _carregarUsuario() async {
    _imcRepository = await ImcRepository.carregar();
    _usuarioRepository = await UsuarioRepository.carregar();
    _usuarioModel = _usuarioRepository.obterUsuario() ?? UsuarioModel();
    _nomeController.text = _usuarioModel.nome ?? "";
    _alturaController.text = (_usuarioModel.altura ?? "").toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 60,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              if (widget.isInicio)
                const Text(
                  "Informe seus dados para iniciar",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                  decoration: const InputDecoration(label: Text("Nome")),
                  controller: _nomeController,
                  enabled: widget.isInicio,
                  validator: (value) {
                    if ((value ?? "").length < 3) {
                      return "Informe um nome válido";
                    }
                    return null;
                  }),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(label: Text("Altura")),
                controller: _alturaController,
                validator: (value) {
                  double? altura = double.tryParse(value ?? "");
                  if ((altura ?? 0.0) == 0.0) {
                    return "Informe uma altura válida.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _usuarioRepository.salvar(UsuarioModel.criar(
                          _nomeController.text,
                          double.parse(_alturaController.text)));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ));
                    }
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(fontSize: 18),
                  )),
              const SizedBox(
                height: 15,
              ),
              if (!widget.isInicio)
                TextButton(
                    onPressed: () async {
                      await _usuarioRepository.clear();
                      await _imcRepository.clear();
                      Future.delayed(
                        const Duration(
                          microseconds: 100,
                        ),
                        () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyApp(),
                              ));
                        },
                      );
                    },
                    child: const Text("Sair"))
            ],
          ),
        ),
      ),
    );
  }
}
