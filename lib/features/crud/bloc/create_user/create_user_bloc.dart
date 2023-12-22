import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/internet_services/crud_service.dart';
import '../../model/new_user.dart';

part 'create_user_event.dart';

part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  CrudService crudService;

  CreateUserBloc({required this.crudService}) : super(CreateUserInitial()) {
    on<CreateUser>((event, emit) async {
      emit(CreateUserLoading());
      try {
        final result = await crudService.createUser(event.name, event.job);
        emit(CreateUserLoaded(newUser: result));
      } catch (e) {
        rethrow;
      }
    });
  }
}
