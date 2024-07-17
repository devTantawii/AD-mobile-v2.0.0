import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/booking_from_cars/model/branch_from_cars_model.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:abudiyab/modules/widgets/components/custom_rect_tween.dart';
import 'package:abudiyab/modules/widgets/components/hero_dialog_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchTile extends StatefulWidget {
  final List<Datum>? regions;
  final bool isRecieve;

  const BranchTile({Key? key, required this.regions, required this.isRecieve}) : super(key: key);

  @override
  State<BranchTile> createState() => _BranchTileState();
}

class _BranchTileState extends State<BranchTile> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return _PopupCard(
            branches: widget.regions,
            isRecieve: widget.isRecieve,
            onChanged: (v) {
              setState(() {});
            },
          );
        }));
      },
      child: Hero(
        tag: widget.isRecieve.toString() + _heroTag,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: AlignmentDirectional.bottomStart,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        color: Theme.of(context).colorScheme.primary),
                    Text(
                        widget.isRecieve
                            ? BlocProvider.of<SearchCubit>(context)
                                    .selectedReceiveBranch ??
                                locale!.selectBranch.toString()
                            : BlocProvider.of<SearchCubit>(context)
                                    .selectedDriveBranch ??
                                locale!.selectBranch.toString(),
                        style: Theme.of(context).textTheme.bodyMedium)
                  ],
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const String _heroTag = 'Hero-Tag';

class _PopupCard extends StatefulWidget {
  final List<Datum>? branches;
  final bool isRecieve;
  final ValueChanged<void> onChanged;

  const _PopupCard(
      {Key? key,
      required this.branches,
      required this.isRecieve,
      required this.onChanged})
      : super(key: key);

  @override
  State<_PopupCard> createState() => _PopupCardState();
}

class _PopupCardState extends State<_PopupCard> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: widget.isRecieve.toString() + _heroTag,
          createRectTween: (begin, end) =>
              CustomRectTween(begin: begin!, end: end!),
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: widget.branches!.isEmpty
                    ? Text(
                        locale!.carNotAvailable!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...widget.branches!
                              .map(
                                (branch) => SelectionTile(
                                    text: branch.text,
                                    onTap: () {
                                      if (widget.isRecieve) {
                                        BlocProvider.of<SearchCubit>(context)
                                                .selectedReceiveBranch =
                                            branch.text;
                                      } else {
                                        BlocProvider.of<SearchCubit>(context)
                                            .selectedDriveBranch = branch.text;
                                      }
                                      widget.onChanged(true);

                                      Navigator.pop(context);
                                    }),
                              )
                              .toList(),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectionTile extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const SelectionTile({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
          onPressed: onTap,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )),
    );
  }
}
