import 'package:abudiyab/modules/home/category/data/models/category_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({Key? key, required this.data}) : super(key: key);
  final Data data;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool onclik = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        setState(() {
          onclik = !onclik;
        });
      },
      child: Container(
        // padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
        // width: MediaQuery.of(context).size.width * 0.25,
        // height: 50,
        decoration: BoxDecoration(
          gradient: onclik
              ? LinearGradient(colors: [
                  Color(0xff6e9ed3),
                  Color(0xff344CB7),
                ])
              : LinearGradient(colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor,
                ]),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Color(0xff6e9ed3).withOpacity(0.5),
              blurRadius: 0,
              offset: const Offset(1, 2),
            ),
            BoxShadow(
              color: Color(0xff344CB7).withOpacity(0.5),
              blurRadius: 0,
              offset: const Offset(-1, -2),
            ),
          ],
        ),
        child: Center(
            child: FittedBox(
          child: AutoSizeText(
            widget.data.name.toString(),
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
                color: onclik ? Colors.white : null),
          ),
        )),
      ),
    );
  }
}
