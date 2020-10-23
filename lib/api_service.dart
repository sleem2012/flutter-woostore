import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_woocomerce/config.dart';
import 'package:flutter_woocomerce/model/customer.dart';
import 'package:flutter_woocomerce/model/login_model.dart';

class APIServices {
  Future<bool> createCustomer(CustomerModel) async {
    var authToken =
    base64.encode(utf8.encode(Config.key + ':' + Config.secret));
    bool ret = false;

    try {
      var response = await Dio().post(
          Config.url + Config.customerURL,
          data: CustomerModel.toJson(),
          options: Options(
              headers: {
                HttpHeaders.authorizationHeader: 'Basic $authToken',
                HttpHeaders.contentTypeHeader: 'application/json',

              }
          )

      );
      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }
    return ret;
  }


  Future<LoginResponseModel> loginCustomer(String username,
      String password) async {
    LoginResponseModel model;

    try {
      var response = await Dio().post(
          Config.tokenURL,
          data: {
            "username": username,
            "password": password,
          },
          options: Options(
              headers: {
                HttpHeaders
                    .contentTypeHeader: 'application/x-www-form-urlencoded',

              }
          )

      );
      if (response.statusCode == 200) {
        model = LoginResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return model;
  }


}
