import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:esalesapp/blocs/mstproject/projectlist_bloc.dart';
import 'package:esalesapp/blocs/mstproject/projectlist_filter_cubit.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/widgets/combobox/combocustomer_widget.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectlistFilterBar extends StatefulWidget {
  const ProjectlistFilterBar({super.key});

  @override
  State<ProjectlistFilterBar> createState() => ProjectlistFilterBarState();
}

class ProjectlistFilterBarState extends State<ProjectlistFilterBar> {
  final _formKey = GlobalKey<FormState>();
  ComboCustomerModel? fieldComboCustomer;
  late ProjectlistFilterCubit barCubit;
  late ProjectListBloc projectListBloc;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    barCubit = BlocProvider.of<ProjectlistFilterCubit>(context);
    projectListBloc = BlocProvider.of<ProjectListBloc>(context);
    return BlocConsumer<ProjectlistFilterCubit, ProjectlistFilterState>(
        builder: (context, state) {
          return Accordion(
              headerBorderColor: Colors.blueGrey,
              headerBorderColorOpened: Colors.transparent,
              // headerBorderWidth: 1,
              headerBackgroundColorOpened: Colors.green,
              contentBackgroundColor: Colors.white,
              contentBorderColor: Colors.green,
              contentBorderWidth: 3,
              contentHorizontalPadding: 5,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                  isOpen: true,
                  contentHorizontalPadding: 15,
                  contentVerticalPadding: 15,
                  leftIcon: const Icon(Icons.text_fields_rounded,
                      color: Colors.white),
                  header: Text('Filter Data', style: MyText.headerStyle()),
                  content: Row(
                    children: [
                      Flexible(
                        flex: 7,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildFieldComboCustomer(
                                labelText: 'Client',
                                initItem: fieldComboCustomer,
                                onChangedCallback: (value) {
                                  if (value != null) {
                                    barCubit.setRekanId(value.mrekanId);
                                  } else {
                                    barCubit.setRekanId("");
                                  }
                                },
                                onSaveCallback: (value) {},
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  hintText: 'Project ...',
                                ),
                                onChanged: (value) {                                  
                                  barCubit.setSearchText(value);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: IconButton(
                            icon: const Icon(
                              Icons.autorenew_rounded,
                              size: 35.0,
                            ),
                            onPressed: () {
                              projectListBloc.add(RefreshProjectListEvent(
                                  rekanId: state.rekanId,
                                  searchText: state.searchText));
                            }),
                      )
                    ],
                  ),
                ),
              ]);
        },
        listener: (context, state) {});
  }
}
