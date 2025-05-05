part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomePageActiveEvent extends HomeEvent {}
class ProfilePageActiveEvent extends HomeEvent {}
class RoomCariPageActiveEvent extends HomeEvent {}
class ChatSupportPageActiveEvent extends HomeEvent {}
class JobRealCariPageActiveEvent extends HomeEvent {}
class MediaCariPageActiveEvent extends HomeEvent {}
class JobCatCariPageActiveEvent extends HomeEvent {}
class JobCariPageActiveEvent extends HomeEvent {}
class CustomerCariPageActiveEvent extends HomeEvent {}
class AsuransiCariPageActiveEvent extends HomeEvent {}
class TitleCariPageActiveEvent extends HomeEvent {}
class JabatanCariPageActiveEvent extends HomeEvent {}
class StaffCariPageActiveEvent extends HomeEvent {}
class CustCatCariPageActiveEvent extends HomeEvent {}
class PolisCariPageActiveEvent extends HomeEvent {}
class CobCariPageActiveEvent extends HomeEvent {}
class CalendarPageActiveEvent extends HomeEvent {}
class JobGroupPageActiveEvent extends HomeEvent {}
class ChangePasswordPageActiveEvent extends HomeEvent {}
class JobSalesPageActiveEvent extends HomeEvent {}
class RealGroupPageActiveEvent extends HomeEvent {}
class TimelinePolicyExpiredPageActiveEvent extends HomeEvent {}
class OnBoardPageActiveEvent extends HomeEvent {}
class BriefingPageActiveEvent extends HomeEvent {}
class SOAClientPageActiveEvent extends HomeEvent {}
class ProjectPageActiveEvent extends HomeEvent {}
class DashboardPageActiveEvent extends HomeEvent{}
class ProjectTreePageActiveEvent extends HomeEvent{}