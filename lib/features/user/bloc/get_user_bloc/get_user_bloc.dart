import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/internet_services/crud_service.dart';
import '../../domain/model/user.dart';

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
