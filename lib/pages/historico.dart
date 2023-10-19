import 'package:cepapp/repository/cep_back4app_repository.dart';
import 'package:cepapp/services/via_cep_service.dart';
import 'package:flutter/material.dart';

import '../model/viacepmodel.dart';

class Historico extends StatefulWidget {
  const Historico({Key? key}) : super(key: key);

  @override
  State<Historico> createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  var cepController = TextEditingController(text: "");
  bool loading = false;
  var viacepModel = ViaCEPModel();
  var viaCEPService = ViaCepService();
  var viaCEPRepository = ViaCEPRepository();
  List<ViaCEPModel> ceps = <ViaCEPModel>[];

  @override
  void initState() async {
    super.initState();
    ceps = await viaCEPRepository.obterCEP();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF3B3A38),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mail,
              color: Colors.white70,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Historico de Pesquisas",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF3B3A38),
      ),
      body: ListView(children: [
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            viacepModel.cep ?? "",
            style: const TextStyle(fontSize: 18, color: Colors.white70),
          ),
          Text(
            viacepModel.logradouro ?? "",
            maxLines: 2,
            softWrap: true,
            style: const TextStyle(fontSize: 18, color: Colors.white70),
          ),
          Text(
            viacepModel.bairro ?? "",
            style: const TextStyle(fontSize: 18, color: Colors.white70),
          ),
          Text(
            "${viacepModel.localidade ?? ""} - ${viacepModel.uf ?? ""}",
            style: const TextStyle(fontSize: 18, color: Colors.white70),
          ),
          if (loading) CircularProgressIndicator()
        ]),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {},
      ),
    ));
  }
}
