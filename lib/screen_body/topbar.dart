import 'package:flutter/material.dart';
import 'package:intern_challenges/state/themes.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Internship Challenge'),
      actions: [
        IconButton(
          onPressed: () async {
            context.read<ThemeModels>().changeTheme();
          },
          icon: context.watch<ThemeModels>().isDark == true
              ? const Icon(Icons.dark_mode)
              : const Icon(Icons.light_mode),
        )
      ],
    );
  }
}
