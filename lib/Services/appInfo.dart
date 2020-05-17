import 'package:package_info/package_info.dart';

class AppInfo {
  static final AppInfo _singleton = AppInfo._internal();

  factory AppInfo() {
    return _singleton;
  }

  AppInfo._internal() {
    _initPackageInfo();
  }

  String get appName => _packageInfo.appName;
  String get packageName => _packageInfo.packageName;
  String get version => _packageInfo.version;
  String get buildNumber => _packageInfo.buildNumber;

  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    _packageInfo = info;
  }
}
