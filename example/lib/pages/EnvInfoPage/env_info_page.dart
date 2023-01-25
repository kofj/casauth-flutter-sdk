import 'package:casauth_example/components/envinfo.dart';
import 'package:flutter/material.dart';

class EnvInfoPage extends StatefulWidget {
  const EnvInfoPage({Key? key}) : super(key: key);

  @override
  State<EnvInfoPage> createState() => _EnvInfoPageState();
}

class _EnvInfoPageState extends State<EnvInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const EnvInfo(),
    );
  }
}
