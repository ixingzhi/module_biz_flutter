import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module_biz_flutter/colors/colors.dart';
import 'package:module_biz_flutter/routes/versioninfo/version_info.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _MainAppList();
  }
}

class _MainAppList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainAppListState();
  }
}

class _MainAppListState extends State {
  List<String> _list = [];
  var _divider = Divider(color: ThemeColors.colorBaseDividerLine);

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("梵讯人"),
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.white)),
      body: Container(
        color: Colors.white,
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.android),
                title: Text(_list[index],
                    style: TextStyle(color: ThemeColors.colorBaseText1)),
                onTap: () {
                  _push(index);
                },
//            onLongPress: () {
//              Toast.show("$index", context);
//            },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return _divider;
            },
            itemCount: _list.length),
      ),
    );
  }

  void _initData() {
    _list.add("版本信息");
    _list.add("关于版本");
    _list.add("考勤管理");
  }

  void _push(int index) {
    switch (index) {
      case 0:
        {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => VersionInfoRoute("beta")));
        }
        break;
      case 1:
        {}
        break;
    }
  }
}
