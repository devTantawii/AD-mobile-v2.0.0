import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../language/locale.dart';

class TileTimeBooking extends StatelessWidget {
  const TileTimeBooking(
      {Key? key,
        required this.location,

        required this.time,
        this.time2,
        required this.date,
        this.date2,
        required this.type,}): super(key: key);
  final String type;
  final String location;
  final dynamic time;
  final dynamic time2;
  final dynamic date;
  final dynamic date2;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Icon(Icons.location_on_outlined,size: 15.sp,color: Theme.of(context).colorScheme.primary,),
              Expanded(
                  child: Row(
                    children: [
                      Text(location),
                    ],
                  )),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time_outlined,size: 15.sp,color: Theme.of(context).colorScheme.primary,),
              SizedBox(width: size.width * 0.20, child: Text(local!.selectLocation)),
              Expanded(child: Row(
                children: [
                  Text(time),
                  Text(' - '),
                  Text(time2),
                ],
              )),
            ],
          ),
          Row(
            children: [
              Icon(Icons.date_range,size: 15.sp,color: Theme.of(context).colorScheme.primary,),
              SizedBox(width: size.width * 0.20, child: Text(local.isDirectionRTL(context)?'التاريخ':'Date')),
              Expanded(child: Row(
                children: [
                  Text(date),
                  Text(' - '),
                  Text(date2),
                ],
              )),
            ],
          ),
          SizedBox(height: 10.sp,),
        ],
      ),
    );
  }
}
