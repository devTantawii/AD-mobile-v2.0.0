import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/constants/privacy_policy.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/profile/page/widget/container_tile.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale!.privacyPolicy.toString(),
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
              ),
        ),
        leading: ADBackButton(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ContainerTileWidget(
          widgets: [
            Text(
              langCode == "en" ? PRIVECYTITLEEN : PRIVECYTITLEAR,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                langCode == "en" ? PrivacyEn : PrivacyAr,
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
