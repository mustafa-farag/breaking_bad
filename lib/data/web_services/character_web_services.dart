import 'package:breaking_bad/utilities/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CharacterWebServices {
  late Dio dio;

  CharacterWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

    Future<List<dynamic>> getAllCharacters() async {
      try {
        Response response = await dio.get('characters');
        return response.data;
      } catch (error) {
        debugPrint(error.toString());
        return [];
      }
    }
  }

