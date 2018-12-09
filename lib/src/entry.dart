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
  final cache = {
    'beforeRequest': null,
    'afterRequest': null,
  };
  final timings = {
   'send': 0,
   'wait': 0,
   'receive': 0,
  };

  Map<String, dynamic> toJson() {
    var t = {
       'time': time,
       //'startedDateTime': dateFormat.format(startedDateTime),
       //'startedDateTime': startedDateTime,
       'cache': cache,
       'timings': timings,
       'startedDateTime': DateFormat("y-MM-ddTH:mm:ss.000+01:00").format(startedDateTime),
       'request': HarRequest(_request).toJson(),
       'response': HarResponse(_response).toJson(),
    };
    return t;
 }


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
