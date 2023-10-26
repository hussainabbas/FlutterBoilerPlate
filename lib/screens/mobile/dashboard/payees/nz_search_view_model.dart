import 'dart:async';

import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:manawanui/data/models/get_nz_addresses_response.dart';
import 'package:manawanui/data/repository/repository_nz_search.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

/*class NZSearchViewModel {
  late final RepositoryNZSearch _repository;

  NZSearchViewModel({required RepositoryNZSearch repository}) {
    _repository = repository;
  }

  final _responseGetNZAddressController =
      StreamController<ApiResult<GetNZAddressResponse>>.broadcast();

  Stream<ApiResult<GetNZAddressResponse>> get responseGetNZAddressStream =>
      _responseGetNZAddressController.stream;

  Future<void> getNzAddressesResponse(String search, Map<String, String> header) async {
    try {
      final response = await _repository.getNzAddressesResponse(search, header);
      _responseGetNZAddressController.sink.add(response);
    } catch (e) {
      console('getNzAddressesResponse - Error fetching data: $e');
      _responseGetNZAddressController.sink.add(
          ApiResult<GetNZAddressResponse>(error: 'Failed to load data: $e'));
    }
  }

  void dispose() {
    _responseGetNZAddressController.close();
  }
}*/

class NZSearchViewModel {
  late final RepositoryNZSearch _repository;

  NZSearchViewModel({required RepositoryNZSearch repository}) {
    _repository = repository;
  }

  final _responseGetNZAddressController =
      StreamController<GetNZAddressResponse>.broadcast();

  Stream<GetNZAddressResponse> get responseGetNZAddressStream =>
      _responseGetNZAddressController.stream;

  Future<void> getNzAddressesResponse(
      String search, Map<String, String> header) async {
    try {
      var dio = Dio()
        ..interceptors.add(
          AwesomeDioInterceptor(
            logRequestTimeout: true,
            logRequestHeaders: true,
            logResponseHeaders: true,
            logger: debugPrint,
          ),
        );
      var response = await dio.request(
        'https://api.nzpost.co.nz/addresschecker/1.0/suggest?q=$search',
        options: Options(
          method: 'GET',
          headers: header,
        ),
      );

      console("getNzAddressesResponse => ${response.statusCode}");

      if (response.statusCode == 200) {
        GetNZAddressResponse getNZAddressResponse =
            GetNZAddressResponse.fromJson(response.data);
        _responseGetNZAddressController.sink.add(getNZAddressResponse);
      } else {
        _responseGetNZAddressController.sink
            .add(GetNZAddressResponse(success: false));
      }
    } catch (e) {
      console('getNzAddressesResponse - Error fetching data: $e');
      _responseGetNZAddressController.sink
          .add(GetNZAddressResponse(success: false));
    }
  }

  void dispose() {
    _responseGetNZAddressController.close();
  }
}
