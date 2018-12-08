HAR
===

Debug your HTTP interactions by dumping to a HAR file

```dart
import 'package:har/har.dart';

var customHTTPClient = MyHTTPClient();
var wrapper = HarClient(myClient);
// bare usage
wrapper.get("https://google.com");
wrapper.toHar();

// pass it as your new http client
var client = MyApiClient(wrapper);
wrapper.toHar();
```


Features
--------

- [ ] Post data
- [x] Cookies
- [x] Headers
- [x] Query strings
