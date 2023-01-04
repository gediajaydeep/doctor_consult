import 'package:consultations_app_test/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DescriptionText extends StatefulWidget {
  final String text;

  const DescriptionText({super.key, required this.text});

  @override
  createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  late String firstHalf;
  String secondHalf = '';

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  flag ? ("$firstHalf...") : (firstHalf + secondHalf),
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.left,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "Read More" : "Read less",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: AppTheme.appThemeSwatch.shade500),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
