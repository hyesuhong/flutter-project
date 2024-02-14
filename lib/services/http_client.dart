import 'dart:convert';
import 'dart:io' as io;

class HttpClient {
  final String _baseUrl;

  const HttpClient._internal(this._baseUrl);

  factory HttpClient(String baseUrl) {
    final String modifiedUrl = _removeSlashEndOfUrl(baseUrl);
    return HttpClient._internal(modifiedUrl);
  }

  static String _removeSlashEndOfUrl(String url) {
    if (url.endsWith('/')) {
      return url.replaceRange(url.length - 1, null, '');
    }
    return url;
  }

  /// throw
  ///
  /// Deletes the file at [path] from the file system.
  ///
  /// Deletes the file at `path` from the file system.
  void get(String endPoint) async {
    final io.HttpClient client = io.HttpClient();
    client.connectionTimeout = Duration(
      seconds: 1,
    );
    final url = Uri.parse('$_baseUrl/$endPoint');

    try {
      final io.HttpClientRequest request = await client.getUrl(url);
      request.headers.contentType = io.ContentType(
        'application',
        'json',
        charset: 'utf-8',
      );

      final io.HttpClientResponse response = await request.close();

      final stringData = await response.transform(utf8.decoder).join();
      print('res body');
      print(stringData);
    } catch (error) {
      print(error);
    } finally {
      client.close();
    }
  }
}
