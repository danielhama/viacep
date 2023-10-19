import 'package:cepapp/model/viacepmodel.dart';
import 'package:cepapp/repository/configuracao_dio.dart';
import 'package:cepapp/services/via_cep_service.dart';

class ViaCEPRepository {
  final _customDio = Back4AppCustomDio();

  ViaCEPRepository();

  Future<List<ViaCEPModel>> obterCEP() async {
    var url = "/cep";
    var result = await _customDio.dio.get(url);
    var resultbody = result.data;
    // print(result);
    // List<Map<String, String>>? body = result["results"];
    return jsonToList(resultbody['results']);
  }

  Future<void> criar(ViaCEPModel viacepModel) async {
    try {
      await _customDio.dio.post("/cep", data: viacepModel.toJsonEndPoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> atualizar(ViaCEPModel viacepmodel) async {
    try {
      var response = await _customDio.dio
          .put("/cep/${viacepmodel.cep}", data: viacepmodel.toJsonEndPoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      var response = await _customDio.dio.delete(
        "/cep/$objectId",
      );
    } catch (e) {
      throw e;
    }
  }

  List<ViaCEPModel> jsonToList(var lista) {
    List<ViaCEPModel> listamodel = <ViaCEPModel>[];

    if (lista != null) {
      for (Map<String, dynamic> item in lista) {
        listamodel.add(ViaCEPModel.fromJson(item));
      }
    }
    return listamodel;
  }
}
