import 'package:equatable/equatable.dart';
import 'package:flutter_auth_bloc_dio/core/internet_services/crud_service.dart';
import 'package:flutter_auth_bloc_dio/features/crud/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  CrudService crudService;

  GetUserBloc({required this.crudService}) : super(GetUserLoading()) {
    on<GetUser>((event, emit) async {
      emit(GetUserLoading());
      try {
        final userList = await crudService.getUserList();
        emit(GetUserLoaded(userList: userList));
      } catch (e) {
        emit(GetUserError());
      }
    });
  }
}
