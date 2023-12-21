import 'package:dio/dio.dart' as dio;
import 'package:flutter_auth_bloc_dio/core/internet_services/path.dart';

import '../../features/user/domain/model/user.dart';
import 'dio_client.dart' as dio;
import 'dio_client.dart';
import 'dio_exception.dart';

class CrudService {
  Future<List<User>> getUserList() async {
    try {
      final response = await DioClient.instance.get(path);
      final userList = (response["data"] as List).map((e) => User.fromJson(e)).toList();
      return userList;
    } on dio.DioError catch (e) {
      var error = DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  Future<User> create() {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<User> update() {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<User> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
