import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc_dio/features/crud/bloc/create_user/create_user_bloc.dart';
import 'package:flutter_auth_bloc_dio/features/crud/screens/widgets/text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/bloc/auth_bloc/auth_bloc.dart';
import '../bloc/delete_user/delete_user_bloc.dart';
import '../bloc/get_user/get_user_bloc.dart';
import '../bloc/update_user/update_user_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Padding(padding: EdgeInsets.only(right: 24.0), child: Icon(Icons.logout)),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            },
          ),
        ],
      ),
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
                          title: Wrap(spacing: 6, children: [Text(user.firstName!), Text(user.lastName!)]),
                          subtitle: Text(user.email!, style: const TextStyle(color: Colors.grey)),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(4))),
                                    builder: (context) {
                                      return Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom,
                                            left: 16,
                                            right: 16,
                                            top: 16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            const SizedBox(height: 12),
                                            customTextFormField(user.firstName.toString(), nameController),
                                            const SizedBox(height: 20),
                                            customTextFormField('Enter job', jobController),
                                            const SizedBox(height: 16),
                                            customTextFormField(user.id.toString(), idController),
                                            const SizedBox(height: 16),
                                            ElevatedButton(
                                                onPressed: () {
                                                  BlocProvider.of<UpdateUserBloc>(context).add(
                                                    UpdateUser(
                                                      id: user.id.toString(),
                                                      name: nameController.text,
                                                      job: jobController.text,
                                                    ),
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(content: Text('User Updated')),
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Update')),
                                            const SizedBox(height: 16),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.edit_outlined, color: Colors.blueGrey.withOpacity(0.6)),
                              ),
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<DeleteUserBloc>(context).add(DeleteUser(user.id.toString()));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('User Deleted')),
                                  );
                                },
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
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(4))),
            builder: (context) {
              return Container(
                padding:
                    EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(height: 12),
                    customTextFormField('Enter name', nameController),
                    const SizedBox(height: 20),
                    customTextFormField('Enter job', jobController),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CreateUserBloc>(context).add(
                            CreateUser(name: nameController.text, job: jobController.text),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User Created')),
                          );
                          Navigator.pop(context);
                          nameController.clear();
                          jobController.clear();
                        },
                        child: const Text('Create')),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
