import 'package:flutter/material.dart';

import '/constants/image_constants.dart';
import '/constants/secure_storage_constants.dart';
import '/screens/homepage_screen.dart';
import '/utils/navigate.dart';
import '/utils/secure_storage_helper.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key, required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 5),
      () => navigateReplacement(
        context,
        HomeScreen(
          location: location,
        ),
      ),
    );
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstants.backgroundImage,
            ),
            fit: BoxFit.cover,
          ),
          color: Colors.black,
        ),
        child: SizedBox(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "We show weather for you",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * .2,
                ),
                SizedBox(
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      SecureStorageHelper()
                          .write(
                              key: SecureStorageConstants.hasSeen,
                              value: true.toString())
                          .then(
                            (_) => navigateReplacement(
                              context,
                              HomeScreen(
                                location: location,
                              ),
                            ),
                          );
                    },
                    child: const Text("Skip"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
