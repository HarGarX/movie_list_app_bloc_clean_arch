import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/error_consts.dart';
import '../errors/exception.dart';
import '../models/movie_model.dart';

class ApiClient {
  final http.Client client;
  ApiClient(
    this.client,
  );

  final String apiUrl = 'http://192.168.0.109:';
  static const String apiKey = '259f88559587d69d838d005f57b77929';

  Future<dynamic> post(String endpoint, Map<String, dynamic> model,
      {bool withAuth = false}) async {
    try {
      final http.Response response = await client
          .post(Uri.parse(endpoint), body: jsonEncode(model))
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        return responseBody;
      }
      throw const ServerException(errorMessage: ErrorConst.UNKNOWN_ERROR);
    } on TimeoutException {
      rethrow;
    } on SocketException {
      throw const NoInternetException(
          errorMessage: ErrorConst.NO_INTERNET_MESSAGE);
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final http.Response response = await client
          .post(
            Uri.parse('${endpoint}api_key=$apiKey'),
          )
          .timeout(const Duration(seconds: 30));
      print('--------- Response Body \n ${response.body}');

      if (response.statusCode == 200) {
        final parsedResponse = mapResponse(response);
        final upComingMoviesList = await compute(
          moviesModelFromJson,
          jsonEncode(
            parsedResponse['results'],
          ),
        );
        return upComingMoviesList;
      }
      print(
          "FROM REMOTE API ------------${endpoint}api_key=$apiKey \n  ${response.body}");

      throw const ServerException(errorMessage: ErrorConst.UNKNOWN_ERROR);
    } on TimeoutException {
      rethrow;
    } on SocketException {
      throw const NoInternetException(
          errorMessage: ErrorConst.NO_INTERNET_MESSAGE);
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }

  Map<String, dynamic> mapResponse(http.Response response) {
    Map<String, dynamic> result = json.decode(response.body);
    return result;
  }
}
