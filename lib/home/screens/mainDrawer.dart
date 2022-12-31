import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taste_not_waste/authentication/bloc/authentication_bloc.dart';

import 'allegryScreen.dart';


class mainDrawer extends StatelessWidget {
  const mainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('My Allergies'),
            onTap: () {
              Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>   allegryScreen()),
                        );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.train,
            ),
            title: const Text('Logout'),
            onTap: () {
              context.read<AuthenticationBloc>().add(
                    LogoutEvent(
                      email: "",
                      password: "",
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
