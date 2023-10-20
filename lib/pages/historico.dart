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
  bool loading = false;
  var viacepModel = ViaCEPModel();
  var viaCEPService = ViaCepService();
  var viaCEPRepository = ViaCEPRepository();
  List<ViaCEPModel> ceps = <ViaCEPModel>[];

  // @override
  // void initState() async {
  //   super.initState();
  //   ceps = await viaCEPRepository.obterCEP();
  //   setState(() {});
  // }
  void apagarRegistro(String objectId) async {
    await viaCEPRepository.remover(objectId);
    await viaCEPRepository.obterCEP();
    setState(() {});
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
        backgroundColor: const Color(0xFF3B3A38),
      ),
      body: ListView.builder(
          itemCount: ceps.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onLongPress: () {
                apagarRegistro(ceps[index].objectId!);
              },
              child: Container(
                color: Color.fromARGB(255, 93, 91, 87),
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      ceps[index].cep ?? "",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    Text(
                      ceps[index].logradouro ?? "",
                      maxLines: 2,
                      softWrap: true,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    Text(
                      ceps[index].bairro ?? "",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    Text(
                      "${ceps[index].localidade ?? " "} - ${ceps[index].uf ?? ""}",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    if (loading) const CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          ceps = await viaCEPRepository.obterCEP();
          setState(() {});
        },
      ),
    ));
  }
}
