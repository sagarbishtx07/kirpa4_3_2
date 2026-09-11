import 'package:kirpa/top.dart';

class IOSParameters {
  const IOSParameters({
    String? bundleId,
    String? minimumVersion,
    String? appStoreId,
    Uri? fallbackUrl,
    String? ipadBundleId,
    Uri? ipadFallbackUrl,
  });
}

class AndroidParameters {
  const AndroidParameters({
    String? packageName,
    int? minimumVersion,
    Uri? fallbackUrl,
  });
}

class DynamicLink {
  final String dynamicLinkUriPrefix;
  final String permalink;
  final IOSParameters? iosParameters;
  final AndroidParameters? androidParameters;
  final String? dynamicLinkType;

  DynamicLink({
    required this.dynamicLinkUriPrefix,
    required this.permalink,
    this.iosParameters,
    this.androidParameters,
    this.dynamicLinkType,
  });

  // Short Dynamic Link (Stubbed)
  Future<Uri> dynamicShortLink() async {
    return Uri.parse(permalink);
  }

  // Long Dynamic Link (Stubbed)
  Future<Uri> dynamicLongLink() async {
    return Uri.parse(permalink);
  }
}
