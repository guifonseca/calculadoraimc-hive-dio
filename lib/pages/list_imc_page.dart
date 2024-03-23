import 'package:calculadoraimcdio/model/enums.dart';
import 'package:calculadoraimcdio/model/imc_model.dart';
import 'package:calculadoraimcdio/repositories/imc_repository.dart';
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
  final ImcRepository imcRepository = ImcRepository();

  List<ImcModel>? _imcs;
  String _mensagem = "";

  TextEditingController nomeController = TextEditingController(text: "");
  TextEditingController pesoController = TextEditingController(text: "");
  TextEditingController alturaController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    obterListaImcs();
  }

  void obterListaImcs() async {
    _imcs = await imcRepository.listarImcs();
    setState(() {});
  }

  void salvar() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de IMC"),
      ),
      body: _imcs == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: _imcs?.length ?? 0,
              itemBuilder: (context, index) {
                var imc = _imcs![index];
                return Dismissible(
                    key: Key(imc.id),
                    onDismissed: (direction) async {
                      await imcRepository.remove(imc.id);
                      obterListaImcs();
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: ListTile(
                          isThreeLine: true,
                          leading: CircleAvatar(
                              backgroundColor:
                                  Utils.getIMCAvatarColor(imc.classificacaoIMC),
                              child: Text(
                                imc.classificacaoIMC.sigla,
                                style: const TextStyle(color: Colors.white),
                              )),
                          title: Text(
                            imc.nome,
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
                                  value: imc.classificacaoIMC.classificacao),
                              ListTileField(
                                title: "Data/Hora:",
                                value:
                                    "${imc.horario.day.toString().padLeft(2, '0')}/${imc.horario.month.toString().padLeft(2, '0')}/${imc.horario.year} ${imc.horario.hour}:${imc.horario.second.toString().padLeft(2, '0')}",
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
          nomeController.text = "";
          pesoController.text = "";
          alturaController.text = "";
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
                                  const InputDecoration(label: Text("Nome")),
                              controller: nomeController),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        label: Text("Peso")),
                                    keyboardType: TextInputType.number,
                                    controller: pesoController,
                                  )),
                              Container(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        label: Text("Altura")),
                                    keyboardType: TextInputType.number,
                                    controller: alturaController,
                                  ))
                            ],
                          )
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
                              double peso = double.tryParse(pesoController.text
                                      .replaceAll(",", ".")) ??
                                  0.0;
                              double altura = double.tryParse(alturaController
                                      .text
                                      .replaceAll(",", ".")) ??
                                  0.0;
                              double imc = Utils.calcularIMC(peso, altura);
                              ClassificacaoIMCEnum classificacaoIMC =
                                  Utils.verificarClassificao(imc);

                              if (nomeController.text.length < 3) {
                                stfSetState(() {
                                  _mensagem = "Nome inválido";
                                });
                                return;
                              }

                              if (peso.isNaN ||
                                  peso.isInfinite ||
                                  peso == 0.0) {
                                stfSetState(() {
                                  _mensagem = "Peso inválido";
                                });
                                return;
                              }

                              if (altura.isNaN ||
                                  altura.isInfinite ||
                                  altura == 0.0) {
                                stfSetState(() {
                                  _mensagem = "Altura inválida";
                                });
                                return;
                              }

                              Navigator.pop(context);
                              await imcRepository.adicionar(ImcModel(
                                  nomeController.text,
                                  peso,
                                  altura,
                                  imc,
                                  classificacaoIMC));
                              setState(() {});
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
