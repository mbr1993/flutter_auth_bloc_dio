part of 'update_user_bloc.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();
}

class UpdateUserInitial extends UpdateUserState {
  @override
  List<Object> get props => [];
}

class UpdateUserLoading extends UpdateUserState {
  @override
  List<Object> get props => [];
}

class UpdateUserLoaded extends UpdateUserState {
  final NewUser newUser;

  const UpdateUserLoaded({required this.newUser});

  @override
  List<Object> get props => [newUser];
}
