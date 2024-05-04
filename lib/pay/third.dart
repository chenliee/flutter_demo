import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:payment/flutter_payment.dart';

class Third extends StatefulWidget {
  const Third({Key? key}) : super(key: key);

  @override
  State<Third> createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  int i = -1;
  String channel = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      appBar: AppBar(
        title: const Text('123'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /*StatefulBuilder(builder: (context, setState) {
                      return PayWidget(
                          payItem: (e, index, length, images) {
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                i = index;
                                channel = e.code!;
                                setState(() {
                                  i = i;
                                  channel = channel;
                                });
                              },
                              child: Card(
                                margin: const EdgeInsets.only(
                                    top: 15, right: 10, left: 10),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 10, top: 5, bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          images(55, 55),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      e.title!,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                RichText(
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(children: [
                                                      // WidgetSpan(
                                                      //     alignment: PlaceholderAlignment.middle,
                                                      //     child: Image.asset('assets/images/macao.png')),
                                                      TextSpan(
                                                          text: e.description,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      13)),
                                                    ])),
                                              ],
                                            ),
                                          ),
                                          i == index
                                              ? const Icon(
                                                  Icons
                                                      .check_circle_outline_rounded,
                                                  color: Color(0xffff7913),
                                                  size: 30,
                                                )
                                              : const Icon(
                                                  Icons.circle_outlined,
                                                  color: Colors.grey,
                                                  size: 30,
                                                ),
                                        ],
                                      ),
                                      // Container(
                                      //   margin: EdgeInsets.only(left: 70.w),
                                      //   child: const Divider(
                                      //     height: 2,
                                      //     thickness: 1,
                                      //   ),
                                      // ),
                                      // Container(
                                      //   margin: EdgeInsets.only(left: 70.w, top: 5.w, bottom: 5.w),
                                      //   child: RichText(
                                      //     text: TextSpan(
                                      //       children: [
                                      //         WidgetSpan(
                                      //           alignment: PlaceholderAlignment.middle,
                                      //           child: Container(
                                      //             color: const Color(0xffF4E4E4),
                                      //             child: const Text(
                                      //               '注',
                                      //               style: TextStyle(color: Colors.red),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         TextSpan(
                                      //           text: e.notice!,
                                      //           style: const TextStyle(color: Colors.grey),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          index: i,
                          selectIndex: (index, ChannelModel c) {
                            i = index;
                            channel = c.code!;
                            setState(() {
                              i = i;
                              channel = channel;
                            });
                          });
                    }),*/
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                DateTime a = DateTime.now().subtract(const Duration(hours: 5));
                String orderAt = exchangeISO(DateTime.now());
                /*Map<String, dynamic>? res = await PaymentResponse.prepare(
                    order: "O20230517172508",
                    orderAt: orderAt,
                    orderAmount: 100,
                    amount: 50,
                    channel: channel,
                    context: context,
                    schema: 'mscholar');
                if (res != null) {
                  print(res);
                  print(res['data']['params']);
                }*/
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.amberAccent, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: const Center(child: Text('確認')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String exchangeISO(DateTime date) {
    var duration = date.timeZoneOffset;
    if (duration.isNegative) {
      return "${DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date)}-${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}";
    } else {
      return "${DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(date)}+${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}";
    }
  }
}
