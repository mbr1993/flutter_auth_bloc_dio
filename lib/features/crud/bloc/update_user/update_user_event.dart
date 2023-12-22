part of 'update_user_bloc.dart';

abstract class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();
}

class UpdateUser extends UpdateUserEvent {
  final String id;
  final String name;
  final String job;

  const UpdateUser({required this.id, required this.name, required this.job});

  @override
  List<Object> get props => [id, name, job];
}
