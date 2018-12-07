import 'package:intl/intl.dart';
import 'package:http/http.dart';

class CacheUsage {}

class HarRequest {
  BaseRequest _r;
  // method
  // url
  // httpVersion
  // cookies []
  // headers []
  // querystring []
  // postData:  optional
  // headerSize: -1 if not available
  // bodySize: -1 if not available

  HarRequest(BaseRequest this._r);

  Map<String, dynamic> toJson() {
    return {
      'method': _r.method,
      'url': _r.url.host,
      'httpVersion': 'HTTP/1.1',
      'cookies': [],
      'headers': [],
      'querystring': [],
      'headersize': -1,
      'bodySize': -1,
    };
  }
}


class Cookies {
  // String name
  // String value
  // String path: optional
  // String domain: optional
  // DateTime expires: optional, ISO 8601 datetime
  // bool httpOnly: optional
  // bool secure: optional
}

class Header {
  String name;
  String value;
  String comment;
}

class queryString {
  String name;
  String value;
}

class postData {
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

class HarResponse {
  BaseResponse _r;
  // status
  // statusText
  // httpVersion
  // cookies []
  // headers []
  // content {}
  // redirectURL: Location response header
  // headerSize: -1 if not available
  // bodySize: -1 if not available

  HarResponse(BaseResponse this._r);

  Map<String, dynamic> toJson() {
    return {
      'status': _r.statusCode,
      'statusText': _r.reasonPhrase,
      'httpVersion': 'HTTP/1.1',
      'cookies': [],
      'headers': [],
      'content': {},
      'redirectUrl': _r.headers['Location'],
      'headerSize': -1,
      'bodySize': -1,
    };
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
  Map<String, dynamic> cache = new Map();
  Map<String, dynamic> timings = new Map();

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
