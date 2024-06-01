import 'package:dio/dio.dart';
import 'package:flutter_auth_bloc_dio/core/internet_services/dio_client.dart';
import 'package:flutter_auth_bloc_dio/core/internet_services/dio_exception.dart';
import 'package:flutter_auth_bloc_dio/core/internet_services/path.dart';
import 'package:flutter_auth_bloc_dio/features/crud/model/new_user.dart';
import 'package:flutter_auth_bloc_dio/features/crud/model/user.dart';

class CrudService {
  Future<List<User>> getUserList() async {
    try {
      final response = await DioClient.instance.get(path);
      final userList = (response["data"] as List).map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
      return userList;
    } on DioException catch (e) {
      final error = DioErrors(e);
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
      final error = DioErrors(e);
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
      final error = DioErrors(e);
      throw error.errorMessage;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await DioClient.instance.delete("$path/$id");
    } on DioException catch (e) {
      final error = DioErrors(e);
      throw error.errorMessage;
    }
  }
}
