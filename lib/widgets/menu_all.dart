import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/home/home_bloc.dart';
import '../common/constants.dart';
import 'header_section.dart';
import 'my_colors.dart';
import 'menu_item_button.dart' as customWidgets;

class MenuAllWidget extends StatelessWidget {
  const MenuAllWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey_3,
      body: SafeArea(
        child: const MenuGrid(),
      ),
    );
  }
}

class MenuGrid extends StatefulWidget {
  const MenuGrid({super.key});

  @override
  MenuGridState createState() => MenuGridState();
}

class MenuGridState extends State<MenuGrid> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _tileKeys = {};
  int? expandedIndex;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < menuSections.length; i++) {
      _tileKeys[i] = GlobalKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderSection(),
          const SizedBox(height: 24),
          const Divider(thickness: 1, color: MyColors.grey_10),
          const SizedBox(height: 32),
          ...menuSections.asMap().entries.map((entry) {
            int index = entry.key;
            var section = entry.value;
            return Card(
              key: _tileKeys[index],
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: ExpansionTile(
                key: ValueKey('expansion_tile_${index}_${expandedIndex == index ? "open" : "closed"}'),
                title: _buildSectionTitle(section['title']),
                initiallyExpanded: expandedIndex == index,
                onExpansionChanged: (isExpanded) {
                  setState(() {
                    // Tutup tile yang lain dengan hanya menyimpan tile yang terbuka
                    expandedIndex = isExpanded ? index : null;
                  });
                  if (isExpanded) {
                    _scrollToTile(index);
                  }
                },
                children: [
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState: expandedIndex == index
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstCurve: Curves.easeInOut,
                    secondCurve: Curves.easeInOut,
                    firstChild: const SizedBox.shrink(),
                    secondChild: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      color: MyColors.white,
                      child: _buildMenuGrid(
                        List<Map<String, String>>.from(section['menus']),
                        homeBloc,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _scrollToTile(int index) {
    final key = _tileKeys[index];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildSectionTitle(String title) {
    final words = title.split(' ');
    final firstWord = words.first;
    final rest = words.sublist(1).join(' ');
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$firstWord ',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MyColors.secondaryBlue,
            ),
          ),
          TextSpan(
            text: rest,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MyColors.primaryOrange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid(List<Map<String, String>> items, HomeBloc homeBloc) {
    return Expanded(  // Gunakan Expanded untuk memastikan GridView menyesuaikan ruang yang tersedia
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8, // Menyesuaikan rasio ukuran agar lebih cocok
        ),
        itemBuilder: (context, index) {
          final menuid = items[index]["menuid"]!;
          String label = items[index]["label"]!;

          const int threshold = 20;
          // Pembagian baris untuk label yang panjang
          if (label.length > threshold) {
            int lastSpace = label.lastIndexOf(" ");
            if (lastSpace != -1) {
              label = "${label.substring(0, lastSpace)}\n${label.substring(lastSpace + 1)}";
            }
          }

          final imagePath = items[index]["icon"]!;

          return InkWell(
            onTap: () => _handleMenuTap(menuid, homeBloc),
            child: customWidgets.MenuItemButton(
              imagePath: imagePath,
              label: label,
            ),
          );
        },
      ),
    );
  }

  void _handleMenuTap(String menuid, HomeBloc homeBloc) {
    switch (menuid) {
      case 'home':
        homeBloc.add(HomePageActiveEvent());
        break;
      case 'profile':
        homeBloc.add(ProfilePageActiveEvent());
        break;
      case 'roomcari':
        homeBloc.add(RoomCariPageActiveEvent());
        break;
      case 'chatsupport':
        homeBloc.add(ChatSupportPageActiveEvent());
        break;
      case 'jobrealcari':
        homeBloc.add(JobRealCariPageActiveEvent());
        break;
      case 'mediacari':
        homeBloc.add(MediaCariPageActiveEvent());
        break;
      case 'jobcatcari':
        homeBloc.add(JobCatCariPageActiveEvent());
        break;
      case 'jobcari':
        homeBloc.add(JobCariPageActiveEvent());
        break;
      case 'customercari':
        homeBloc.add(CustomerCariPageActiveEvent());
        break;
      case 'asuransicari':
        homeBloc.add(AsuransiCariPageActiveEvent());
        break;
      case 'titlecari':
        homeBloc.add(TitleCariPageActiveEvent());
        break;
      case 'jabatancari':
        homeBloc.add(JabatanCariPageActiveEvent());
        break;
      case 'staffcari':
        homeBloc.add(StaffCariPageActiveEvent());
        break;
      case 'custcatcari':
        homeBloc.add(CustCatCariPageActiveEvent());
        break;
      case 'poliscari':
        homeBloc.add(PolisCariPageActiveEvent());
        break;
      case 'cobcari':
        homeBloc.add(CobCariPageActiveEvent());
        break;
      case 'calendar':
        homeBloc.add(CalendarPageActiveEvent());
        break;
      case 'jobgroup':
        homeBloc.add(JobGroupPageActiveEvent());
        break;
      case 'changepassword':
        homeBloc.add(ChangePasswordPageActiveEvent());
        break;
      case 'jobsales':
        homeBloc.add(JobSalesPageActiveEvent());
        break;
      case 'realgroup':
        homeBloc.add(RealGroupPageActiveEvent());
        break;
      case 'timelineexpired':
        homeBloc.add(TimelinePolicyExpiredPageActiveEvent());
        break;
      case 'onboard':
        homeBloc.add(OnBoardPageActiveEvent());
        break;
      case 'briefing':
        homeBloc.add(BriefingPageActiveEvent());
        break;
      case 'soaclient':
        homeBloc.add(SOAClientPageActiveEvent());
        break;
      case 'project':
        homeBloc.add(ProjectPageActiveEvent());
        break;
      case 'todo':
        homeBloc.add(TodoPageActiveEvent());
        break;
      default:
        homeBloc.add(HomePageActiveEvent());
        break;
    }
  }
}
