import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

class ToastiesSideNavMenu extends StatelessWidget {
  const ToastiesSideNavMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        Container(
          width: double.infinity,
          height: 75,
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Text(
            'LegalEase',
            style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                  color: Theme.of(context)
                              .colorScheme
                              .background
                              .computeLuminance() >
                          0.5
                      ? Colors.black
                      : Colors.white,
                ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.notifications_none_outlined),
          
          title: const Text('Notifications'),
          titleTextStyle: Theme.of(context).textTheme.headlineSmall,
          onTap: () {},
          // onTap: () => GoRouter.of(context).go('/notifications'),
        ),
        ListTile(
          leading: const Icon(Icons.person_outline_rounded),
          title: const Text('My Profile'),
          titleTextStyle: Theme.of(context).textTheme.headlineSmall,
          onTap: () {},
          // onTap: () => GoRouter.of(context).go('/profile'),
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          titleTextStyle: Theme.of(context).textTheme.headlineSmall,
          onTap: () {},
          // onTap: () => GoRouter.of(context).go('/settings'),
        ),
      ],
    );
  }
}
