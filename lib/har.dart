import 'package:http/http.dart';
import 'src/entry.dart';

import 'dart:convert';

class HarClient extends BaseClient {
  Client _client;
  List<Entry> _har = new List();

  HarClient(Client this._client);

  @override
  void close() {
    _client.close();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    var entry = new Entry();
    entry.request = request;
    _har.add(entry);
    return _client.send(request).then((response) {
            entry.setTime();
            entry.response = response;
            return response;
    });
  }

  String toHar() {
    return json.encode({
          'log': {
            'version': '1.1',
            'pages': [],
            'entries':_har,
          },
    });
  }
}
