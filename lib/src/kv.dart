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
  Header(this.name, this.value);

  Map<String, String> toJson() {
    return {'name': name, 'value': value};
  }
}

class QueryString {
  String name;
  String value;
  QueryString(this.name, this.value);

  Map<String, String> toJson() {
    return {'name': name, 'value': value};
  }
}
