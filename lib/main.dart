import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'model/route.dart';
import 'routes/versioninfo/version_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '梵讯人',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _widgetForRoute(window.defaultRouteName),
    );
  }
}

Widget _widgetForRoute(String routeJson) {
  // 解析数据
  Map<String, dynamic> jsonMap = json.decode(routeJson);
  InitialRoute initialRoute = InitialRoute.fromJson(jsonMap);

  switch (initialRoute.route) {
    case 'version_info_route':
      return VersionInfoRoute(initialRoute.data);
    default:
      return Center(
        child: Text('Unknown route: $routeJson', textDirection: TextDirection.ltr),
      );
  }

}
