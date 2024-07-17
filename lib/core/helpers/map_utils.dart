import 'dart:ui' as ui;

import 'package:abudiyab/core/constants/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String googleMapApiKey = 'AIzaSyC4xQ0n-BwL_gODzdOTI6eqmzABT7XtF9Y';
List<BitmapDescriptor> markerss = [];
String? mapStyle;
List<String> stops = [
  'Old Sawmill',
  'Seveehill Dr',
  'Trep Road',
  'Old Sawmill',
  'Seveehill Dr',
];

final CameraPosition kGooglePlex = CameraPosition(
  target: LatLng(23.8859, 45.0792),
  zoom: 4,
);

class MapUtils {
  static getMarkerPic() async {

    markerss.add(await createBitmapDescriptorFromImage(Assets.mark, '',));

  }

  static Future<BitmapDescriptor> createBitmapDescriptorFromImage(
      String imagee, String alphabet) async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas c = Canvas(recorder);

    double imageWidth = 120;
    double imageHeight = 120;

    // AssetBundle bundle = DefaultAssetBundle.of(context);
    ui.Image myImage = await load(imagee);
    /*await Util.getUiImage(bundle, "assets/images/image.png", imageWidth, imageHeight)*/

    paintImage(
        canvas: c, // c is the Canvas object in above code examples.
        image: myImage,
        rect: Rect.fromLTWH(0, 0, imageWidth, imageHeight * 1.1));

    TextPainter textPainter = TextPainter(
        text: TextSpan(
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.w600,
            ),
            text: alphabet),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    textPainter.layout();

    textPainter.paint(c, Offset(20, 6));

    final picture = recorder.endRecording();
    final image = await picture.toImage(110, 110);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  static Future<ui.Image> load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}
