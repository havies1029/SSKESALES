import 'package:esalesapp/blocs/progressindicator/progressindicator_bloc.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularPercentIndicatorWidget extends StatefulWidget {
  final double radius;
  final double lineWidth;
  final Color backgroundColor;
  final Color progressColor;
  const CircularPercentIndicatorWidget(
    {super.key,
      required this.radius,
      required this.lineWidth,
      required this.backgroundColor,
      required this.progressColor});

  @override
  CircularPercentIndicatorWidgetState createState() => CircularPercentIndicatorWidgetState();
}

class CircularPercentIndicatorWidgetState extends State<CircularPercentIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgressIndicatorBloc, ProgressIndicatorState>(
        builder: (context, state) {

          return state.downloading
              ? SafeArea(
                  child: CircularPercentIndicator(
                  animation: true,                     
                  animationDuration: 2500,
                  radius: widget.radius,
                  lineWidth: widget.lineWidth,
                  percent: state.progressPercent,
                  center: Text("${state.progressPercent * 100}%",
                      style: MyText.bodySmall(context)!
                          .copyWith(color: MyColors.grey_80)),
                  backgroundColor: widget.backgroundColor,
                  progressColor: widget.progressColor,
                ))
              : Container();
        },
        buildWhen: (previous, current) {

          return (current.downloading || current.downloaded);
        },
        listener: (context, state) {});
  }
}
