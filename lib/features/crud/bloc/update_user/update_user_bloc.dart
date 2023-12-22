import 'package:equatable/equatable.dart';
import 'package:flutter_auth_bloc_dio/features/crud/model/new_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/internet_services/crud_service.dart';

part 'update_user_event.dart';

part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final CrudService crudService;

  UpdateUserBloc({required this.crudService}) : super(UpdateUserInitial()) {
    on<UpdateUser>((event, emit) async {
      emit(UpdateUserLoading());
      try {
        final result = await crudService.updateUser(event.id, event.name, event.job);
        emit(UpdateUserLoaded(newUser: result));
      } catch (e) {
        rethrow;
      }
    });
  }
}
