import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/home/home_bloc.dart';
import 'package:esalesapp/blocs/profile/profile_bloc.dart';
import 'package:esalesapp/common/size_config.dart';
import 'package:esalesapp/pages/base/base_container.dart';
import 'package:esalesapp/pages/base/base_page.dart';
import 'package:esalesapp/repositories/user/user_repository.dart';

class HomePage extends StatefulWidget {
  final int userid;
  final UserRepository userRepository;

  const HomePage(
      {required super.key, required this.userid, required this.userRepository});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<ProfileBloc>(
          create: (content) => ProfileBloc(
              userRepository: widget.userRepository, id: widget.userid),
        ),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          SizeConfig().init(context);
          if (state is HomePageActive) {
            debugPrint("HomePageActive");
            return const PageContainer(pageType: PageType.action);
          } else if (state is RoomCariPageActive) {
            debugPrint("RoomCariPageActive");
            return const PageContainer(pageType: PageType.roomchat);
          } else if (state is JobRealCariPageActive) {
            debugPrint("JobRealCariPageActive");
            return const PageContainer(pageType: PageType.action);
          } else if (state is MediaCariPageActive) {
            debugPrint("MediaCariPageActive");
            return const PageContainer(pageType: PageType.media);
          } else if (state is JobCatCariPageActive) {
            debugPrint("JobCatCariPageActive");
            return const PageContainer(pageType: PageType.jobcat);
          } else if (state is JobCariPageActive) {
            debugPrint("JobCariPageActive");
            return const PageContainer(pageType: PageType.job);
          } else if (state is JobCariPageActive) {
            debugPrint("JobCariPageActive");
            return const PageContainer(pageType: PageType.job);
          } else if (state is CustomerCariPageActive) {
            debugPrint("CustomerCariPageActive");
            return const PageContainer(pageType: PageType.customer);
          } else if (state is AsuransiCariPageActive) {
            debugPrint("AsuransiCariPageActive");
            return const PageContainer(pageType: PageType.insurer);      
          } else if (state is TitleCariPageActive) {
            debugPrint("TitleCariPageActive");
            return const PageContainer(pageType: PageType.title);       
          } else if (state is JabatanCariPageActive) {
            debugPrint("JabatanCariPageActive");
            return const PageContainer(pageType: PageType.jabatan);  
          } else if (state is StaffCariPageActive) {
            debugPrint("StaffCariPageActive");
            return const PageContainer(pageType: PageType.staff);     
          } else if (state is CustCatCariPageActive) {
            debugPrint("CustCatCariPageActive");
            return const PageContainer(pageType: PageType.custcat);    
          } else if (state is PolisCariPageActive) {
            debugPrint("PolisCariPageActive");
            return const PageContainer(pageType: PageType.polis);     
          } else if (state is CobCariPageActive) {
            debugPrint("CobCariPageActive");
            return const PageContainer(pageType: PageType.cob);     
          } else if (state is ProfilePageActive) {
            return PageContainerWithUserRepository(
              pageType: PageType.profile,
              userRepository: widget.userRepository,
              userid: widget.userid,
              key: null,
            );
          } 
          return Container();
        },
      ),
    );
  }
}
