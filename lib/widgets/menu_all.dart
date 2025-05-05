import 'package:esalesapp/menu/data_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/blocs/home/home_bloc.dart';
import '../common/constants.dart';
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

class MenuGridState extends State<MenuGrid> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _tileKeys = {};
  int? expandedIndex;

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < menuSections.length; i++) {
      _tileKeys[i] = GlobalKey();
    }

    // Initialize animation controllers
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Define animations
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn)
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic)
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                MyColors.grey_3.withOpacity(0.5),
              ],
              stops: const [0.0, 1.0],
            ),
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar with logo or title could go here
                ...menuSections.asMap().entries.map((entry) {
                  int index = entry.key;
                  var section = entry.value;
                  return TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 400 + (index * 100)),
                    curve: Curves.easeOutQuart,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: _buildSectionCard(index, section, homeBloc),
                  );
                }).toList(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(int index, Map<String, dynamic> section, HomeBloc homeBloc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Card(
          key: _tileKeys[index],
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              // Custom expansion header
              InkWell(
                onTap: () {
                  setState(() {
                    expandedIndex = expandedIndex == index ? null : index;
                  });
                  if (expandedIndex == index) {
                    _scrollToTile(index);
                  }
                },
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(expandedIndex == index ? 0 : 16),
                  bottomRight: Radius.circular(expandedIndex == index ? 0 : 16),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   begin: Alignment.centerLeft,
                    //   end: Alignment.centerRight,
                    //   colors: [
                    //     MyColors.secondaryBlue.withOpacity(0.05),
                    //     Colors.white,
                    //   ],
                    // ),
                    border: Border(
                      left: BorderSide(
                        color: MyColors.secondaryBlue,
                        width: 4,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionTitle(section['title']),
                      AnimatedRotation(
                        turns: expandedIndex == index ? 0.25 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: expandedIndex == index
                                ? MyColors.primaryOrange.withOpacity(0.1)
                                : MyColors.secondaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: expandedIndex == index
                                ? MyColors.primaryOrange
                                : MyColors.secondaryBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content
              AnimatedCrossFade(
                firstChild: const SizedBox(height: 0),
                secondChild: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: _buildMenuGrid(
                    List<Map<String, String>>.from(section['menus']),
                    homeBloc,
                  ),
                ),
                crossFadeState: expandedIndex == index ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
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
        alignment: 0.02,
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
              letterSpacing: 0.5,
            ),
          ),
          TextSpan(
            text: rest,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MyColors.primaryOrange,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid(List<Map<String, String>> items, HomeBloc homeBloc) {
    // ─── HELPERS ────────────────────────────────────────────────────────────
    String wrapLongWords(String text, {int every = 12}) =>
        text.replaceAllMapped(
            RegExp(r'(\S{' + every.toString() + r'})'), (m) => '${m[1]}\u200B');

    String formatLabel(String raw) {
      // 1️⃣ Selalu patah di spasi pertama → kata kedua pasti turun ke baris 2
      final firstSpace = raw.indexOf(' ');
      String formatted = (firstSpace == -1)
          ? raw                                   // satu kata saja
          : '${raw.substring(0, firstSpace)}\n'   // kata 1
          '${raw.substring(firstSpace + 1)}';     // sisanya di bawah

      // 2️⃣ Tambahkan zero‑width space agar kata super‑panjang ikut wrap
      return wrapLongWords(formatted);
    }
    // ────────────────────────────────────────────────────────────────────────

    return Expanded(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final data      = items[index];
          final menuid    = data['menuid']!;
          final imagePath = data['icon']!;
          final label     = formatLabel(data['label']!);

          return AnimatedBuilder(
            animation: _slideController,
            builder: (context, child) {
              final delay = 0.05 * index;
              final slideValue = _slideController.value > delay
                  ? ((_slideController.value - delay) / (1 - delay)).clamp(0.0, 1.0)
                  : 0.0;

              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _slideController,
                    curve: Interval(delay, 1.0, curve: Curves.easeOut),
                  ),
                ),
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - slideValue)),
                  child: child,
                ),
              );
            },
            child: _buildMenuButton(menuid, imagePath, label, homeBloc),
          );
        },
      ),
    );
  }

  Widget _buildMenuButton(String menuid, String imagePath, String label, HomeBloc homeBloc) {
    return Hero(
      tag: 'menu_$menuid',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          child: InkWell(
            onTap: () => _handleMenuTap(menuid, homeBloc),
            splashColor: MyColors.primaryOrange.withOpacity(0.1),
            highlightColor: MyColors.secondaryBlue.withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Custom-designed icon container
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: MyColors.primaryOrange.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Image.asset(
                      imagePath,
                      color: MyColors.primaryOrange,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: MyColors.black,
                        height: 1.2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuTap(String menuid, HomeBloc homeBloc) {
    // Add a small ripple effect before navigation
    Future.delayed(const Duration(milliseconds: 100), () {
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
        case 'projecttree':
          homeBloc.add(ProjectTreePageActiveEvent());
          break;
        default:
          homeBloc.add(HomePageActiveEvent());
          break;
      }
    });
  }
}