abstract class IClientAdapter {
  Future<Response> get(
    String url, {
    Map<String, String>? headers,
  });

  Future<Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });

  Future<Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });

  Future<Response> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });

  Future<Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });
}

class Response {
  final int statusCode;
  final String body;

  Response({
    required this.statusCode,
    required this.body,
  });
}
