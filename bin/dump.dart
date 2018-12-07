import 'package:http/http.dart';
import '../lib/har.dart';

main() {
  var client = new Client();
  var har = new HarClient(client);
  har.get('https://google.com').then((_) => print(har.toHar()));
}
