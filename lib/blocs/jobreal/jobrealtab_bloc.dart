import 'package:equatable/equatable.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';
import 'package:esalesapp/repositories/combobox/combojobcatgroup_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'jobrealtab_event.dart';
part 'jobrealtab_state.dart';

class JobRealTabBloc extends Bloc<JobRealTabEvents, JobRealTabState> {
  JobRealTabBloc() : super(const JobRealTabState()) {
    on<RefreshJobRealTabEvent>(onRefreshJobRealTab);
    on<SelectedJobRealTabEvent>(onSelectedTab);
  }

  Future<void> onRefreshJobRealTab(
      RefreshJobRealTabEvent event, Emitter<JobRealTabState> emit) async {
    debugPrint("onRefreshJobRealTab");

    emit(const JobRealTabState());

    ComboJobcatgroupRepository repo = ComboJobcatgroupRepository();
    if (state.status == ListStatus.initial) {
      List<ComboJobcatgroupModel> items =
          await repo.getComboJobCatGroupByPersonId(event.personId);

      List<ComboJobcatgroupModel> listJobCatGroup = [];
      List<Widget> listTab = [];
      List<Color> colorCollection = <Color>[];

      if (items.isNotEmpty) {
        items.add(const ComboJobcatgroupModel(
            mjobcatgroupId: "ALL",
            groupNama: "ALL",
            urutan: 100,
            hasIndex: false));
      }

      items.asMap().forEach((idx, item) {
        /*
        debugPrint("item.groupNama #A : ${item.groupNama}");
        debugPrint("item.hasIndex #A : ${item.hasIndex}");
        debugPrint("idx #A : $idx");
        */
        //listJobCatGroupId[idx] = item.mjobcatgroupId;
        listJobCatGroup.add(item);
        listTab.add(Text(item.groupNama));
        colorCollection.add(getTabColor(item.urutan));
      });

      return emit(state.copyWith(
          items: items,
          status: ListStatus.success,
          listJobCatGroup: listJobCatGroup,
          listTab: listTab,
          colorCollection: colorCollection));
    }
  }

  Future<void> onSelectedTab(
      SelectedJobRealTabEvent event, Emitter<JobRealTabState> emit) async {
    emit(state.copyWith(jobCatGroupId: event.jobCatGroupId));
  }

  Color getTabColor(int urutan) {
    Color color;

    switch (urutan) {
      case 10:
        color = const Color(0xFF0F8644);
        break;
      case 20:
        color = const Color(0xFF8B1FA9);
        break;
      case 30:
        color = const Color(0xFFD20100);
        break;
      case 40:
        color = const Color(0xFFFC571D);
        break;
      case 50:
        color = const Color(0xFF36B37B);
        break;
      case 60:
        color = const Color(0xFF01A1EF);
        break;
      case 70:
        color = const Color(0xFF3D4FB5);
        break;
      case 80:
        color = const Color(0xFFE47C73);
        break;
      case 90:
        color = const Color(0xFF636363);
        break;
      case 100:
        color = const Color(0xFF0A8043);
        break;
      default:
        color = const Color(0xff443a49);
    }

    return color;
  }
}
