import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/core/environments/environment.dart';
import 'package:sample_project/core/firebase/firebase_messaging.dart';
import 'package:sample_project/core/utils/enums.dart';
import '../../../config/routes/routes.dart';
import '../../../core/device/adaptive_layout_builder.dart';
import 'package:sample_project/core/extensions/context_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    FirebasePushNotifications().initiateTheFirebaseListeners();
    FirebasePushNotifications.initializeLocalPushNotifications();
    super.initState();
  }

  List<(IconData, String, String, String)> homeCards = [
    (
      Icons.dashboard,
      'Groceries',
      'It contains groceries with different types',
      Routes.groceryHomePath
    ),
    (
      Icons.code,
      'Isolates',
      'Currently works in mobile application only',
      Routes.isolatesMainPath
    ),
    (
      Icons.notifications_active,
      'Push Notifications',
      'Firebase Cloud Messaging',
      Routes.pushNotificationsMainPath
    ),
    (
      Icons.share,
      'Share PDF',
      'Share Dynamic PDF with image',
      Routes.dynamicPdfMainPath
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(Environment().configuration.orgName),
            leading: Padding(
              padding: const EdgeInsets.all(7),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(Environment().configuration.logoPath,
                      height: 35, width: 35, alignment: Alignment.center)),
            ),
            actions: [
              IconButton(
                  onPressed: () => context.goNamed(Routes.profile),
                  icon: const Icon(Icons.person, size: 30))
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: AdaptiveLayoutBuilder(
            builder: (context, deviceType) => GridView.builder(
                itemCount: homeCards.length,
                addAutomaticKeepAlives: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.9,
                    crossAxisCount: switch (deviceType) {
                      DeviceResolutionType.mobile => 2,
                      DeviceResolutionType.tab => 3,
                      DeviceResolutionType.desktop => 6
                    }),
                itemBuilder: (_, index) {
                  var details = homeCards[index];
                  return _BuildHomeCard(
                      icon: details.$1,
                      title: details.$2,
                      description: details.$3,
                      route: details.$4);
                }),
          ),
        ));
  }
}

class _BuildHomeCard extends StatelessWidget {
  final String title, description, route;
  final IconData icon;
  const _BuildHomeCard(
      {required this.title,
      required this.description,
      required this.icon,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.go(route),
        customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Icon(icon, size: 32, color: Colors.orange),
              Text(
                'Title : $title',
                style: context.titleMedium,
              ),
              Text('Des : $description'),
            ],
          ),
        ),
      ),
    );
  }
}
