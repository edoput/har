import 'package:http/http.dart';
import 'package:intl/intl.dart';
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
    var entry = Entry();
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
            'version': '1.2',
            'creator': {
              'name': 'har-dump',
              'version': '0.0.1',
            },
            'pages': [{
              'id': 'page_0',
              'title': 'some page',
              'pageTimings': {},
              'startedDateTime': DateFormat("y-MM-ddTH:mm:ss.000+01:00").format(DateTime.now()),
            }],
            'entries':_har,
          },
    });
  }
}
