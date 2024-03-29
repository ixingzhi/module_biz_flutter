import 'dart:convert';
import 'dart:io';
import 'package:xml/xml.dart' as xml;

const targetVersion = "1.0.3";

class DeployObject {
  File pomFile;
  File aarFile;
}

void main() {
  List<File> aarFiles = [];
  List<String> needChangeList = [];
  List<DeployObject> deploys = [];

  final dir = Directory(
      "/Users/xiedongdong/Documents/AndroidStudioProjects/module_biz_flutter/build/host/outputs/repo");

  // 扫描aar
  for (final file in dir.listSync(recursive: true)) {
    if (file.path.endsWith(".aar")) {
      print(file.path);
      aarFiles.add(file); // aar文件
      needChangeList.add(
        file.uri.pathSegments[file.uri.pathSegments.length - 3],
      );
    }
  }

  for (final aar in aarFiles) {
    final pomFile = handlePom(needChangeList, aar); // 处理pom文件
    deploys.add(DeployObject()
      ..aarFile = aar
      ..pomFile = pomFile);
  }

  for (final deploy in deploys) {
    deployPkt(deploy);
  }

}

File handlePom(List<String> needChangeVersionList, File aarFile) {
  final pomPath = aarFile.path.substring(0, aarFile.path.length - 3) + 'pom';

  final file = File(pomPath);

  final doc = xml.parse(file.readAsStringSync());

  {
    // 修改自身的版本号
    final xml.XmlText versionNode =
        doc
            .findAllElements("version")
            .first
            .firstChild;
    versionNode.text = targetVersion;
  }

  final elements = doc.findAllElements("dependency");
  for (final element in elements) {
    final artifactId = element
        .findElements("artifactId")
        .first
        .text;
    if (needChangeVersionList.contains(artifactId)) {
      final xml.XmlText versionNode =
          element
              .findElements("version")
              .first
              .firstChild;
      versionNode.text = targetVersion; // 修改依赖的版本号
    }
  }

  final buffer = StringBuffer();

  doc.writePrettyTo(buffer, 0, "  ");
  print(buffer);

  return file..writeAsStringSync(buffer.toString());
}

Future<void> deployPkt(DeployObject deploy) async {
  final configPath = File('mvn-settings.xml').absolute.path;
  List<String> args = [
    'deploy:deploy-file',
    '-DpomFile="${deploy.pomFile.absolute.path}"',
    '-DgeneratePom=false',
    '-Dfile="${deploy.aarFile.absolute.path}"',
    '-Durl="http://localhost:8081/repository/maven-releases"',
    '-DrepositoryId="nexus"',
    '-Dpackaging=aar',
    '-s="$configPath"',
  ];
  final shell = "mvn ${args.join(' \\\n    ')}";
  final f = File(
      "${Directory.systemTemp.path}/${DateTime
          .now()
          .millisecondsSinceEpoch}.sh");
  f.writeAsStringSync(shell);
  final process = await Process.start('bash', [f.path]);
  final output = await utf8.decodeStream(process.stdout);
  print(output);
  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    exit(exitCode);
  }
}
