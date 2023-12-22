part of 'create_user_bloc.dart';

abstract class CreateUserState extends Equatable {
  const CreateUserState();
}

class CreateUserInitial extends CreateUserState {
  @override
  List<Object> get props => [];
}

class CreateUserLoading extends CreateUserState {
  @override
  List<Object> get props => [];
}

class CreateUserLoaded extends CreateUserState {
  final NewUser newUser;

  const CreateUserLoaded({required this.newUser});

  @override
  List<Object> get props => [newUser];
}
