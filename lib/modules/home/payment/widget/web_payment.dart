import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/ad_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPayment extends StatefulWidget {
  const WebPayment({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String? url;

  @override
  State<WebPayment> createState() => _WebPaymentState();
}

class _WebPaymentState extends State<WebPayment> {
  int loading = 0;
  bool fresh = false;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale!.continuePaymentProcess,
            style: Theme.of(context).textTheme.titleLarge),
        leading: AdHomeButton(),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          child: widget.url != null
              ? Stack(
                  children: [
                    WebView(
                      initialUrl: widget.url,
                      onPageStarted: (url) {
                        // print("Hammad1" + url.toString());
                        // if (url.contains("payment=success")) {
                        //   // print("Hammad2" + url.toString());
                        //   HelperFunctions.statusDialog(
                        //       context: context, status: true);
                        //   Timer(Duration(seconds: 3), () {
                        //     pushNewScreen(context,
                        //         screen: BookingConfirmed(), withNavBar: true);
                        //   });
                        // } else if (url.contains("payment=failed")) {
                        //   // print("Hammad3" + url.toString());
                        //   HelperFunctions.statusDialog(
                        //       context: context, status: false);
                        // }
                      },
                      javascriptMode: JavascriptMode.unrestricted,
                      onProgress: (value) => setState(() => loading = value),
                    ),
                    Container(),
                    Visibility(
                      visible: loading == 100 ? false : true,
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue),
                            value: loading.toDouble() / 100,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
