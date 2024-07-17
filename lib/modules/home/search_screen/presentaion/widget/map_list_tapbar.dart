import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/shared/style/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapListTapBar extends StatelessWidget {
  final TabController controller;
  final ValueChanged<bool> isMap;

  MapListTapBar({Key? key, required this.controller, required this.isMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Container(
      color: Color(0xffCAD3F3),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        onTap: (index) {
          controller.animateTo(index);
          isMap(index == 0);
        },
        key: key,
        controller: controller,
        indicatorColor: Colors.white,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft:Radius.circular(6),
              bottomLeft:Radius.circular(6),
              topRight:Radius.circular(6),
              bottomRight:Radius.circular(6)
          ),
          color: kPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        tabs: [
          Tab(
              icon: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        child: AutoSizeText(
                          locale!.listView.toString(),
                          style: TextStyle(fontWeight: FontWeight.w700,fontFamily: 'Cairo',
                            fontSize: 16.sp,),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Tab(
            icon: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                        locale.mapView.toString(),
                        style: TextStyle(fontWeight: FontWeight.w700,fontFamily: 'Cairo',fontSize: 16.sp,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
