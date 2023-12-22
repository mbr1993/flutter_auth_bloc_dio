import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/internet_services/crud_service.dart';

part 'delete_user_event.dart';

part 'delete_user_state.dart';

class DeleteUserBloc extends Bloc<DeleteUserEvent, DeleteUserState> {
  final CrudService crudService;

  DeleteUserBloc({required this.crudService}) : super(DeleteUserInitial()) {
    on<DeleteUser>((event, emit) async {
      emit(DeleteUserLoading());
      try {
        await crudService.deleteUser(event.id);
        emit(DeleteUserLoaded());
      } catch (e) {
        rethrow;
      }
    });
  }
}
