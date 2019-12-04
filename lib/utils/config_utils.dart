
import 'package:random_profile_swipe_card/configs.dart';
import 'package:random_profile_swipe_card/utils/package_info.dart';

class Dimension {
  static double height = 0.0;
  static double width = 0.0;

  static double getWidth(double size) {
    return width * size;
  }

  static double getHeight(double size) {
    return height * size;
  }
}

Future<PackageInfo> getPackageInfo() {
  return PackageInfo.fromPlatform();
}

String getEnvBuild() {
  return bool.fromEnvironment("dart.vm.product") == true
      ? "R"
      : "D" + buildFlavor.toString().split('.').last;
}

appSetup() async {
  var packageInfo = await getPackageInfo();
  appVersion = "${packageInfo.version}+${packageInfo.buildNumber} ${getEnvBuild()}";
}