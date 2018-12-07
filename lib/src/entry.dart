import 'package:intl/intl.dart';
import 'package:http/http.dart';

import './kv.dart';
import './request.dart';
import './response.dart';

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
