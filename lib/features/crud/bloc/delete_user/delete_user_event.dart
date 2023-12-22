part of 'delete_user_bloc.dart';

abstract class DeleteUserEvent extends Equatable {
  const DeleteUserEvent();
}

class DeleteUser extends DeleteUserEvent {
  final String id;

  const DeleteUser(this.id);

  @override
  List<Object?> get props => [id];
}
