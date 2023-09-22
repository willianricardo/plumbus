// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' hide Response;
import 'package:plumbus/core/adapters/cache/cache_adapter_interface.dart';
import 'package:plumbus/core/adapters/http/client_adapter_interface.dart';
import 'package:plumbus/core/environments/app_environment.dart';

class HttpClient extends IClientAdapter {
  final ICacheAdapter _prefs;
  final Client _client = Client();

  HttpClient(
    this._prefs,
  );

  Uri getUri(String url) => Uri.parse(
        url.startsWith('/')
            ? '${AppEnvironments.get('SERVER_URL')}/TService$url'
            : url,
      );

  Future<Map<String, String>?> getHeaders({
    Map<String, String>? headers,
  }) async {
    final user = await _prefs.getString('usuario');

    if (user != '') {
      headers ??= {};
      headers['Authorization'] = 'Basic ${json.decode(user)['TOKEN']}';
    }

    return {
      'Content-Type': 'application/json',
      ...?headers,
    };
  }

  @override
  Future<Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await _client.delete(
      getUri(url),
      headers: await getHeaders(headers: headers),
      body: body,
    );

    return Response(
      body: response.body,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<Response> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    final response = await _client.get(
      getUri(url),
      headers: await getHeaders(headers: headers),
    );

    return Response(
      body: response.body,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<Response> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await _client.patch(
      getUri(url),
      headers: await getHeaders(headers: headers),
      body: body,
    );

    return Response(
      body: response.body,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await _client.post(
      getUri(url),
      headers: await getHeaders(headers: headers),
      body: body,
    );

    return Response(
      body: response.body,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final response = await _client.put(
      getUri(url),
      headers: await getHeaders(headers: headers),
      body: body,
    );

    return Response(
      body: response.body,
      statusCode: response.statusCode,
    );
  }
}
