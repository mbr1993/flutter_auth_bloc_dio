part of 'create_user_bloc.dart';

abstract class CreateUserEvent extends Equatable {
  const CreateUserEvent();
}

class CreateUser extends CreateUserEvent {
  final String name;
  final String job;

  const CreateUser({required this.name, required this.job});

  @override
  List<Object> get props => [name, job];
}
