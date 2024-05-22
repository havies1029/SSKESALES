import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomePageActive()) {
    on<HomePageActiveEvent>((event, emit) => emit(HomePageActive()));
    on<ProfilePageActiveEvent>((event, emit) => emit(ProfilePageActive()));     
    on<RoomCariPageActiveEvent>((event, emit) => emit(RoomCariPageActive()));    
    on<ChatSupportPageActiveEvent>((event, emit) => emit(ChatSupportPageActive()));
    on<JobRealCariPageActiveEvent>((event, emit) => emit(JobRealCariPageActive())); 
    on<MediaCariPageActiveEvent>((event, emit) => emit(MediaCariPageActive())); 
    on<JobCatCariPageActiveEvent>((event, emit) => emit(JobCatCariPageActive())); 
    on<JobCariPageActiveEvent>((event, emit) => emit(JobCariPageActive())); 
    on<CustomerCariPageActiveEvent>((event, emit) => emit(CustomerCariPageActive())); 
    on<AsuransiCariPageActiveEvent>((event, emit) => emit(AsuransiCariPageActive())); 
    on<TitleCariPageActiveEvent>((event, emit) => emit(TitleCariPageActive())); 
    on<JabatanCariPageActiveEvent>((event, emit) => emit(JabatanCariPageActive())); 
    on<StaffCariPageActiveEvent>((event, emit) => emit(StaffCariPageActive())); 
    on<CustCatCariPageActiveEvent>((event, emit) => emit(CustCatCariPageActive())); 
    on<PolisCariPageActiveEvent>((event, emit) => emit(PolisCariPageActive())); 
    on<CobCariPageActiveEvent>((event, emit) => emit(CobCariPageActive())); 
    on<CalendarPageActiveEvent>((event, emit) => emit(CalendarPageActive())); 
  }
}
