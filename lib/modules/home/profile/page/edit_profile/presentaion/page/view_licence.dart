import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../../language/locale.dart';
import '../../../../../../widgets/components/ad_back_button.dart';

class WebViewLicence extends StatefulWidget {
  const WebViewLicence({
    Key? key,
    required this.licenceImage
  }) : super(key: key);
  final String  licenceImage;
  @override
  State<WebViewLicence> createState() => WebViewLicenceState();
}

class WebViewLicenceState extends State<WebViewLicence> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
     backgroundColor: Colors.white,
      appBar:  AppBar(
        title: Text(
            locale.viewLicense.toString(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        leading: ADBackButton(),
      ),
      body: Center(
        child:  WebView(
          initialUrl:widget.licenceImage.toString(),
        ),
      ),
    );
  }
  customWebView(url,BuildContext context){
    return WebView(
      initialUrl: url,
    );
  }
}