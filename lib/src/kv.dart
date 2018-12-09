class Cookie {
  String name;
  String value;
  String path;
  String domain;
  String expires;
  bool httpOnly;
  bool secure;

  Cookie(
    this.name,
    this.value,
    {
      this.path = '',
      this.domain = '',
      this.expires = '',
      this.httpOnly = false,
      this.secure = false,
    }
  );

  Map<String, String> toJson() {
    return {'name': name, 'value': value};
  }
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

List<Cookie> parseCookies (Iterable<MapEntry<String, String>> headers) {
  bool filterCookie(MapEntry<String, String> header) {
    return header.key == 'Set-Cookie' || header.key == 'set-cookie';
  }

  return List.from(headers.where(filterCookie).map((el) => Cookie(el.key, el.value)));
}

List<Header> parseHeaders (Iterable<MapEntry<String, String>> headers) {
  return List.from(headers.map((el) => Header(el.key, el.value)));
}

List<QueryString> parseQueryParams (Iterable<MapEntry<String, String>> params) {
  return List.from(params.map((el) => QueryString(el.key, el.value)));
}
