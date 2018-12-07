import 'package:http/http.dart';

import './kv.dart';

class HarResponse {
  BaseResponse _r;
  // cookies []
  // headerSize: -1 if not available

  HarResponse(BaseResponse this._r);

  Map<String, dynamic> toJson() {
    final content = ResponseContent(
                      _r.contentLength,
                      _r.headers['content-type'],
    );
 
    var _t = {
      'bodySize': _r.contentLength,
      'content': content.toJson(),
      'cookies': [],
      'headers': List.from(_r.headers.entries.map((el) => Header(el.key, el.value))),
      'headersSize': -1,
      'httpVersion': 'HTTP/1.1',
      'pageref': 'page_0',
      'redirectURL': '',
      'status': _r.statusCode,
      'statusText': _r.reasonPhrase,
    };
    if (_r.headers.containsKey('Location')) {
      _t['redirectURL'] = _r.headers['Location'];
    }
    return _t;
  }
}

class ResponseContent {
  String encoding;
  String mimeType;
  String text;
  int compression = 0;
  int size;

  ResponseContent(
                  this.size,
                  this.mimeType,
                  {
                    this.compression = 0,
                    this.text = '',
                    this.encoding = '',
                  });

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'compression': compression,
      'mimeType': mimeType,
      'text': text,
      'encoding': encoding,
    };
  }
}
