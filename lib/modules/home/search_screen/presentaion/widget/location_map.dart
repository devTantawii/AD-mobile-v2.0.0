import 'package:abudiyab/core/helpers/map_utils.dart';
import 'package:abudiyab/core/helpers/theme_handler.dart';
import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/areas_model.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/pin_information.dart';
import 'package:abudiyab/modules/home/search_screen/presentaion/widget/pin_pill_position_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../all_branching/bloc/all_branching_cubit.dart';

class LocationMap extends StatefulWidget {
  final List<BranchModel>? branches;
  final List<AreasModel>? areas;
  final bool isReceive;
  final bool isPolygon;
  final bool isMarker;
  final bool isCircle;

  LocationMap({
    Key? key,
    this.branches,
    this.areas,
    required this.isReceive,
    this.isMarker = false,
    this.isCircle = false,
    this.isPolygon = false,
  })  : assert((isMarker == true) ^ (isCircle == true) ^ (isPolygon == true),
            "Select one location type of the map"),
        super(key: key);

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> with WidgetsBindingObserver {
  late final markIcon;
  late GoogleMapController mapController;
  Set<Marker> markers = Set();
  Set<Polygon> polygons = Set();
  Set<Circle> circles = Set();

  CameraPosition _myLocation = CameraPosition(
    target: LatLng(24.774265, 46.738586),
    zoom: 5,
    bearing: 15.0,
    tilt: 75.0,
  );

  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
    avatarPath: 'assets/images/driving_pin.png',
    location: LatLng(0, 0),
    locationName: '',
    labelColor: Colors.grey,
  );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // log("state : $state");
    // if (state  ==AppLifecycleState.resumed ) {
    //   mapController.setMapStyle("[]");
    // }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    MapUtils.getMarkerPic();
    rootBundle
        .loadString(ThemeHandler().isDark()
            ? 'assets/images/map_style.txt'
            : 'assets/images/map_style_light.txt')
        .then((string) => mapStyle = string);

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  initMap() => _myLocation = CameraPosition(
        target: widget.isMarker
            ? LatLng(double.parse(widget.branches!.first.lat!),
                double.parse(widget.branches!.first.long!))
            : LatLng(
                double.parse(context
                    .read<SearchCubit>()
                    .areasData!
                    .first
                    .lat
                    .toString()),
                double.parse(context
                    .read<SearchCubit>()
                    .areasData!
                    .first
                    .long
                    .toString())),
        zoom: 10,
        bearing: 15.0,
        tilt: 75.0,
      );

  onMarkerPinClicked(BuildContext context, BranchModel branch) {
    widget.isReceive
        ? BlocProvider.of<SearchCubit>(context).selectedReceiveBranch =
            branch.name
        : BlocProvider.of<SearchCubit>(context).selectedDriveBranch =
            branch.name;
    BlocProvider.of<SearchCubit>(context).selectedReceiveModel =
        BlocProvider.of<SearchCubit>(context)
            .branchesData
            .where((element) => element.name == branch.name)
            .first;
    BlocProvider.of<SearchCubit>(context).changeState();
    Navigator.pop(context);
  }

  onMarkerClicked(BuildContext context, BranchModel branch) => setState(() {
        final allDay =
            "${branch.workTime?.alldays?.morning?.timeopen ?? ""}"
            " :${branch.workTime?.alldays?.morning?.timeclose ?? ""} -${branch.workTime?.alldays?.afternone?.timeopen ?? ""} : ${branch.workTime?.alldays?.afternone?.timeclose ?? ""}";
        final friday =
            "${branch.workTime?.fri?.morning?.timeopen ?? ""} "
            ": ${branch.workTime?.fri?.morning?.timeclose ?? ""}";
        currentlySelectedPin = PinInformation(
            onTap: () => onMarkerPinClicked(context, branch),
            location:
                LatLng(double.parse(branch.lat!), double.parse(branch.long!)),
            avatarPath: currentlySelectedPin.avatarPath,
            locationAddress: branch.address,
            locationName: branch.name,
            labelColor: Colors.grey,
            allDayDate: allDay,
            friDate: friday);
        pinPillPosition = 60;
      });

  initMarkers() => /*widget.isReceive?*/markers.addAll([
     ...widget.branches!.map((branch) => Marker(
              icon: markerss.first,
              onTap: () => onMarkerClicked(context, branch),
              markerId: MarkerId(branch.id.toString()),
              position: LatLng(double.parse(branch.lat!), double.parse(branch.long!)),
            ))
      ]);/*:markers.addAll([
    ...context.read<AllBranchCubit>().branchesData.map((branch) => Marker(
      icon: markerss.first,
      onTap: () => onMarkerClicked(context, context.read<AllBranchCubit>().branchesData as BranchModel),
      markerId: MarkerId(context.read<AllBranchCubit>().branchesData.toString()),
      position: LatLng(double.parse(branch.lat!), double.parse(branch.long!)),
    ))
  ]);*/

  onCirclesPinClicked(BuildContext context, AreasModel area) {
    widget.isReceive
        ? BlocProvider.of<SearchCubit>(context).selectedReceiveArea = area.name
        : BlocProvider.of<SearchCubit>(context).selectedDriveArea = area.name;
    widget.isReceive
        ? BlocProvider.of<SearchCubit>(context).selectedAreaReceiveModel =
            BlocProvider.of<SearchCubit>(context)
                .areasData!
                .where((element) => element.name == area.name)
                .first
        : BlocProvider.of<SearchCubit>(context).selectedAreaDriveModel =
            BlocProvider.of<SearchCubit>(context)
                .areasData!
                .where((element) => element.name == area.name)
                .first;

    BlocProvider.of<SearchCubit>(context).changeState();
    Navigator.pop(context);
  }

  onCirclesClicked(BuildContext context, AreasModel area) => setState(() {
        currentlySelectedPin = PinInformation(
          locationName: area.name,
          labelColor: Colors.grey,
          locationAddress: area.name,
          avatarPath: currentlySelectedPin.avatarPath,
          onTap: () => onCirclesPinClicked(context, area),
          location: LatLng(double.parse(area.lat!), double.parse(area.long!)),
        );
        pinPillPosition = 60;
      });

  initCircles() => circles.addAll([
        ...widget.areas!.map((area) => Circle(
              strokeWidth: 3,
              consumeTapEvents: true,
              radius: double.parse(area.radius!),
              circleId: CircleId(area.id.toString()),
              onTap: () => onCirclesClicked(context, area),
              strokeColor: Theme.of(context).colorScheme.primary,
              center: LatLng(double.parse(area.lat!), double.parse(area.long!)),
              fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ))
      ]);

  initPolygons() => polygons.add(Polygon(polygonId: PolygonId("d")));

  onMapCreated(controller) {
    setState(() {
      mapController = controller;
      mapController.setMapStyle(mapStyle);
      if (widget.isPolygon) {
        initPolygons();
      } else if (widget.isCircle) {
        initCircles();
        mapController.animateCamera(CameraUpdate.zoomTo(11));
      } else {
        initMarkers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initMap();
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          circles: circles,
          polygons: polygons,
          compassEnabled: false,
          myLocationEnabled: true,
          mapType: MapType.normal,
          onMapCreated: onMapCreated,
          initialCameraPosition: _myLocation,
          onTap: (position) => setState(() => pinPillPosition = -100),
        ),
        PinPillPositionTile(
          isMarker: widget.isMarker,
          pinPillPosition: pinPillPosition,
          currentlySelectedPin: currentlySelectedPin,
        ),
      ],
    );
  }
}
