import 'package:calculadoraimcdio/shared/widgets/cadastro_usuario_form.dart';
import 'package:flutter/material.dart';

class UsuarioPage extends StatefulWidget {
  final bool isInicio;
  const UsuarioPage({super.key, required this.isInicio});

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMC App"),
      ),
      body: CadastroUsuarioForm(isInicio: widget.isInicio),
    );
  }
}
