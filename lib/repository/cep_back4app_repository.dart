import 'package:cepapp/model/viacepmodel.dart';
import 'package:cepapp/repository/configuracao_dio.dart';

class ViaCEPRepository {
  final _customDio = Back4AppCustomDio();

  ViaCEPRepository();

  Future<List<ViaCEPModel>> obterCEP() async {
    var url = "/cep";
    var result = await _customDio.dio.get(url);
    Map resultbody = result.data;
    print(resultbody);
    return jsonToList(resultbody['results']);
  }

  Future<bool> obterCEPByCEP(String cep) async {
    var url = "/cep?where=";
    var result = await _customDio.dio.get('$url{"cep":$cep}');
    Map resultbody = result.data;
    print(resultbody);
    if (resultbody['results'].isNotEmpty) {
      return true;
    } else {
      return false;
    }
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
        listamodel.add(ViaCEPModel.fromJsonEndPoint(item));
      }
    }
    return listamodel;
  }
}
