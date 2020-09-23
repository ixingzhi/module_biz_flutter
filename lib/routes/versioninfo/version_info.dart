import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VersionInfoRoute extends StatelessWidget {

  String versionName;

  VersionInfoRoute(this.versionName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "版本信息",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image(
                  image: AssetImage(
                      'static/images/biz_mine_ic_version_info_background.webp'),
                  width: double.infinity,
                ),
                Positioned(
                  top: 30,
                  child: Image(
                    image: AssetImage(
                        'static/images/biz_ic_logo.png'),
                    width: 60,
                    height: 60,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("《梵讯人》是梵讯内部管理系统结合手机移动端办公场景，我们梵讯人自己使用的移动端APP。"),
            ),
            Divider(height: 1.0,),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  const Expanded(child: Text("当前版本"),),
                  Text(versionName),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
