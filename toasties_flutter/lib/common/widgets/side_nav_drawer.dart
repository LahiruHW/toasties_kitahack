import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/providers/auth_provider.dart';
import 'package:toasties_flutter/common/utility/toasties_firestore_services.dart';

class ToastiesSideNavMenu extends StatelessWidget {
  const ToastiesSideNavMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<ToastieAuthProvider>(context);
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
          // onTap: () => GoRouter.of(context).push('/notifications'),
        ),
        ListTile(
          leading: const Icon(Icons.person_outline_rounded),
          title: const Text('My Profile'),
          titleTextStyle: Theme.of(context).textTheme.headlineSmall,
          onTap: () {},
          // onTap: () => GoRouter.of(context).push('/profile'),
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          titleTextStyle: Theme.of(context).textTheme.headlineSmall,
          // onTap: () {},
          onTap: () => GoRouter.of(context).push('/settings'),
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: const Text('Log Out'),
          titleTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
          onTap: () {
            authProvider.signOut().then(
                  (value) => GoRouter.of(context).go('/login-base'),
                );
          },
        ),
        
        ListTile(
          leading: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          title: const Text('Nuke All Firebase Collections & exit'),
          titleTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
          onTap: () {},
        ),

        ListTile(
          leading: const Icon(
            Icons.connect_without_contact,
            color: Colors.red,
          ),
          title: const Text('Spoof Firebase Data'),
          titleTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
          onTap: () {
            ToastiesFirestoreServices.spoofData(authProvider.user!.uid);
          },
        ),
      ],
    );
  }
}
