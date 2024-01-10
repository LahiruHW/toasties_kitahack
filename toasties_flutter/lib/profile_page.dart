import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/providers/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ToastieAuthProvider>(
      builder: (context, provider, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Card(
                clipBehavior: Clip.hardEdge,
                borderOnForeground: true,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CachedNetworkImage(
                          imageUrl: provider.user.photoURL ?? "",
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          cacheKey: "profile-img",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Icon(
                            Icons.account_box_rounded,
                            size: 100,
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.account_box_rounded,
                            size: 100,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${provider.user.displayName}',
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                      ),
                                ),
                                Text(
                                  '${provider.user.email}',
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.black, height: 1.0),
                    TextButton(
                      onPressed: () {},
                      // make the text button expand to fill the entire width
                      style: TextButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        fixedSize: const Size(double.infinity, 60),
                        maximumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: const Text("Edit Profile"),
                    )
                  ],
                ),
              ),
              Text(
                '${provider.user.uid}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}