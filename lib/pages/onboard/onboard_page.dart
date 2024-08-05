import 'package:esalesapp/blocs/onboardmenu/onboardmenucari_bloc.dart';
import 'package:esalesapp/blocs/home/home_bloc.dart';
import 'package:esalesapp/common/common.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/pages/assignment/clientassigncari_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  List<PageViewModel> listPages = [];
  late OnBoardMenuCariBloc onboardMenuCariBloc;
  late double maxWidth;
  late double maxHeight;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    onboardMenuCariBloc = BlocProvider.of<OnBoardMenuCariBloc>(context);
    return LayoutBuilder(builder: (context, constraints) {
      maxWidth = constraints.maxWidth;
      maxHeight = constraints.maxHeight;
      return BlocConsumer<OnBoardMenuCariBloc, OnBoardMenuCariState>(
        builder: (context, state) {
          return listPages.isNotEmpty
              ? IntroductionScreen(
                  key: _introKey,
                  pages: listPages,
                  showNextButton: false,
                  showDoneButton: true,
                  onDone: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(TimelinePolicyExpiredPageActiveEvent());
                  },
                  done: const Text("Done"),
                )
              : const Center(child: LoadingIndicator());
        },
        buildWhen: (previous, current) {
          return (current.status == ListStatus.success);
        },
        listener: (BuildContext context, OnBoardMenuCariState state) {
          if (state.status == ListStatus.success) {
            if (state.item?.clientassignment ?? false) {
              listPages.add(PageViewModel(
                  //title: 'Client Assignment',
                  titleWidget: buildTitleWidget(context, "Client Assignment"),
                  bodyWidget: Column(
                    children: [
                      SizedBox(
                          height: maxHeight,
                          child: const ClientAssignCariMainPage()),
                    ],
                  )));
            }
            /*
            if (state.item?.policyoutstanding ?? false) {
              listPages.add(PageViewModel(
                  title: 'Page Two',
                  bodyWidget: Column(
                    children: [
                      const Text("wait.."),
                      ElevatedButton(
                          onPressed: () {
                            //Navigator.of(context).pop();
                            HomeBloc homeBloc =
                                BlocProvider.of<HomeBloc>(context);
                            homeBloc.add(TimelinePolicyExpiredPageActiveEvent());
                          },
                          child: const Text('End'))
                    ],
                  )));
            }
            */
          }
        },
      );
    });
  }

  void loadMenu() {
    onboardMenuCariBloc.add(LoadOnBoardMenuCariEvent());
  }

  Widget buildTitleWidget(BuildContext context, String pageTitle) {
    Widget baseWidget;

    baseWidget = Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  pageTitle,
                  style: const TextStyle(
                      fontSize: 25.0,
                      //color: Colors.white,
                      color: Color(0xffff6101),
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,              
                      fontFamily: 'Hind',
                      //decoration: TextDecoration.underline,              
                      //decorationThickness: 2.0
                    ),              
                )
              ],
            ),
            const Spacer(),
            FittedBox(
              alignment: Alignment.topRight,
              fit: BoxFit.scaleDown,
              child: Image.asset(
                'assets/images/login_logo.png',
                width: 55,
                height: 55,
              ),
            )
          ],
        ),        
        const SizedBox(height: 1,),
        const Divider(thickness: 2, color: Color(0xffff6101)),
      ],
    );

    return baseWidget;
  }

  Widget titlePage(BuildContext context, String pageTitle) {
    Paint paint = Paint();
    paint.color = Colors.transparent;
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        color: paint.color,
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              pageTitle,
              style: const TextStyle(
                  fontSize: 25.0,
                  //color: Colors.white,
                  color: Color(0xffff6101),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Hind'),
            )));
  }
}
