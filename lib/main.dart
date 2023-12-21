import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/internet_services/crud_service.dart';
import 'features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/repositories/repositories.dart';
import 'features/user/bloc/get_user_bloc/get_user_bloc.dart';
import 'features/user/presentation/screens/customer_screen.dart';

void main() {
  final userRepository = AuthRepository();
  CrudService crudService = CrudService();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(userRepository: userRepository)..add(AppStarted())),
        BlocProvider<GetUserBloc>(create: (context) => GetUserBloc(crudService: crudService)..add(GetUser())),
      ],
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository userRepository;

  const MyApp({super.key, required this.userRepository});

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
              return const UserList();
            case AuthUnauthenticated():
              return LoginScreen(userRepository: userRepository);
            default:
              return Scaffold(
                body: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent), strokeWidth: 4.0),
                      )
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
