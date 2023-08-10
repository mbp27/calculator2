import 'dart:io';

import 'package:calculator2/helpers/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final mounted = context.mounted;
    final size = MediaQuery.of(context).size;
    final backgroundColor =
        Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.1);
    final uriEmail = Uri.parse('mailto:prasetyobagus27@gmail.com');
    final uriGithub = Uri.parse('https://github.com/mbp27');
    final uriLinkedIn = Uri.parse(
        'https://www.linkedin.com/in/muhamad-bagus-prasetyo-512b3517b/');

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: size.width / 7,
                  backgroundColor: backgroundColor,
                  child: ClipOval(child: Assets.images.profile.image()),
                ),
              ),
              const SizedBox(height: 16.0),
              const Column(
                children: [
                  Text(
                    'Muhamad Bagus Prasetyo',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Mobile Developer',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'More than ${DateTime.now().year - 2019} years working at '
                      'programming and application development',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Info',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    children: [
                      ListTile(
                        tileColor: backgroundColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.0),
                          ),
                        ),
                        leading: Icon(MdiIcons.account),
                        title: const Text('Name'),
                        subtitle: const Text('Muhamad Bagus Prasetyo'),
                      ),
                      ListTile(
                        tileColor: backgroundColor,
                        leading: Icon(MdiIcons.calendar),
                        title: const Text('Age'),
                        subtitle: Text(
                          '${DateTime.now().year - 1999} years old',
                        ),
                      ),
                      ListTile(
                        tileColor: backgroundColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10.0),
                          ),
                        ),
                        leading: Icon(MdiIcons.mapMarker),
                        title: const Text('Address'),
                        subtitle: const Text('Bekasi, West Java, Indonesia'),
                        onTap: () async {
                          try {
                            final Uri googleMapsUrl = Uri.parse(
                                "https://www.google.com/maps/search/${Uri.encodeFull('Kota Bekasi')}");
                            final Uri appleMapsUrl = Uri.parse(
                                "https://maps.apple.com/?q=${Uri.encodeFull('Kota Bekasi')}");

                            await launchUrl(googleMapsUrl);
                            if (Platform.isIOS) {
                              final nativeAppLaunchSucceeded = await launchUrl(
                                appleMapsUrl,
                                mode: LaunchMode.externalNonBrowserApplication,
                              );
                              if (!nativeAppLaunchSucceeded) {
                                await launchUrl(
                                  appleMapsUrl,
                                  mode: LaunchMode.inAppWebView,
                                );
                              }
                            }
                          } catch (e) {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context)
                              ..clearSnackBars()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text('$e'),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Socials',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Column(
                    children: [
                      ListTile(
                        tileColor: backgroundColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.0),
                          ),
                        ),
                        leading: Icon(MdiIcons.email),
                        title: const Text('Email'),
                        subtitle: const Text(
                          '(Tap for more info)',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        onTap: () async {
                          try {
                            await launchUrl(
                              uriEmail,
                              mode: LaunchMode.externalApplication,
                            );
                          } catch (e) {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context)
                              ..clearSnackBars()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text('$e'),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                          }
                        },
                      ),
                      ListTile(
                        tileColor: backgroundColor,
                        leading: Icon(MdiIcons.github),
                        title: const Text('Github'),
                        subtitle: const Text(
                          '(Tap for more info)',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        onTap: () async {
                          try {
                            await launchUrl(
                              uriGithub,
                              mode: LaunchMode.externalApplication,
                            );
                          } catch (e) {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context)
                              ..clearSnackBars()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text('$e'),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                          }
                        },
                      ),
                      ListTile(
                        tileColor: backgroundColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10.0),
                          ),
                        ),
                        leading: Icon(MdiIcons.linkedin),
                        title: const Text('LinkedIn'),
                        subtitle: const Text(
                          '(Tap for more info)',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        onTap: () async {
                          try {
                            await launchUrl(uriLinkedIn);
                          } catch (e) {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context)
                              ..clearSnackBars()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text('$e'),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
