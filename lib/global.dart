import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:payment/flutter_payment.dart';
// import 'package:fluwx/fluwx.dart';
import 'package:push/flutter_notify.dart';
import 'package:rxdart/rxdart.dart';
import 'package:service_package/service_package.dart';

class Global {
  static BehaviorSubject<LatLng?> pos = BehaviorSubject.seeded(null);
  // static Fluwx fluwx = Fluwx();

  static Future init({required String pushType}) async {
    // await enableFluttifyLog(false);
    // await AmapSearch.instance.updatePrivacyAgree(true);
    // await AmapSearch.instance.updatePrivacyShow(true);
    // await AmapService.instance.init(
    //   iosKey: 'e2c66fbf69dbe434b1a9d05fd2b883a4',
    //   androidKey: '7c9daac55e90a439f7b4304b465297fa',
    //   webKey: 'e69c6fddf6ccf8de917f5990deaa9aa2',
    // );
    print("====>>>>");
    print(Env.envConfig.appTitle);
    print(EnvName.envKey);
    print(const String.fromEnvironment(EnvName.envKey));
    Payment.setupMPay(env: MPayEnvType.uat);
    Payment.setupWeChat(
        appId: 'wx927d1ca946e5bd72',
        universalLink: 'https://www.macauscholar.com/app/');
    // fluwx.registerApi(
    //     appId: 'wx927d1ca946e5bd72',
    //     universalLink: 'https://www.macauscholar.com/app/');
    ServiceGlobal.initDistributor(mid: "scholar", pid: "order");
    ServiceGlobal.initToken(
        uid: '1',
        token:
            'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJhMWNiOTEyMy04MDI4LTRkYmItYWE5Zi1lYzQwZTIzZGUyZGIiLCJtaWQiOiJoZXlkYXkiLCJwaWQiOiJ3eHdvcmsiLCJpYXQiOjE2ODQ4OTYxNDYsImV4cCI6MTY4NTUwMDk0Nn0.OIRoIi_L-1xt0IQV5SRfyTk-erE0Vwncn9BsY9UieVikrbPTVZ2GaCaD5H588ISrS-bAucXa80vS5v4tYxqUn0RDct-9COdx9yIw41SsT5_KiR71iOvbwoMyMk50C0QIE1_dvUBpdWILM_uahw3WB56twbEneP2o_atf9zk9pzsX5JCtO3F8fcOKsev-AWDR2CCz7xbXOCN2c9kHTwfbucPL0VRevvzm324_XyHevKOBQNBHR437JJ4knVRwBkxorjIC_Jc1mSedbA2zGcXI_90ZfIwJnbhCeFF9WKpP0XWMTH0NHeJCZBSEyaoh48u3OivOtAR_vNeaqllh-vWtVw');
    GlobalNotify.initDistributorId(
        bundleId: "com.macauscholar.app.uat",
        pushType: pushType,
        hmsAppId: '108129709');
    GlobalNotify.addEventHandler(
      pushClickAction: (Map<String, dynamic> msg) async {
        Future.delayed(const Duration(milliseconds: 500)).then((value) {
          CustomNavigatorObserver().routeObserver.navigator?.pushNamed('third');
        });
      },
      onRegisteredDone: (Map<String, dynamic> msg) async {
        print("++++++>>>>>>$msg");
      },
    );

    // Global.tpush.addEventHandler(
    //   onRegisteredDeviceToken: (String msg) async {
    //     print("====>>>>$msg");
    //   },
    //   onRegisteredDone: (String msg) async {},
    //   unRegistered: (String msg) async {
    //     // printMsg("flutter unRegistered: $msg");
    //   },
    //   onReceiveNotificationResponse: (Map<String, dynamic> msg) async {},
    //   onReceiveMessage: (Map<String, dynamic> msg) async {},
    //   xgPushDidSetBadge: (String msg) async {},
    //   xgPushDidBindWithIdentifier: (String msg) async {},
    //   xgPushDidUnbindWithIdentifier: (String msg) async {},
    //   xgPushDidUpdatedBindedIdentifier: (String msg) async {},
    //   xgPushDidClearAllIdentifiers: (String msg) async {},
    //   xgPushClickAction: (Map<String, dynamic> msg) async {},
    // );
    //
    // Global.tpush.configureClusterDomainName("tpns.hk.tencent.com");
    //
    // Global.tpush.setEnableDebug(true);
  }

  // static startTPNS() async {
  //   if (Platform.isAndroid) {
  //     XgFlutterPlugin.xgApi.enableOtherPush();
  //     const accessId = "";
  //     const accessKey = "";
  //     if (accessId.isNotEmpty && accessKey.isNotEmpty) {
  //       tpush.startXg(accessId, accessKey);
  //     }
  //   } else if (Platform.isIOS) {
  //     const accessId = "1630004015";
  //     const accessKey = "IKYVPG0566FG";
  //     if (accessId.isNotEmpty && accessKey.isNotEmpty) {
  //       tpush.startXg(accessId, accessKey);
  //     }
  //   }
  // }
}
