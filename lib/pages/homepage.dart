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
  var viaCEPRepository = ViaCepService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail, 
              color: Colors.white70,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Consulta CEP", 
                style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 59, 58, 56),
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
                //maxLength: 8,
                onChanged: (String value) async {
                  var cep = value.replaceAll(new RegExp(r'[^0-9]'), '');
                  if (cep.length == 8) {
                    setState(() {
                      loading = true;
                    });
                    viacepModel = await viaCEPRepository.consultarCEP(cep);
                  }
                  setState(() {
                    loading = false;
                  });
                },
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                viacepModel.logradouro ?? "",
                style: TextStyle(fontSize: 22),
              ),
              Text(
                "${viacepModel.localidade ?? ""} - ${viacepModel.uf ?? ""}",
                style: TextStyle(fontSize: 22),
              ),
              if (loading) CircularProgressIndicator()
            ],
                  ),
                ),
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {},
      ),
    ));
  }
}