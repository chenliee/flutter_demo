import 'package:flutter/material.dart';
import 'package:payment/flutter_payment.dart';

class SendAuthPage extends StatefulWidget {
  const SendAuthPage({Key? key}) : super(key: key);

  @override
  State<SendAuthPage> createState() => _SendAuthPageState();
}

class _SendAuthPageState extends State<SendAuthPage> {
  String? _result = '无';

  @override
  void initState() {
    super.initState();
    Payment.wxLoginStreamController.stream.listen((res) async {
      print(res.code.toString());
      // if (!logging.value) {
      //   logging.add(true);
      //   LoginProvider()
      //       .toWechatLogin(code: res.code!, context: context);
      // }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _result = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Auth')),
      body: Column(
        children: <Widget>[
          OutlinedButton(
            onPressed: () {
              Payment.sendWeChatAuth(
                  scope: 'snsapi_userinfo',
                  state: DateTime.now().microsecondsSinceEpoch.toString());
            },
            child: const Text('send auth'),
          ),
          const Text('响应结果;'),
          Text('$_result')
        ],
      ),
    );
  }
}
