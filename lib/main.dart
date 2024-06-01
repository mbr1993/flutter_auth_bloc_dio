import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc_dio/core/internet_services/crud_service.dart';
import 'package:flutter_auth_bloc_dio/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_auth_bloc_dio/features/auth/repositories/repositories.dart';
import 'package:flutter_auth_bloc_dio/features/auth/screens/login_screen.dart';
import 'package:flutter_auth_bloc_dio/features/crud/bloc/create_user/create_user_bloc.dart';
import 'package:flutter_auth_bloc_dio/features/crud/bloc/delete_user/delete_user_bloc.dart';
import 'package:flutter_auth_bloc_dio/features/crud/bloc/get_user/get_user_bloc.dart';
import 'package:flutter_auth_bloc_dio/features/crud/bloc/update_user/update_user_bloc.dart';
import 'package:flutter_auth_bloc_dio/features/crud/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final userRepository = AuthRepository();
  final crudService = CrudService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(userRepository: userRepository)..add(AppStarted())),
        BlocProvider<GetUserBloc>(create: (context) => GetUserBloc(crudService: crudService)..add(GetUser())),
        BlocProvider<DeleteUserBloc>(create: (context) => DeleteUserBloc(crudService: crudService)),
        BlocProvider<CreateUserBloc>(create: (context) => CreateUserBloc(crudService: crudService)),
        BlocProvider<UpdateUserBloc>(create: (context) => UpdateUserBloc(crudService: crudService)),
      ],
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.userRepository, super.key});

  final AuthRepository userRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          switch (state) {
            case AuthAuthenticated():
              return const HomeScreen();
            case AuthUnauthenticated():
              return LoginScreen(userRepository: userRepository);
            default:
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
