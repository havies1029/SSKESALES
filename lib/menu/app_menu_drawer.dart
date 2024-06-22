import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/pages/home/home.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/authentication/authentication_bloc.dart';
import 'package:esalesapp/blocs/home/home_bloc.dart';
import 'package:flutter/material.dart';

class AppMenu extends StatefulWidget {
  const AppMenu({super.key});

  @override
  AppMenuState createState() => AppMenuState();
}

class AppMenuState extends State<AppMenu> with RouteAware {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPictureSize: const Size.square(100),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/login_logo.png'),
            ),
            accountEmail: const Text("support@ptssk.id"),
            accountName: Text(AppData.personName),
            onDetailsPressed: () {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pop();
                homeBloc.add(ProfilePageActiveEvent());
              });
            },
          ),
          
          ExpansionTile(
            leading: const Icon(
              Icons.settings,          
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 10.0,          
            ),
            title: const Text(
              "Data Action Plan",
              style: TextStyle(            
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Media"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(MediaCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Job Function"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(JobGroupPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Task Category"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(JobCatCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("List of Tasks"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(JobCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Subordinate Tasks"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(JobSalesPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Finished Tasks"),
                  //selected: _activeRoute == AppRoutes.homePage,
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(JobRealCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Subordinate Finished Tasks"),
                  //selected: _activeRoute == AppRoutes.homePage,
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(RealGroupPageActiveEvent());
                    });
                  },
                ),
              ),
            ],
          ),          
          ExpansionTile(
            leading: const Icon(
              Icons.settings,          
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 10.0,          
            ),
            title: const Text(
              "Data Insurance",
              style: TextStyle(            
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Class of Business"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(CobCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Insurer"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(AsuransiCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Policy"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(PolisCariPageActiveEvent());
                    });
                  },
                ),
              ),    
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Calendar Policy Exp"),
                  //selected: _activeRoute == AppRoutes.homePage,
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(CalendarPageActiveEvent());
                    });
                  },
                ),
              ),          
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Timeline Policy Exp"),
                  //selected: _activeRoute == AppRoutes.homePage,
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(TimelinePolicyExpiredPageActiveEvent());
                    });
                  },
                ),
              ),          
            ],
          ),          
          ExpansionTile(
            leading: const Icon(
              Icons.settings,          
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 10.0,          
            ),
            title: const Text(
              "Data Umum",
              style: TextStyle(            
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Title"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(TitleCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Client Category"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(CustCatCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Jabatan"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(JabatanCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Customer"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(CustomerCariPageActiveEvent());
                    });
                  },
                ),
              ),              
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Karyawan"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(StaffCariPageActiveEvent());
                    });
                  },
                ),
              ),                
            ],
          ),          
          ExpansionTile(
            leading: const Icon(
              Icons.settings,          
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 10.0,          
            ),
            title: const Text(
              "User Security",
              style: TextStyle(            
              ),
            ),
            children: <Widget>[             
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Profile"),
                  //selected: _activeRoute == AppRoutes.homePage,
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(ProfilePageActiveEvent());
                    });
                  },
                ),
              ),           
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text("Change Password"),
                  //selected: _activeRoute == AppRoutes.homePage,
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(ChangePasswordPageActiveEvent());
                    });
                  },
                ),
              ),         
            ],
          ),       
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text("Chat Support"),
            //selected: _activeRoute == AppRoutes.homePage,
            onTap: () {              
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pop();
                homeBloc.add(RoomCariPageActiveEvent());
              });
            },            
          ),                 
          const AboutListTile(
            icon: Icon(Icons.info),
            applicationName: "e-Planner",
            aboutBoxChildren: <Widget>[
              Text("http://www.smartsoft-id.com/", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              Text("version : 0.3", style: TextStyle(fontSize: 12.0),),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          ),
        ],
      ),
    );
  }
}
