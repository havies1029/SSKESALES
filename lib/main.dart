import 'package:esalesapp/blocs/briefing/briefinginfo_bloc.dart';
import 'package:esalesapp/blocs/briefing/briefinglist_bloc.dart';
import 'package:esalesapp/blocs/calendar/eventrenewalcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealbtnfilter_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealglobal_cubit.dart';
import 'package:esalesapp/blocs/jobreal/jobrealtab_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobtimeline_bloc.dart';
import 'package:esalesapp/blocs/jobreal/sppa4timelinecari_bloc.dart';
import 'package:esalesapp/blocs/login/change_password_bloc.dart';
import 'package:esalesapp/blocs/mstcob/cobcari_bloc.dart';
import 'package:esalesapp/blocs/mstcob/cobcrud_bloc.dart';
import 'package:esalesapp/blocs/mstcustcat/custcatcari_bloc.dart';
import 'package:esalesapp/blocs/mstcustcat/custcatcrud_bloc.dart';
import 'package:esalesapp/blocs/mstjabatan/jabatancari_bloc.dart';
import 'package:esalesapp/blocs/mstjabatan/jabatancrud_bloc.dart';
import 'package:esalesapp/blocs/mstjob/jobcari_bloc.dart';
import 'package:esalesapp/blocs/mstjob/jobcrud_bloc.dart';
import 'package:esalesapp/blocs/mstjobcat/jobcatcari_bloc.dart';
import 'package:esalesapp/blocs/mstjobcat/jobcatcrud_bloc.dart';
import 'package:esalesapp/blocs/mstjobgroup/jobgroupcari_bloc.dart';
import 'package:esalesapp/blocs/mstjobgroup/jobgroupcrud_bloc.dart';
import 'package:esalesapp/blocs/mstmedia/mediacari_bloc.dart';
import 'package:esalesapp/blocs/mstmedia/mediacrud_bloc.dart';
import 'package:esalesapp/blocs/mstrekan/rekancari_bloc.dart';
import 'package:esalesapp/blocs/mstrekan/rekancrud_bloc.dart';
import 'package:esalesapp/blocs/mststaff/staffcari_bloc.dart';
import 'package:esalesapp/blocs/mststaff/staffcrud_bloc.dart';
import 'package:esalesapp/blocs/msttitle/titlecari_bloc.dart';
import 'package:esalesapp/blocs/msttitle/titlecrud_bloc.dart';
import 'package:esalesapp/blocs/onboardmenu/onboardmenucari_bloc.dart';
import 'package:esalesapp/blocs/polis/poliscari_bloc.dart';
import 'package:esalesapp/blocs/polis/poliscrud_bloc.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/repositories/jobreal/jobrealcrud_repository.dart';
import 'package:esalesapp/repositories/jobreal/jobrealfoto_repository.dart';
import 'package:esalesapp/repositories/login/change_password_repository.dart';
import 'package:esalesapp/repositories/mstcob/cobcrud_repository.dart';
import 'package:esalesapp/repositories/mstcustcat/custcatcrud_repository.dart';
import 'package:esalesapp/repositories/mstjabatan/jabatancrud_repository.dart';
import 'package:esalesapp/repositories/mstjob/jobcrud_repository.dart';
import 'package:esalesapp/repositories/mstjobcat/jobcatcrud_repository.dart';
import 'package:esalesapp/repositories/mstjobgroup/jobgroupcrud_repository.dart';
import 'package:esalesapp/repositories/mstmedia/mediacrud_repository.dart';
import 'package:esalesapp/repositories/mstrekan/rekancrud_repository.dart';
import 'package:esalesapp/repositories/mststaff/staffcrud_repository.dart';
import 'package:esalesapp/repositories/msttitle/titlecrud_repository.dart';
import 'package:esalesapp/repositories/polis/poliscrud_repository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:esalesapp/blocs/chatting/chatgroupcari_bloc.dart';
import 'package:esalesapp/blocs/chatting/chatgroupcrud_bloc.dart';
import 'package:esalesapp/blocs/chatting/roomcari_bloc.dart';
import 'package:esalesapp/blocs/networkconnection/network_bloc.dart';
import 'package:esalesapp/blocs/progressindicator/progressindicator_bloc.dart';
import 'package:esalesapp/repositories/chatting/chatgroupcrud_repository.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/pages/home/home_page.dart';
import 'package:esalesapp/pages/login/login_page.dart';
import 'package:esalesapp/repositories/user/user_repository.dart';
import 'package:esalesapp/blocs/authentication/authentication_bloc.dart';
import 'package:esalesapp/pages/splash/splash_page.dart';
import 'package:esalesapp/common/loading_indicator.dart';
import 'blocs/takeimage/takeimage_cubit.dart';

