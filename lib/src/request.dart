import 'package:http/http.dart';

import './kv.dart';

class CacheUsage {}

class HarRequest {
  BaseRequest _r;
  // cookies []
  // postData:  optional
  // headerSize: -1 if not available

  HarRequest(BaseRequest this._r);

  Map<String, dynamic> toJson() {
    var t = {
      'pageref': 'page_0',
      'method': _r.method,
      'url': _r.url.toString(),
      'httpVersion': 'HTTP/1.1',
      'cookies': [],
      'headers': parseHeaders(_r.headers.entries),
      'queryString': parseQueryParams(_r.url.queryParameters.entries),
      'headersSize': -1,
      'bodySize': _r.contentLength,
    };
    return t;
  }
}


class PostData {
  String mimetype;
  List<PostParameter> params; // case of url-encoded parameters
  String text; // Plain text posted data
}

class PostParameter {
  String name;
  String value; // optional
  String filename; // optional
  String contentType; // optional
}

