import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_microsvc_util/flutter_microsvc_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _projectVersion = '';
  String _projectCode = '';
  String _projectAppID = '';
  String _projectName = '';

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterMicrosvcUtil.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await FlutterMicrosvcUtil.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    String projectCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectCode = await FlutterMicrosvcUtil.projectCode;
    } on PlatformException {
      projectCode = 'Failed to get build number.';
    }

    String projectAppID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectAppID = await FlutterMicrosvcUtil.appID;
    } on PlatformException {
      projectAppID = 'Failed to get app ID.';
    }

    String projectName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectName = await FlutterMicrosvcUtil.appName;
    } on PlatformException {
      projectName = 'Failed to get app name.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;

      _projectVersion = projectVersion;
      _projectCode = projectCode;
      _projectAppID = projectAppID;
      _projectName = projectName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_microsvc_util'),
        ),
        body: Center(
            // child: Text('Running on: $_platformVersion\n'),
            child: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            Text('Running on: $_platformVersion\n'),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            Text('project version: $_projectVersion\n'),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            Text('project code: $_projectCode\n'),
            // Padding(padding: EdgeInsets.only(bottom: 12.0)),
            // Text('project app id: $_projectAppID\n'),
            // Padding(padding: EdgeInsets.only(bottom: 12.0)),
            // Text('project name: $_projectName\n'),
          ],
        )),
      ),
    );
  }
}
