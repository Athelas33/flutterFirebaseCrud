import 'package:package_info/package_info.dart';

class PackageManager {
  PackageInfo packageInfo;
  static String _versionNo;
  static String get versionNo => _versionNo;
  static PackageManager _instance;
  static PackageManager get instance {
    _instance ??= PackageManager();
    return _instance;
  }

  static void getVersion() {
    PackageInfo.fromPlatform().then((value) {
      _versionNo = value.version;
    });
  }

  static void initPackageInfo() {
    PackageInfo.fromPlatform().then((value) {
      instance.packageInfo = value;
    });
  }

  String getBuildNumber() {
    return packageInfo?.buildNumber ?? '0';
  }
}
