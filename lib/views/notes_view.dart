import 'package:flutter/material.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/main.dart';
import 'package:mynotes/services/auth/auth_service.dart';

import '../constants/routes.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              switch(value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                            (_) => false
                    );
                  }
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem<MenuAction> (
                  value: MenuAction.logout,
                  child: Text('Sign out'),
                )
              ];
            },
          )
        ],
      ),
    );
  }
}