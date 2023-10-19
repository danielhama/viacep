import 'package:cepapp/model/viacepmodel.dart';
import 'package:cepapp/repository/configuracao_dio.dart';


class ViaCEPRepository {
  final _customDio = Back4AppCustomDio();

  ViaCEPRepository();

  Future<ViaCEPModel> obterCEP() async {
    var url = "/cep";
    var result = await _customDio.dio.get(url);
    return ViaCEPModel.fromJsonEndPoint(result.data);
  }

  Future<void> criar(ViaCEPModel viacepModel) async {
    try {
      await _customDio.dio
          .post("/cep", data: viacepModel.toJsonEndPoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> atualizar(ViaCEPModel viacepmodel) async {
    try {
      var response = await _customDio.dio.put(
          "/cep/${viacepmodel.cep}",
          data: viacepmodel.toJsonEndPoint());
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
}