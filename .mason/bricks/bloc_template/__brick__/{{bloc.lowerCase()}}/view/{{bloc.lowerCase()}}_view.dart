import 'package:flutter/material.dart';

class {{bloc.pascalCase()}}Widget extends StatelessWidget {
  const {{bloc.pascalCase()}}Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('{{{bloc.lowerCase()}}} view is working')),
    );
  }
}