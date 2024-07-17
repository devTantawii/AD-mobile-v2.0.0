import 'package:abudiyab/modules/widgets/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewLocation extends StatefulWidget {
  const ViewLocation({Key? key, required this.url, required this.title})
      : super(key: key);
  final String? url;
  final String title;
  @override
  State<ViewLocation> createState() => _ViewLocationState();
}

class _ViewLocationState extends State<ViewLocation> {
  int loading = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, widget.title),
      body: SafeArea(
        child: widget.url != null
            ? Stack(
                children: [
                  WebView(
                    // zoomEnabled: true,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: widget.url,
                    onProgress: (value) {
                      print(value);
                      setState(() {
                        loading = value;
                      });
                    },
                  ),
                  Visibility(
                    visible: loading == 100 ? false : true,
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.blue),
                          value: loading.toDouble() / 100,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
