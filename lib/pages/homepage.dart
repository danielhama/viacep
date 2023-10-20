import 'package:cepapp/repository/cep_back4app_repository.dart';
import 'package:cepapp/services/via_cep_service.dart';
import 'package:flutter/material.dart';

import '../model/viacepmodel.dart';

class ConsultaCEP extends StatefulWidget {
  const ConsultaCEP({Key? key}) : super(key: key);

  @override
  State<ConsultaCEP> createState() => _ConsultaCEPState();
}

class _ConsultaCEPState extends State<ConsultaCEP> {
  var cepController = TextEditingController(text: "");
  bool loading = false;
  var viacepModel = ViaCEPModel();
  var viaCEPService = ViaCepService();
  var viaCEPRepository = ViaCEPRepository();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                "Consulta CEP",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF3B3A38),
      ),
      body: Container(
        color: const Color.fromARGB(255, 59, 58, 56),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              TextField(
                style: TextStyle(fontSize: 18, color: Colors.white70),
                controller: cepController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  suffix: Icon(
                    Icons.search,
                    color: Colors.white70,
                  ),
                  hintText: "Digite um CEP",
                  hintStyle: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 255, 165, 30)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 165, 30))),
                  icon: Icon(
                    Icons.qr_code,
                    color: Colors.white70,
                  ),
                ),
                //maxLength: 8,
                onSubmitted: (String value) async {
                  var cep = value.replaceAll(new RegExp(r'[^0-9]'), '');
                  if (cep.length == 8) {
                    setState(() {
                      loading = true;
                    });
                    viacepModel = await viaCEPService.consultarCEP(cep);
                    bool jaexiste =
                        await viaCEPRepository.obterCEPByCEP(viacepModel.cep!);
                    if (!jaexiste) {
                      await viaCEPRepository.criar(viacepModel);
                    }
                    setState(() {
                      loading = false;
                    });
                  }
                },
              ),
              const Padding(
                padding: const EdgeInsets.fromLTRB(8, 30, 8, 20),
                child: Divider(
                  thickness: 3.0,
                  color: Color.fromARGB(255, 255, 165, 30),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      width: double.infinity,
                      child: Card(
                          color: Color(0xFF3B3A38),
                          elevation: 20,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          viacepModel.cep ?? "",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white70),
                                        ),
                                        Text(
                                          viacepModel.logradouro ?? "",
                                          maxLines: 2,
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white70),
                                        ),
                                        Text(
                                          viacepModel.bairro ?? "",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white70),
                                        ),
                                        Text(
                                          "${viacepModel.localidade ?? ""} - ${viacepModel.uf ?? ""}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white70),
                                        ),
                                        if (loading) CircularProgressIndicator()
                                      ]),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    ));
  }
}
