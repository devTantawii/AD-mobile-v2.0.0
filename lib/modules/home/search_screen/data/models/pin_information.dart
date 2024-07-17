import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinInformation {
  String? avatarPath;
  LatLng? location;
  String? locationName;
  String? locationAddress;
  Color? labelColor;
  String? allDayDate;
  String? friDate;
  VoidCallback? onTap;

  PinInformation({
    this.avatarPath,
    this.location,
    this.locationName,
    this.labelColor,
    this.locationAddress,
    this.allDayDate,
    this.friDate,
    this.onTap,
  });
}
