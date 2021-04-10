import 'package:http/http.dart';

abstract class NetworkService<T> {
  Function(T) onSuccess;

  Function(String) onError;

  void call(Function(T) onSuccess, Function(String) onError) async {
    this.onSuccess = onSuccess;
    this.onError = onError;

    Response response = await get(endPoint());
    if (response.statusCode == 200) {
      parseJson(response.body);
    } else {
      onError("Network call failed");
    }
  }

  Future<T> callDirectly() async {
    Response response = await get(endPoint());

    if (response.statusCode == 200) {
      return getData(response.body);
    } else {
      return getData("");
    }

  }

  void parseJson(String json);

  T getData(String json);

  String endPoint();
}
