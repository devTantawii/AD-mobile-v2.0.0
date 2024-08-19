import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion/motion.dart';
import '../../../shared/commponents.dart';
import '../../home/search_screen/blocs/search_bloc/search_cubit.dart';
import '../../home/search_screen/presentaion/widget/region_tile.dart';
class CurveWidget extends StatelessWidget {
   CurveWidget({Key? key,required this.isHome,required this.forgetPasswordScreen,required this.subTitle,required this.title,required this.positionBottom,required this.positionTop,required this.subtitleStyle,required this.titleStyle}) : super(key: key);
  String  title;
  String subTitle;
  dynamic positionTop;
  dynamic positionBottom;
  bool isHome;
  bool forgetPasswordScreen;
  TextStyle titleStyle;
  TextStyle subtitleStyle;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Theme.of(context).brightness==Brightness.light? Image.asset(
          "assets/images/layImage.png",
          fit: BoxFit.cover,
          width: size.width,
        ):Image.asset(
          "assets/images/layImageDark.png",
          fit: BoxFit.cover,
          width: size.width,
        ),
        isHome?Positioned(top:10,left:size.width/2.6,child: RegionTile(regions: context.read<SearchCubit>().regionsData)):Container(),
        forgetPasswordScreen?Positioned(
           top: size.height*0.05,
           child:  Row(
          children: [
            Motion(
              child: Bounce(
                onTap: () {Navigator.of(context).pop();},
                child: Container(
                  padding: EdgeInsets.only(
                      left: locale.isDirectionRTL(context) ? 0 : 10,
                      right: locale.isDirectionRTL(context) ? 10 : 0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                    color: Color(0xffFDFDFD),
                  ),
                ),
              ),
            ),
            Text(locale.back.toString(),style: defaultTextStyle(14, FontWeight.w600,  Color(0xffFDFDFD)),)],
        )):Container(),
        SizedBox(height: size.height*0.02,),
        Positioned(
            // top: size.height*0.1,
            top: positionTop,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: size.width*0.03),
              child: Text(title,style: titleStyle,),
            )
        ),
        Positioned(
            top: positionBottom,
            // top: size.height*0.16,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: size.width*0.03),
              child: Text(
                subTitle.toString(),
                style: subtitleStyle,
                overflow: TextOverflow.ellipsis,
              ),
            )
        ),
      ],
    );
  }
}
