import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Selector<AuthProvide, String>(
        selector: (context, authProvide) =>
            authProvide.user?.displayName ?? 'Não Informado',
        builder: (_, value, __) {
          return Text(
            'E ai, $value!',
            style: context.titleStyle.copyWith(fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }
}
