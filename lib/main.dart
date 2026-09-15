import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:kirpa/service/constants/preferences.dart';
import 'service/service.dart';
import 'register_service/appsflyer/appsflyer.dart';

/// App starts
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializePushNotificationService();
  await AppsFlyerDynamicLink().startSDK();
  SharedPreferences sharedPref = await getSharedPref();

  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    String? lastVersion = sharedPref.getString('last_cleared_version');
    int? lastClearedTimestamp = sharedPref.getInt('last_cleared_timestamp');
    
    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    bool shouldClear = false;

    if (lastVersion != currentVersion) {
        shouldClear = true;
    } else if (lastClearedTimestamp == null || (currentTimestamp - lastClearedTimestamp) > 7 * 24 * 60 * 60 * 1000) {
        shouldClear = true;
    }

    if (shouldClear) {
        await sharedPref.remove(Preferences.settings);
        await sharedPref.remove(Preferences.categories);
        
        await sharedPref.setString('last_cleared_version', currentVersion);
        await sharedPref.setInt('last_cleared_timestamp', currentTimestamp);
    }
  } catch (e) {
    // ignore
  }


  await AppServiceInject.create(
    PreferenceModule(sharedPref: sharedPref),
    NetworkModule(),
  );

  runApp(AppServiceInject.instance.getApp);
}
