import 'package:calculadoraimcdio/model/enums.dart';
import 'package:calculadoraimcdio/model/imc_model.dart';
import 'package:calculadoraimcdio/model/usuario_model.dart';
import 'package:calculadoraimcdio/repositories/imc_repository.dart';
import 'package:calculadoraimcdio/repositories/usuario_repository.dart';
import 'package:calculadoraimcdio/shared/list_tile_field.dart';
import 'package:calculadoraimcdio/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListImcPage extends StatefulWidget {
  const ListImcPage({super.key});

  @override
  State<ListImcPage> createState() => _ListImcPageState();
}

class _ListImcPageState extends State<ListImcPage> {
  late UsuarioRepository _usuarioRepository;
  late ImcRepository _imcRepository;

  var _usuario = UsuarioModel();
  var _imcs = const <ImcModel>[];

  String _mensagem = "";

  TextEditingController pesoController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    obterListaImcs();
  }

  void obterListaImcs() async {
    _usuarioRepository = await UsuarioRepository.carregar();
    _imcRepository = await ImcRepository.carregar();
    _usuario = _usuarioRepository.obterUsuario() ?? UsuarioModel();
    _imcs = _imcRepository.listarImcs();
    setState(() {});
  }

  void salvar() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMC App"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: _imcs.length,
        itemBuilder: (context, index) {
          var imc = _imcs[index];
          return Dismissible(
              key: Key(imc.id),
              onDismissed: (direction) {
                _imcRepository.remove(imc);
                obterListaImcs();
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: ListTile(
                    isThreeLine: true,
                    leading: CircleAvatar(
                        backgroundColor: Utils.getIMCAvatarColor(
                            ClassificacaoIMCEnum.getBySigla(
                                imc.classificacaoIMC)),
                        child: Text(
                          imc.classificacaoIMC,
                          style: const TextStyle(color: Colors.white),
                        )),
                    title: Text(
                      _usuario.nome ?? "",
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ListTileField(
                                title: "Peso:",
                                value: NumberFormat("0.00", "pt_BR")
                                    .format(imc.peso)),
                            const SizedBox(
                              width: 20,
                              child: Center(child: Text("/")),
                            ),
                            ListTileField(
                                title: "Altura:",
                                value: NumberFormat("0.00", "pt_BR")
                                    .format(imc.altura)),
                          ],
                        ),
                        ListTileField(
                            title: "IMC:",
                            value: ClassificacaoIMCEnum.getBySigla(
                                        imc.classificacaoIMC)
                                    ?.classificacao ??
                                ""),
                        ListTileField(
                          title: "Data/Hora:",
                          value: imc.horario,
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pesoController.text = "";
          _mensagem = "";
          showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                    builder: (stfContext, stfSetState) => AlertDialog(
                      title: const Text("Adicionar Dados"),
                      content: Wrap(
                        children: [
                          Text(
                            _mensagem,
                            style: const TextStyle(color: Colors.red),
                          ),
                          TextField(
                              decoration:
                                  const InputDecoration(label: Text("Peso")),
                              controller: pesoController),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancelar")),
                        TextButton(
                            onPressed: () async {
                              DateFormat format =
                                  DateFormat("dd/MM/yyyy HH:mm");
                              double peso = double.tryParse(pesoController.text
                                      .replaceAll(",", ".")) ??
                                  0.0;
                              double imc = Utils.calcularIMC(
                                  peso, _usuario.altura ?? 0.0);
                              ClassificacaoIMCEnum classificacaoIMC =
                                  Utils.verificarClassificao(imc);

                              if (peso.isNaN ||
                                  peso.isInfinite ||
                                  peso == 0.0) {
                                stfSetState(() {
                                  _mensagem = "Peso inválido";
                                });
                                return;
                              }

                              Navigator.pop(context);
                              _imcRepository.adicionar(ImcModel.criar(
                                  peso,
                                  _usuario.altura!,
                                  imc,
                                  classificacaoIMC.sigla,
                                  format.format(DateTime.now())));
                              obterListaImcs();
                            },
                            child: const Text("Salvar"))
                      ],
                    ),
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
