import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_woocomerce/model/category.dart';
import 'package:flutter_woocomerce/model/login_model.dart';
import 'package:flutter_woocomerce/model/product.dart';
import './config.dart';
import 'model/customer.dart';

class APIServices {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64.encode(
      utf8.encode(Config.key + ':' + Config.secret),
    );
    var ret = false;
    try {
      var response = await Dio().post(Config.url + Config.customerURL,
          data: model.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: 'application/json'
          }));
      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (error) {
      print(error.message);
      if (error.response.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }
    return ret;
  }

  Future<LoginResponse> loginCustomer(String username, String password) async {
    LoginResponse model;
    var authorization =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var authToken = base64.encode(
      utf8.encode(Config.key + ':' + Config.secret),
    );

    try {
      var response = await Dio().post(
        Config.tokenURL,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $authToken',
          HttpHeaders.contentTypeHeader: 'application/x-www-from-urlencoded'
        }, responseType: ResponseType.json),
      );
      print('rea');
      print('response ${response.data}');
      if (response.statusCode == 200) {
        model = LoginResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      print('error:${e.message}');
      throw e;
    }
    return model;
  }

  Future<List<Category>> getCategories() async {
    List<Category> data = List<Category>();

    try {
      String url = Config.url +
          Config.categoriesURL +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Category.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      print(e.response);
    }
    return data;
  }

  Future<List<Product>> getProducts({
    int pageNumber,
    int pageSize,
    String strSearch,
    String tagName,
    String categoryId,
    String sortBy,
    String sortOrder = "asc",
  }) async {
    List<Product> data = List<Product>();

    try {
      String parameter = "";

      if (strSearch != null) {
        parameter += "&search=$strSearch";
      }
      if (pageSize != null) {
        parameter += "&per_page=$pageSize";
      }
      if (pageNumber != null) {
        parameter += "&page=$pageNumber";
      }
      if (tagName != null) {
        parameter += "&tag=$tagName";
      }
      if (categoryId != null) {
        parameter += "&category=$categoryId";
      }
      if (sortBy != null) {
        parameter += "&orderby=$sortBy";
      }
      if (sortOrder != null) {
        parameter += "&order=$sortOrder";
      }
      String url = Config.url +
          Config.productsURL +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}&${parameter.toString()}";
      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Product.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      print(e.response);
    }
    return data;
  }
}
