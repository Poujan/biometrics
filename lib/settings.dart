import 'package:biometrics/provider.dart/screen_lock_provider.dart';
import 'package:flutter/material.dart';

import '../provider.dart/db_provider.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({Key? key}) : super(key: key);

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  bool _secured = false;
  @override
  void initState() {
    super.initState();
    DbProvider().getAuthState().then((value) {
      setState(() {
        _secured = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                title: const Text("Secure Account"),
                subtitle: const Text("Enable two factor authentication"),
                trailing: Switch(
                    value: _secured,
                    onChanged: (value) {
                      setState(() {
                        _secured = value;
                      });
                      ScreenLock(ctx: context).authenticateUser(
                          path: 'setting',
                          value: value,
                          message: 'Please confirm Identity');
                    }),
              ),
            ],
          )),
    );
  }
}
