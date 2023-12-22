part of 'get_user_bloc.dart';

sealed class GetUserState extends Equatable {
  const GetUserState();
}

///This is the loading state to show when an event starts
class GetUserLoading extends GetUserState {
  @override
  List<Object?> get props => [];
}

///This is the state to be shown when user data has been gotten
class GetUserLoaded extends GetUserState {
  final List<User> userList;

  const GetUserLoaded({required this.userList});

  @override
  List<Object?> get props => [userList];
}

class GetUserError extends GetUserState {
  @override
  List<Object> get props => [];
}
