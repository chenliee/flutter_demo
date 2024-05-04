import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/api.dart' as pointy;
import 'package:pointycastle/asn1/primitives/asn1_integer.dart';
import 'package:pointycastle/asn1/primitives/asn1_sequence.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/key_generators/api.dart' as pointy;
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/pointycastle.dart' as pointy;
import 'package:pointycastle/signers/rsa_signer.dart';
import 'package:pointycastle/src/platform_check/platform_check.dart';

AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> generateRSAKeyPair(
    pointy.SecureRandom secureRandom) {
  final keyGen = RSAKeyGenerator()
    ..init(pointy.ParametersWithRandom(
        pointy.RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 64),
        secureRandom));
  final pair = keyGen.generateKeyPair();
  final myPublic = pair.publicKey as RSAPublicKey;
  final myPrivate = pair.privateKey as RSAPrivateKey;

  return AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(myPublic, myPrivate);
}

String rsaSign(RSAPrivateKey privateKey, String data) {
  final signer = RSASigner(SHA256Digest(), '0609608648016503040201');

  signer.init(
    true,
    PrivateKeyParameter<RSAPrivateKey>(privateKey),
  );

  final sig = signer.generateSignature(Uint8List.fromList(utf8.encode(data)));

  return base64.encode(sig.bytes);
}

bool rsaVerify(RSAPublicKey publicKey, String data, String signature) {
  final verifier = RSASigner(SHA256Digest(), '0609608648016503040201');

  verifier.init(
    false,
    PublicKeyParameter<RSAPublicKey>(publicKey),
  );

  final sig = RSASignature(Uint8List.fromList(base64.decode(signature)));

  try {
    return verifier.verifySignature(Uint8List.fromList(utf8.encode(data)), sig);
  } on ArgumentError {
    return false; // for Pointy Castle 1.0.2 when signature has been modified
  }
}

Uint8List? encodePublicKeyToPem(RSAPublicKey publicKey) {
  var topLevel = ASN1Sequence()
    ..add(ASN1Integer(publicKey.modulus))
    ..add(ASN1Integer(publicKey.publicExponent))
    ..add(ASN1Integer(publicKey.n))
    ..add(ASN1Integer(publicKey.e))
    ..add(ASN1Integer(publicKey.exponent));
  return topLevel.encodedBytes;
}

Uint8List? encodePrivateKeyToPem(RSAPrivateKey privateKey) {
  var topLevel = ASN1Sequence()
    ..add(ASN1Integer(privateKey.modulus))
    ..add(ASN1Integer(privateKey.privateExponent))
    ..add(ASN1Integer(privateKey.exponent))
    ..add(ASN1Integer(privateKey.q))
    ..add(ASN1Integer(privateKey.p));
  return topLevel.encodedBytes;
}

void test() {
  // 生成RSA密钥对
  final secureRandom = SecureRandom('Fortuna')
    ..seed(
      KeyParameter(Platform.instance.platformEntropySource().getBytes(32)),
    );
  final keyPair = generateRSAKeyPair(secureRandom);
  final public = keyPair.publicKey;
  print(public);
  final private = keyPair.privateKey;
  print(private);
  var pem = '-----BEGIN RSA PUBLIC KEY-----\n' +
      base64Encode(encodePublicKeyToPem(public)!.toList()) +
      '\n-----END RSA PUBLIC KEY-----';
  // 待签名的数据
  print(pem);
  String dataToSign = "0SjPDZ7TomsF-JNBCEg5S";

  // 进行签名
  String signature = rsaSign(
    private,
    dataToSign,
  );
  print("Signature: $signature");

  // 验证签名
  bool isSignatureValid = rsaVerify(public, dataToSign, signature);
  print("Is Signature Valid: $isSignatureValid");
}
