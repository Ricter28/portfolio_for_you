import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/generated/assets.gen.dart';

@RoutePage() 
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Assets.icons.launcher.logo.image(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
        ),
      ),
    );
  }
}
