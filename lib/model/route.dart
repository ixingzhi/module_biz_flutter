import 'package:json_annotation/json_annotation.dart';

part 'route.g.dart';

// flutter packages pub run build_runner build
@JsonSerializable()
class InitialRoute {
  String route;
  dynamic data;

  InitialRoute({this.route, this.data});

  factory InitialRoute.fromJson(Map<String, dynamic> json) =>
      _$RouteFromJson(json);
}
