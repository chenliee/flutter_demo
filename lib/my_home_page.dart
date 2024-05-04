import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:amap_map_fluttify/amap_map_fluttify.dart' as a;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:payment/flutter_payment.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pointycastle/api.dart' as api;
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asn1/asn1_object.dart';
import 'package:pointycastle/asn1/primitives/asn1_bit_string.dart';
import 'package:pointycastle/asn1/primitives/asn1_integer.dart';
import 'package:pointycastle/asn1/primitives/asn1_object_identifier.dart';
import 'package:pointycastle/asn1/primitives/asn1_sequence.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/signers/rsa_signer.dart';
import 'package:pointycastle/src/platform_check/platform_check.dart' as ab;
import 'package:push/flutter_notify.dart';
import 'package:service_package/service_package.dart';
import 'package:untitled1/pay/third.dart';
import 'package:untitled1/router_observer.dart';
import 'package:untitled1/widget/cheetah_button.dart';
import 'package:untitled1/widget/map/map.dart';
import 'package:untitled1/widget/upload.dart';
import 'package:url_launcher/url_launcher.dart';

import 'global.dart';
import 'list.dart';

class SimpleController extends GetxController {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    update();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String decodedSvg = '';
  var res = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* Payment.setupWeChat(
        appId: 'wxd906c488fea94d78',
        universalLink: 'https://www.macauscholar.com');*/
    Permission.location.request().then((status) async {
      try {
        Position? pos = ((status.isGranted
            ? await Geolocator.getCurrentPosition(
                desiredAccuracy: io.Platform.isIOS
                    ? LocationAccuracy.best
                    : LocationAccuracy.medium,
                forceAndroidLocationManager: io.Platform.isAndroid)
            : await Geolocator.getLastKnownPosition())!);
        a.LatLng? res = a.LatLng(pos.latitude, pos.longitude);
        Global.pos.add(res);
      } catch (e) {
        Debug.printMsg(e.toString(), StackTrace.current);
      }
    });
    String svgString =
        "data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='120' height='40' viewBox='0%2c0%2c120%2c40'%3e%3cpath d='M2 30 C58 29%2c61 19%2c101 31' stroke='%23444' fill='none'/%3e%3cpath d='M3 32 C44 23%2c59 13%2c109 16' stroke='%23333' fill='none'/%3e%3cpath fill='%23222' d='M82.88 35.32L83.00 35.43L82.90 35.34Q78.86 35.60 77.87 33.27L77.97 33.38L77.79 33.19Q78.55 32.25 80.12 30.46L80.27 30.61L80.21 30.55Q80.75 32.62 83.76 32.73L83.76 32.74L83.66 32.63Q87.12 32.79 88.76 31.45L88.68 31.38L88.76 31.45Q90.19 29.87 90.11 27.17L90.07 27.13L90.13 27.19Q89.87 22.01 85.07 22.24L85.09 22.26L85.08 22.25Q82.36 22.51 80.61 23.76L80.58 23.72L80.11 23.42L80.04 23.41L79.96 23.34Q80.43 20.31 80.32 17.57L80.30 17.55L80.26 17.51Q80.12 14.86 79.78 11.55L79.69 11.45L79.83 11.60Q83.34 12.41 87.15 12.29L87.29 12.44L87.17 12.31Q90.97 12.23 94.55 10.97L94.58 11.00L94.10 12.62L94.09 12.61Q93.82 13.41 93.63 14.24L93.47 14.09L93.64 14.25Q90.51 15.27 86.62 15.27L86.50 15.14L86.58 15.22Q85.07 15.16 83.59 15.01L83.61 15.04L83.70 15.12Q83.62 15.80 83.27 20.25L83.22 20.20L83.14 20.12Q84.08 19.77 86.14 19.62L86.10 19.58L86.08 19.56Q89.93 19.91 91.38 21.58L91.33 21.54L91.28 21.48Q92.72 23.08 92.99 26.93L92.99 26.92L92.98 26.92Q93.22 31.07 92.00 33.09L91.89 32.99L92.02 33.12Q89.87 34.88 86.56 35.11L86.68 35.23L86.64 35.20Q85.63 35.25 82.97 35.41ZM89.02 37.69L88.90 37.57L88.91 37.58Q92.42 37.74 94.32 36.63L94.42 36.73L94.25 36.56Q95.32 35.11 95.32 33.02L95.31 33.02L95.40 33.11Q95.30 29.92 94.35 25.81L94.28 25.74L94.46 25.92Q93.88 23.97 92.66 22.56L92.82 22.72L92.71 22.65L92.56 22.42L92.28 22.30L92.20 22.22Q91.83 21.43 91.19 20.75L91.35 20.91L91.22 20.82L91.31 20.91Q89.84 19.28 86.14 19.28L86.00 19.14L85.76 19.17L85.83 19.24Q85.84 18.60 86.03 17.49L86.13 17.59L86.00 17.46Q91.13 17.72 95.17 16.08L94.99 15.91L95.07 15.99Q95.56 14.65 96.52 11.84L96.40 11.72L94.39 12.75L94.31 12.68Q94.72 11.56 95.21 10.42L95.25 10.46L95.32 10.53Q91.40 11.89 87.28 11.97L87.32 12.00L87.31 11.99Q83.13 12.04 79.17 10.94L79.15 10.92L79.26 11.02Q79.86 15.36 79.86 19.77L79.92 19.83L79.82 19.73Q79.99 21.81 79.88 23.71L79.71 23.54L79.80 23.63Q80.08 23.83 80.65 24.14L80.56 24.05L80.71 24.20Q80.99 23.91 81.63 23.57L81.63 23.56L81.53 23.47Q81.56 24.29 81.33 25.82L81.29 25.77L81.28 25.76Q81.76 26.02 82.18 26.24L82.09 26.16L82.21 26.27Q85.03 24.57 86.90 24.57L86.85 24.51L86.86 24.53Q88.09 24.43 89.27 25.07L89.43 25.24L89.28 25.09Q89.62 26.11 89.66 27.06L89.78 27.19L89.70 27.10Q89.87 29.78 88.84 30.89L88.68 30.73L88.75 30.79Q87.42 32.05 85.17 32.28L85.21 32.32L85.20 32.31Q84.18 32.31 83.49 32.24L83.60 32.35L83.44 32.18Q82.64 32.10 81.87 31.76L81.89 31.77L81.86 31.56L81.72 31.65L81.77 31.70Q80.93 31.16 80.40 29.83L80.37 29.80L80.40 29.83Q79.06 31.23 77.38 33.36L77.45 33.42L77.36 33.34Q77.72 34.04 78.56 35.00L78.50 34.93L78.55 34.99Q79.63 36.82 82.44 37.32L82.51 37.38L82.43 37.30Q83.68 37.60 89.04 37.71Z'/%3e%3cpath d='M4 18 C58 3%2c61 9%2c109 8' stroke='%23333' fill='none'/%3e%3cpath fill='%23111' d='M30.46 22.21L30.51 22.27L30.43 22.18Q31.30 22.25 32.71 22.10L32.70 22.10L32.66 22.06Q32.65 22.73 32.65 23.38L32.52 23.25L32.67 24.66L32.68 24.66Q31.70 24.52 30.86 24.59L30.88 24.62L30.87 24.60Q30.15 24.76 29.31 24.72L29.25 24.66L29.26 24.67Q26.30 30.74 22.88 35.34L22.90 35.37L22.91 35.37Q20.42 36.04 19.12 36.65L19.14 36.67L19.23 36.76Q23.24 30.95 26.28 24.66L26.35 24.73L23.60 24.61L23.63 24.63Q23.70 23.37 23.59 22.04L23.50 21.96L23.53 21.99Q25.53 22.23 27.58 22.23L27.56 22.21L29.42 18.48L29.45 18.50Q30.50 16.66 31.72 15.06L31.58 14.92L31.60 14.95Q30.05 15.11 28.45 15.11L28.39 15.05L28.47 15.13Q22.41 15.16 18.64 12.95L18.68 12.98L18.02 11.26L18.03 11.28Q17.66 10.41 17.28 9.54L17.30 9.55L17.16 9.41Q21.61 12.15 27.32 12.37L27.25 12.31L27.39 12.45Q32.40 12.54 37.54 10.56L37.59 10.61L37.50 10.53Q37.37 11.00 36.87 11.88L36.92 11.93L36.97 11.98Q33.35 16.73 30.49 22.25ZM38.41 13.19L38.49 13.27L39.51 11.28L39.50 11.27Q38.56 11.77 36.88 12.50L36.85 12.46L37.09 12.21L36.94 12.06Q37.22 12.07 37.33 11.96L37.25 11.88L37.25 11.87Q37.70 11.25 38.42 9.92L38.39 9.89L38.46 9.97Q33.00 12.12 27.25 11.89L27.30 11.93L27.27 11.90Q21.32 11.70 16.56 8.73L16.49 8.66L16.45 8.62Q17.46 10.47 18.29 13.13L18.40 13.24L18.47 13.31Q19.41 13.79 20.21 14.10L20.21 14.10L20.33 14.21Q20.40 14.48 20.86 16.34L20.98 16.46L20.83 16.32Q24.04 17.63 29.56 17.48L29.60 17.51L29.65 17.56Q29.29 18.08 27.31 21.85L27.33 21.86L27.36 21.89Q25.24 21.83 23.26 21.64L23.34 21.72L23.30 21.68Q23.34 22.48 23.34 23.36L23.32 23.33L23.27 25.00L24.94 25.00L25.03 26.49L25.08 26.54Q21.00 33.77 18.22 37.35L18.22 37.35L18.34 37.47Q19.83 36.60 21.47 36.11L21.47 36.11L21.53 36.16Q20.92 37.16 19.55 38.87L19.45 38.77L19.55 38.87Q22.72 37.77 25.15 37.54L25.05 37.44L25.05 37.44Q28.04 33.73 31.16 26.95L31.15 26.94L34.54 27.10L34.56 27.12Q34.52 26.24 34.52 25.33L34.45 25.26L34.54 23.55L34.39 23.40Q34.17 23.46 33.62 23.49L33.66 23.53L33.66 23.53Q33.05 23.51 32.78 23.51L32.85 23.58L32.85 23.58Q32.83 23.45 32.87 23.29L32.94 23.36L32.89 23.05L32.87 23.03Q35.32 17.82 38.40 13.18Z'/%3e%3cpath fill='%23333' d='M57.54 34.48L57.45 34.38L57.53 34.46Q56.94 34.52 56.25 34.55L56.11 34.42L56.23 34.54Q55.47 34.57 54.78 34.57L54.79 34.57L54.83 34.61Q55.20 31.10 55.20 27.68L55.22 27.70L55.24 27.72Q53.36 27.71 52.45 27.71L52.39 27.64L52.54 27.80Q51.66 27.75 49.83 27.68L49.83 27.67L49.85 27.69Q49.88 27.43 49.69 24.95L49.65 24.91L49.58 24.84Q52.26 25.50 55.23 25.50L55.08 25.35L55.16 25.43Q54.82 20.94 54.40 18.35L54.46 18.41L54.43 18.38Q55.25 18.51 56.05 18.51L56.02 18.49L57.79 18.62L57.65 18.48Q57.53 22.85 57.53 25.44L57.41 25.32L57.50 25.41Q59.76 25.50 62.96 25.15L62.85 25.05L62.92 25.12Q62.67 26.31 62.67 27.53L62.82 27.68L62.65 27.52Q62.49 27.63 61.70 27.66L61.67 27.63L61.76 27.73Q60.65 27.60 60.04 27.64L60.15 27.76L60.09 27.70Q60.17 27.77 57.50 27.77L57.32 27.59L57.34 31.03L57.47 31.17Q57.48 32.82 57.60 34.53ZM63.33 24.62L63.21 24.50L63.23 24.52Q61.44 24.93 59.57 25.01L59.45 24.88L59.58 25.02Q59.85 21.90 60.27 20.04L60.19 19.95L60.24 20.00Q59.39 19.91 57.98 20.06L58.17 20.25L58.33 18.16L58.34 18.18Q55.66 18.13 53.99 18.01L53.89 17.91L53.97 17.99Q54.63 21.21 54.82 25.09L54.70 24.97L54.75 25.02Q53.00 24.98 49.30 24.37L49.15 24.22L49.29 24.36Q49.50 25.48 49.50 28.11L49.60 28.20L51.09 28.17L50.95 28.03Q50.99 28.80 50.84 30.21L50.85 30.22L54.77 29.91L54.81 29.95Q54.68 33.22 54.38 35.04L54.24 34.91L54.26 34.93Q55.08 34.98 56.49 34.87L56.50 34.88L56.54 34.92Q56.49 35.55 56.45 36.89L56.50 36.93L56.38 36.81Q56.89 36.79 60.50 36.94L60.53 36.97L60.49 36.93Q59.63 33.90 59.40 29.94L59.34 29.88L59.42 29.96Q62.81 30.11 64.90 30.49L64.80 30.39L64.90 30.49Q64.74 29.57 64.74 28.62L64.75 28.63L64.56 26.53L64.72 26.70Q64.47 26.67 63.94 26.71L63.95 26.72L63.05 26.62L63.11 26.68Q63.17 25.94 63.29 24.57Z'/%3e%3c/svg%3e";
    String svgData = svgString.replaceFirst("data:image/svg+xml,", "");
    setState(() {
      decodedSvg = Uri.decodeComponent(svgData);
    });
    Permission.notification.request().then((status) async {
      bool hasNotificationPermission = await Permission.notification.isGranted;
      if (hasNotificationPermission) {
        //await Global.startTPNS();
        await GlobalNotify.getToken();
        await PushRequest.deviceRegistration();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(Env.envConfig.appTitle),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CommonButton('支付', () {
                Get.to(const Third());
              }),
              const SizedBox(
                height: 10,
              ),
              CommonButton('地圖', () {
                Get.to(() => const MapPicker());
              }),
              const SizedBox(
                height: 10,
              ),
              CommonButton('list', () {
                var navStack = CustomNavigatorObserver.navStack;
                var routeSettings = navStack.isEmpty ? null : navStack.last;
                print(routeSettings);

                Get.to(ListA(
                  title: "s",
                ));
              }),
              const SizedBox(
                height: 10,
              ),
              CommonButton('slider', () {
                Navigator.of(context).pushNamed('login');
              }),
              const SizedBox(
                height: 10,
              ),
              CommonButton('呼叫', () async {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: '+853-2893-9506',
                );
                await launchUrl(launchUri);
              }),
              Text('$res'),
              Obx(() => Text('$res')),
              SvgPicture.string(decodedSvg),
              CommonButton(
                  '改变主题',
                  () => Get.changeTheme(
                      Get.isDarkMode ? ThemeData.light() : ThemeData.dark())),
              CommonButton('改变主题', () => UpLoadImage.uploadImage(type: 0)),
              CommonButton('綁定設備', () {
                //test();
                final pair = generateRSAkeyPair(exampleSecureRandom());
                RSAPublicKey public = pair.publicKey;
                RSAPrivateKey private = pair.privateKey;
                // Uint8List data =
                //     Uint8List.fromList(utf8.encode('0SjPDZ7TomsF-JNBCEg5S'));
                // Uint8List res = rsaSign(private, data);
                // print(rsaVerify(public, data, res));
                print(encodeRSAPublicKeyToPem(public));
                String base64String = "0SjPDZ7TomsF-JNBCEg5S";
                String base64Encoded = base64.encode(utf8.encode(base64String));
                Uint8List data = base64.decode(base64Encoded);

                Uint8List res = rsaSign(private, data);
                print(res);
                print(data);
                print(rsaVerify(public, data, res));
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          res = res + 1;
          // print(await Payment.checkPayConfig(channel: 'wxpay'));
          // print(Global.pos.value);
          // ToastInfo.toastInfo(
          //     msg: Global.pos.value?.latitude.toString() ?? 'error');
          // Debug.printMsg('1', StackTrace.current);
          Permission.notification.request().then((status) async {
            bool hasNotificationPermission =
                await Permission.notification.isGranted;
            if (hasNotificationPermission) {
              //await Global.startTPNS();
              PushRequest.getSn();
            }
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  api.AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> generateRSAkeyPair(
      api.SecureRandom secureRandom,
      {int bitLength = 2048}) {
    // Create an RSA key generator and initialize it

    // final keyGen = KeyGenerator('RSA'); // Get using registry
    final keyGen = RSAKeyGenerator();

    keyGen.init(api.ParametersWithRandom(
        RSAKeyGeneratorParameters(BigInt.parse('65537'), bitLength, 64),
        secureRandom));

    // Use the generator

    final pair = keyGen.generateKeyPair();

    // Cast the generated key pair into the RSA key types

    final myPublic = pair.publicKey as RSAPublicKey;
    final myPrivate = pair.privateKey as RSAPrivateKey;

    return api.AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(
        myPublic, myPrivate);
  }

  api.SecureRandom exampleSecureRandom() {
    final secureRandom = api.SecureRandom('Fortuna')
      ..seed(api.KeyParameter(
          ab.Platform.instance.platformEntropySource().getBytes(32)));
    return secureRandom;
  }

  Uint8List rsaSign(RSAPrivateKey privateKey, Uint8List dataToSign) {
    //final signer = Signer('SHA-256/RSA'); // Get using registry
    final signer = RSASigner(SHA256Digest(), '0609608648016503040201');

    // initialize with true, which means sign
    signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));

    final sig = signer.generateSignature(dataToSign);

    return sig.bytes;
  }

  bool rsaVerify(
      RSAPublicKey publicKey, Uint8List signedData, Uint8List signature) {
    //final signer = Signer('SHA-256/RSA'); // Get using registry
    final sig = RSASignature(signature);

    final verifier = RSASigner(SHA256Digest(), '0609608648016503040201');

    // initialize with false, which means verify
    verifier.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));

    try {
      return verifier.verifySignature(signedData, sig);
    } on ArgumentError {
      return false; // for Pointy Castle 1.0.2 when signature has been modified
    }
  }

  static String encodeRSAPublicKeyToPem(RSAPublicKey publicKey) {
    List<String> chunk(String s, int chunkSize) {
      var chunked = <String>[];
      for (var i = 0; i < s.length; i += chunkSize) {
        var end = (i + chunkSize < s.length) ? i + chunkSize : s.length;
        chunked.add(s.substring(i, end));
      }
      return chunked;
    }

    var algorithmSeq = ASN1Sequence();
    var paramsAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]));
    algorithmSeq.add(ASN1ObjectIdentifier.fromName('rsaEncryption'));
    algorithmSeq.add(paramsAsn1Obj);

    var publicKeySeq = ASN1Sequence();
    publicKeySeq.add(ASN1Integer(publicKey.modulus));
    publicKeySeq.add(ASN1Integer(publicKey.exponent));
    var publicKeySeqBitString =
        ASN1BitString(stringValues: Uint8List.fromList(publicKeySeq.encode()));

    var topLevelSeq = ASN1Sequence();
    topLevelSeq.add(algorithmSeq);
    topLevelSeq.add(publicKeySeqBitString);
    var dataBase64 = base64.encode(topLevelSeq.encode());
    var chunks = chunk(dataBase64, 64);

    return '${chunks.join('\n')}';
  }
}
