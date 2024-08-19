// import 'package:abudiyab/language/locale.dart';
// import 'package:abudiyab/modules/Home/filter_screen/blocs/filter_bloc/search_cubit.dart';
// import 'package:abudiyab/modules/Home/filter_screen/models/regions_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class SelectRegionWidget extends StatefulWidget {
//   const SelectRegionWidget({
//     Key? key,
//     required this.regions,
//     required this.title,
//   }) : super(key: key);
//   final List<RegionModel>? regions;
//   final String title;
//
//   @override
//   State<SelectRegionWidget> createState() => _SelectRegionWidgetState();
// }
//
// class _SelectRegionWidgetState extends State<SelectRegionWidget> {
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     return DropdownButtonFormField(
//       dropdownColor: Theme.of(context).backgroundColor,
//       hint: Text(locale.selectRegion!,
//           style: Theme.of(context).textTheme.bodyMedium),
//       style: Theme.of(context).textTheme.bodyLarge!,
//       items: widget.regions!.isNotEmpty
//           ? widget.regions!.map((value) {
//               return DropdownMenuItem(
//                 value: value.name.toString(),
//                 child: Container(child: Text(value.name.toString())),
//               );
//             }).toList()
//           : ["Select Region"].map((value) {
//               return DropdownMenuItem(
//                 value: value,
//                 child: Container(child: Text(value)),
//               );
//             }).toList(),
//       onChanged: (dynamic newValue) {
//         setState(() => BlocProvider.of<SearchCubit>(context).selectedRegion = newValue);
//         final selectedRegionModel = BlocProvider.of<SearchCubit>(context).regionsData?.where((element) =>
//         element.name == BlocProvider.of<SearchCubit>(context).selectedRegion).first;
//         BlocProvider.of<SearchCubit>(context).selectedReceiveBranch = null;
//         BlocProvider.of<SearchCubit>(context).selectedDriveBranch = null;
//         BlocProvider.of<SearchCubit>(context).getBranches(regionId:selectedRegionModel?.id);
//       },
//       value: BlocProvider.of<SearchCubit>(context).selectedRegion,
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
//         prefixIcon: Icon(Icons.location_on_outlined,
//             color: Theme.of(context).colorScheme.primary),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide:
//                 BorderSide(color: Theme.of(context).colorScheme.primary)),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide:
//                 BorderSide(color: Theme.of(context).colorScheme.primary)),
//       ),
//     );
//   }
// }
