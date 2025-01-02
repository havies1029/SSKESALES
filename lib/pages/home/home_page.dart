import 'package:esalesapp/blocs/jobreal/jobrealbtnfilter_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealglobal_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealtab_bloc.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';
import 'package:esalesapp/pages/onboard/onboard_main.dart';
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
  late JobRealTabBloc jobRealTabBloc;
  late JobRealGlobalCubit jobRealGlobalCubit;
  late JobRealBtnFilterCubit jobRealBtnFilterCubit;
  late JobRealCariBloc jobRealCariBloc;

  @override
  void initState() {
    super.initState();   
    
    Future.delayed(const Duration(milliseconds: 500), () {
      refreshDataTabJobReal();
    });
  }

  @override
  Widget build(BuildContext context) {
    jobRealTabBloc = BlocProvider.of<JobRealTabBloc>(context);
    jobRealGlobalCubit = BlocProvider.of<JobRealGlobalCubit>(context);
    jobRealBtnFilterCubit = BlocProvider.of<JobRealBtnFilterCubit>(context);
    jobRealCariBloc = BlocProvider.of<JobRealCariBloc>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<ProfileBloc>(
          create: (content) => ProfileBloc(
              userRepository: widget.userRepository, id: widget.userid),
        )  
      ],
      child: MultiBlocListener(
      listeners: [
          BlocListener<JobRealTabBloc, JobRealTabState>(
              listenWhen: (previous, current) {
            return (current.status == ListStatus.success);
          }, listener: (context, state) {
            //debugPrint("_HomePageState => JobRealTabState #00 => listeners ${state.status}");
            if (state.status == ListStatus.success){
              selectedTabEvent(state.listJobCatGroup![0]);
            }
          }),
        ],
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            SizeConfig().init(context);
            if (state is HomePageActive) {
              debugPrint("HomePageActive");
              //return const PageContainer(pageType: PageType.timeline);
              return const OnboardMainPage();
            } else if (state is TimelinePolicyExpiredPageActive) {
              debugPrint("TimelinePolicyExpiredPageActive");
              return const PageContainer(pageType: PageType.timeline);
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
            } else if (state is CalendarPageActive) {
              debugPrint("CalendarPageActive");
              return const PageContainer(pageType: PageType.calendar);
            } else if (state is JobGroupPageActive) {
              debugPrint("JobGroupPageActive");
              return const PageContainer(pageType: PageType.jobgroup);
            } else if (state is ChangePasswordPageActive) {
              debugPrint("ChangePasswordPageActive");
              return const PageContainer(pageType: PageType.changepswd);
            } else if (state is JobSalesPageActive) {
              debugPrint("JobSalesPageActive");
              return const PageContainer(pageType: PageType.jobsales);
            } else if (state is RealGroupPageActive) {
              debugPrint("RealGroupPageActive");
              return const PageContainer(pageType: PageType.realgroup);
            } else if (state is BriefingPageActive) {
              debugPrint("BriefingPageActive");
              return const PageContainer(pageType: PageType.briefing);
            } else if (state is SOAClientPageActive) {
              debugPrint("SOAClientPageActive");
              return const PageContainer(pageType: PageType.soaclient);
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
      ),
    );
  }

  Future<void> refreshDataTabJobReal() async {
    debugPrint("JobRealCariTabPage #00 -> refreshData");
    jobRealTabBloc.add(RefreshJobRealTabEvent(personId: AppData.personId));
  }
  
  void selectedTabEvent(ComboJobcatgroupModel selectedTab) {
    debugPrint("selectedTabEvent #00");

    jobRealGlobalCubit.setSelectedJobCatGroup(selectedTab);

    //debugPrint("jobRealBtnFilterCubit.state.filterDoc : ${jobRealBtnFilterCubit.state.filterDoc}");

    jobRealCariBloc.add(RefreshJobRealCariEvent(
        hal: 0,
        searchText: "",
        filterDoc: jobRealBtnFilterCubit.state.filterDoc,
        personId: AppData.personId,
        jobCatGroupId: selectedTab.mjobcatgroupId));
  }

}
