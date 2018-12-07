import 'package:intl/intl.dart';
import 'package:http/http.dart';

import './request.dart';
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

class Entry {
  // ISO 8601 format
  final DateFormat dateFormat = DateFormat("y-M-dTHms.sTZD");
  DateTime startedDateTime;
  int time;
  BaseRequest _request;
  BaseResponse _response;
  Map<String, dynamic> cache = {};
  Map<String, dynamic> timings = {};

  Map<String, dynamic> toJson() => {
    'time': time,
    //'startedDateTime': dateFormat.format(startedDateTime),
    //'startedDateTime': startedDateTime,
    'cache': cache,
    'timings': timings,
    'request': HarRequest(_request),
    'response': HarResponse(_response),
  };

  Entry() {
    startedDateTime = DateTime.now();
  }

  get request => _request;
  set request(BaseRequest request) => _request = request;

  get response => _response;
  set response(BaseResponse response) => _response = response;

  setTime() {
    this.time = DateTime.now().difference(this.startedDateTime).inMilliseconds;
  }
}
