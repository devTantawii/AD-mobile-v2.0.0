import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ADErrorDialog extends StatelessWidget {
  final String title;
  final String body;

  ADErrorDialog({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.3,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding:  EdgeInsets.only(top: 10.0.sp),
              child: Image.asset(
                'assets/images/man2.png',
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.05,
                fit: BoxFit.fitHeight,
              ),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
          ),
          SizedBox(height: 20.sp),
          FittedBox(
            child: AutoSizeText(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: AutoSizeText(
              body,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: double.infinity,
            alignment: AlignmentDirectional.center,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
              ),
              child: AutoSizeText(
                'ok',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ADStatusDialog extends StatelessWidget {
  final bool status;

  ADStatusDialog({required this.status});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.3,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Image.asset(
                status ? "assets/checked.png" : "assets/wrong.png",
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.05,
                fit: BoxFit.fitHeight,
              ),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
          ),
          Spacer(),

          SizedBox(height: 20),
          FittedBox(
            child: AutoSizeText(
              status ? "Success Payment" : "Failed Payment",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
            ),
          ),
          Spacer(),

          // Container(
          //   height: MediaQuery.of(context).size.height * 0.06,
          //   padding: const EdgeInsets.only(right: 16, left: 16),
          //   child: AutoSizeText(
          //     body,
          //     style: TextStyle(color: Colors.white),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: double.infinity,
            alignment: AlignmentDirectional.center,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                elevation: 2.0, backgroundColor: status ? Colors.green : Colors.red,
                minimumSize: Size(180, 60),
                shape: StadiumBorder(),
                textStyle: TextStyle(color: Colors.white),
                padding: const EdgeInsets.all(5),
              ),
              child: AutoSizeText(
                'ok',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
