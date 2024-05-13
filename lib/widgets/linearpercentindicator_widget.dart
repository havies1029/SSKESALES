import 'package:esalesapp/blocs/progressindicator/progressindicator_bloc.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LinearPercentIndicatorWidget extends StatefulWidget {
  final String title;
  final double width;
  final double lineHeight;
  final Color backgroundColor;
  final Color progressColor;

  const LinearPercentIndicatorWidget(
      {super.key,
      required this.title,
      required this.width,
      required this.lineHeight,
      required this.backgroundColor,
      required this.progressColor});

  @override
  LinearPercentIndicatorWidgetState createState() =>
      LinearPercentIndicatorWidgetState();
}

class LinearPercentIndicatorWidgetState
    extends State<LinearPercentIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgressIndicatorBloc, ProgressIndicatorState>(
        builder: (context, state) {
          return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${widget.title} : ",
                      style: MyText.bodySmall(context)!
                          .copyWith(color: MyColors.grey_80)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearPercentIndicator(
                      animation: true,                     
                      animationDuration: 2500,
                      barRadius: const Radius.circular(16),
                      width: widget.width,
                      lineHeight: widget.lineHeight,
                      percent: state.progressPercent,
                      center: Text("${state.progressPercent * 100}%",
                          style: MyText.bodySmall(context)!
                              .copyWith(color: MyColors.accentDark)),
                      backgroundColor: widget.backgroundColor,
                      progressColor: widget.progressColor,
                    ),
                  ),
                  Text(state.progressName,
                      style: MyText.bodySmall(context)!
                          .copyWith(color: MyColors.grey_80)),
                ],
          ));
        },
        buildWhen: (previous, current) {
          return (current.downloading || current.downloaded);
        },
        listener: (context, state) {});
  }
}