Future<void> main() async {
  final userRepository = UserRepository();
  AppData.kIsWeb = kIsWeb;
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(
      userRepository: userRepository,
      key: null,
    ),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  const App({required super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChangePasswordBloc>(
            create: (context) =>
                ChangePasswordBloc(repository: ChangePasswordRepository())),
        BlocProvider<TakeImageCubit>(
          create: (context) => TakeImageCubit(),
        ),
        BlocProvider<RoomCariBloc>(create: (context) => RoomCariBloc()),
        BlocProvider<ChatGroupCariBloc>(
            create: (context) => ChatGroupCariBloc()),
        BlocProvider<ChatGroupCrudBloc>(
            create: (context) => ChatGroupCrudBloc(
                chatGroupRepository: ChatGroupCrudRepository())),
        BlocProvider<ProgressIndicatorBloc>(
            create: (context) => ProgressIndicatorBloc()),
        BlocProvider<NetworkBloc>(
            create: (context) => NetworkBloc()..add(NetworkObserve())),
        BlocProvider(
          create: (context) => JobRealTabBloc()
        ),        
        BlocProvider(
          create: (context)=>JobRealGlobalCubit()
        ),
        BlocProvider(
          create: (context)=>JobRealBtnFilterCubit()
        ),
        BlocProvider<JobRealCariBloc>(create: (context) => JobRealCariBloc()),
        BlocProvider<JobReal2CariBloc>(create: (context) => JobReal2CariBloc()),
        BlocProvider<JobReal2GridBloc>(
            create: (context) => JobReal2GridBloc(
                jobReal2CariBloc: context.read<JobReal2CariBloc>())),
        BlocProvider<JobReal3CariBloc>(create: (context) => JobReal3CariBloc()),
        BlocProvider<JobReal3GridBloc>(
            create: (context) => JobReal3GridBloc(
                jobReal3CariBloc: context.read<JobReal3CariBloc>())),
        BlocProvider<JobRealFotoBloc>(
            create: (context) =>
                JobRealFotoBloc(repository: JobRealFotoRepository())),
        BlocProvider<Sppa4TimelineCariBloc>(create: (context) => Sppa4TimelineCariBloc()),
        BlocProvider<JobtimelineBloc>(create: (context) => JobtimelineBloc()),
        BlocProvider<JobRealCrudBloc>(
            create: (context) => JobRealCrudBloc(
                repository: JobRealCrudRepository(),
                jobReal2CariBloc: context.read<JobReal2CariBloc>(),
                jobReal3CariBloc: context.read<JobReal3CariBloc>(),
                jobRealFotoBloc: context.read<JobRealFotoBloc>(),
                jobReal2GridBloc: context.read<JobReal2GridBloc>())),      
        BlocProvider<JobReal2CariBloc>(create: (context) => JobReal2CariBloc()),
        BlocProvider<MediaCariBloc>(create: (context) => MediaCariBloc()),
        BlocProvider<MediaCrudBloc>(
            create: (context) =>
                MediaCrudBloc(repository: MediaCrudRepository())),
        BlocProvider<JobCatCariBloc>(create: (context) => JobCatCariBloc()),
        BlocProvider<JobCatCrudBloc>(
            create: (context) =>
                JobCatCrudBloc(repository: JobCatCrudRepository())),
        BlocProvider<JobCariBloc>(create: (context) => JobCariBloc()),
        BlocProvider<JobCrudBloc>(
            create: (context) => JobCrudBloc(repository: JobCrudRepository())),
        BlocProvider<RekanCariBloc>(create: (context) => RekanCariBloc()),
        BlocProvider<RekanCrudBloc>(
            create: (context) =>
                RekanCrudBloc(repository: RekanCrudRepository())),
        BlocProvider<TitleCariBloc>(create: (context) => TitleCariBloc()),
        BlocProvider<TitleCrudBloc>(
            create: (context) =>
                TitleCrudBloc(repository: TitleCrudRepository())),
        BlocProvider<JabatanCariBloc>(create: (context) => JabatanCariBloc()),
        BlocProvider<JabatanCrudBloc>(
            create: (context) =>
                JabatanCrudBloc(repository: JabatanCrudRepository())),
        BlocProvider<StaffCariBloc>(create: (context) => StaffCariBloc()),
        BlocProvider<StaffCrudBloc>(
            create: (context) =>
                StaffCrudBloc(repository: StaffCrudRepository())),
        BlocProvider<CustCatCariBloc>(create: (context) => CustCatCariBloc()),
        BlocProvider<CustCatCrudBloc>(
            create: (context) =>
                CustCatCrudBloc(repository: CustCatCrudRepository())),
        BlocProvider<PolisCariBloc>(create: (context) => PolisCariBloc()),
        BlocProvider<PolisCrudBloc>(
            create: (context) =>
                PolisCrudBloc(repository: PolisCrudRepository())),
        BlocProvider<CobCariBloc>(create: (context) => CobCariBloc()),
        BlocProvider<CobCrudBloc>(
            create: (context) => CobCrudBloc(repository: CobCrudRepository())),
        BlocProvider<EventRenewalCariBloc>(
            create: (context) => EventRenewalCariBloc()),
        BlocProvider<JobGroupCariBloc>(create: (context) => JobGroupCariBloc()),
        BlocProvider<JobGroupCrudBloc>(
            create: (context) =>
                JobGroupCrudBloc(repository: JobGroupCrudRepository())),
        BlocProvider<BriefinglistBloc>(
            create: (context) => BriefinglistBloc()),
        BlocProvider<OnBoardMenuCariBloc>(
            create: (context) => OnBoardMenuCariBloc()),
        BlocProvider<BriefingInfoBloc>(
            create: (context) => BriefingInfoBloc()),
        BlocProvider<BriefinglistBloc>(
            create: (context) => BriefinglistBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Planner',
        theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
        // The Mandy red, dark theme.
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
        // Use dark or light theme based on system setting.
        themeMode: ThemeMode.light,

        routes: const {},

        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUninitialized) {
              debugPrint("AuthenticationUninitialized #10");
        
              return const SplashPage();
            }
        
            if (state is AuthenticationAuthenticated) {
              debugPrint("AuthenticationAuthenticated #20");
        
              return HomePage(
                userRepository: userRepository,
                userid: 0,
                key: null,
              );
               
            }
        
            if (state is AuthenticationUnauthenticated) {
              debugPrint("AuthenticationUnauthenticated #30");
              return LoginPage(
                userRepository: userRepository,
              );
            }
        
            if (AppData.kIsWeb) {
              return LoginPage(
                userRepository: userRepository,
              );
            } else {
              return const LoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}
