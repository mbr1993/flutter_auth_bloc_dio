import 'package:dio/dio.dart';

import '../../features/crud/model/new_user.dart';
import '../../features/crud/model/user.dart';
import 'dio_client.dart';
import 'dio_exception.dart';
import 'path.dart';

class CrudService {
  Future<List<User>> getUserList() async {
    try {
      final response = await DioClient.instance.get(path);
      final userList = (response["data"] as List).map((e) => User.fromJson(e)).toList();
      return userList;
    } on DioException catch (e) {
      var error = DioErrors(e);
      throw error.errorMessage;
    }
  }

  Future<NewUser> createUser(String name, String job) async {
    try {
      final response = await DioClient.instance.post(
        path,
        data: {'name': name, 'job': job},
      );
      return NewUser.fromJson(response);
    } on DioException catch (e) {
      var error = DioErrors(e);
      throw error.errorMessage;
    }
  }

  Future<NewUser> updateUser(String id, String name, String job) async {
    try {
      final response = await DioClient.instance.put(
        '$path/$id',
        data: {'id': id, 'name': name, 'job': job},
      );
      return NewUser.fromJson(response);
    } on DioException catch (e) {
      var error = DioErrors(e);
      throw error.errorMessage;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await DioClient.instance.delete("$path/$id");
    } on DioException catch (e) {
      var error = DioErrors(e);
      throw error.errorMessage;
    }
  }
}
