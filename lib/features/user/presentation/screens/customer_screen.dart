import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/get_user_bloc/get_user_bloc.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reqres.in Users List'), centerTitle: true, actions: [
        IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            })
      ]),
      body: BlocBuilder<GetUserBloc, GetUserState>(
        builder: (BuildContext context, GetUserState state) {
          switch (state) {
            case GetUserLoading():
              return const Center(child: CircularProgressIndicator());
            case GetUserLoaded():
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.userList.length,
                      itemBuilder: (context, index) {
                        var user = state.userList[index];
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(user.avatar!),
                          ),
                          title: Wrap(spacing: 6, children: [
                            Text(user.firstName!),
                            Text(user.lastName!),
                          ]),
                          subtitle: Text(user.email!),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit_outlined, color: Colors.blueGrey.withOpacity(0.6)),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete_outlined, color: Colors.blueGrey.withOpacity(0.6)),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            case GetUserError():
              return const Center(child: Text('Error'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
