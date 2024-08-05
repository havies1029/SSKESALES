part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomePageActive extends HomeState {}
class ProfilePageActive extends HomeState {}
class RoomCariPageActive extends HomeState {}
class ChatSupportPageActive extends HomeState {}
class JobRealCariPageActive extends HomeState {}
class MediaCariPageActive extends HomeState {}
class JobCatCariPageActive extends HomeState {}
class JobCariPageActive extends HomeState {}
class CustomerCariPageActive extends HomeState {}
class AsuransiCariPageActive extends HomeState {}
class TitleCariPageActive extends HomeState {}
class JabatanCariPageActive extends HomeState {}
class StaffCariPageActive extends HomeState {}
class CustCatCariPageActive extends HomeState {}
class PolisCariPageActive extends HomeState {}
class CobCariPageActive extends HomeState {}
class CalendarPageActive extends HomeState {}
class JobGroupPageActive extends HomeState {}
class ChangePasswordPageActive extends HomeState {}
class JobSalesPageActive extends HomeState {}
class RealGroupPageActive extends HomeState {}
class TimelinePolicyExpiredPageActive extends HomeState {}
class OnBoardPageActive extends HomeState {}