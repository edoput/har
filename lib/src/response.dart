import 'package:http/http.dart';

import './kv.dart';

class HarResponse {
  BaseResponse _r;
  // cookies []
  // content {}
  // headerSize: -1 if not available

  HarResponse(BaseResponse this._r);

  Map<String, dynamic> toJson() {
    var _t = {
      'status': _r.statusCode,
      'statusText': _r.reasonPhrase,
      'httpVersion': 'HTTP/1.1',
      'cookies': [],
      'headers': List.from(_r.headers.entries.map((el) => Header(el.key, el.value))),
      'content': {},
      'redirectUrl': '',
      'headerSize': -1,
      'bodySize': _r.contentLength,
    };
    if (_r.headers.containsKey('Location')) {
      _t['redirectUrl'] = _r.headers['Location'];
    }
    return _t;
  }
}

class ResponseContent {
  int size;
  int compression = 0;
  String mimeType;
  String text; // optional
  String encoding; // optional
}
