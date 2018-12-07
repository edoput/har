import 'package:http/http.dart';
import 'package:args/args.dart';
import '../lib/har.dart';

main(List<String> args) {
  var parser = ArgParser();
  var result = parser.parse(args);
  final url = result.rest.first;

  var client = Client();
  var har = HarClient(client);
  har.get(url).then((_) => print(har.toHar()));
}
