// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/message.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import '../home_controller.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final nameVN = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTln6M7PmkjhhGZLHkDG3pmdd6K13z-FqJ87Q&s'),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: [
                Selector<AuthProvide, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://www.metacritic.com/a/img/catalog/provider/6/12/6-1-667237-52.jpg';
                  },
                  builder: (_, value, __) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 35,
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProvide, String>(
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ??
                            'Não informado';
                      },
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: context.titleStyle3,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Alterar Nome'),
                    content: TextField(
                      onChanged: (value) => nameVN.value = value,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final nameValue = nameVN.value;
                          if (nameValue.isEmpty) {
                            Messages.of(context).showError('Nome obrigátorio');
                          } else {
                            Loader.show(context);
                            await context
                                .read<UserService>()
                                .updateDisplayName(nameValue);
                            Loader.hide();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Alterar'),
                      ),
                    ],
                  );
                },
              );
            },
            title: Text(
              'Alterar Nome',
              style: context.titleStyle3,
            ),
          ),
          ListTile(
            onTap: () {
              context.read<HomeController>().clearTableTodo();
              context.read<AuthProvide>().logout();
            },
            title: Text(
              'Sair',
              style: context.titleStyle3,
            ),
          ),
        ],
      ),
    );
  }
}
