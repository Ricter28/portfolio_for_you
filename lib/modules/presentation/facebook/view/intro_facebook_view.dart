import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/modules/presentation/facebook/bloc/app_setting.dart';
import 'package:flutter_template/router/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class IntroFacebookView extends StatelessWidget {
  const IntroFacebookView({super.key});

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/icons/logo.png',
                      width: 100,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    appName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            _buildLoginButton(context),
            _buildFoodter(),
          ],
        ),
      ),
    );
  }

  Padding _buildLoginButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
        ),
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                color: Color(0xFF1877F2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/fc.png',
                  width: 32,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  'Login with facebook',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
          onTap: () {
            //Todo
            context.router.pushNamed(Routes.face);
          },
        ));
  }

  Padding _buildFoodter() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              launchInBrowser(
                  Uri.parse('https://www.facebook.com/privacy/policy'));
            },
            child: const Text(
              'Privacy Policy',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          GestureDetector(
            onTap: () {
              launchInBrowser(Uri.parse('https://www.facebook.com/reg'));
            },
            child: const Text(
              'Create an Account',
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
