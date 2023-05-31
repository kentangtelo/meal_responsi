import 'base_network.dart';

class Controller {
  static Controller instance = Controller();

  Future<Map<String, dynamic>> loadList(String url) {
    return BaseNetwork.get(url);
  }
}
