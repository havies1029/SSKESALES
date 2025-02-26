import 'package:esalesapp/models/combobox/combocob_model.dart';
import 'package:esalesapp/models/combobox/combommstjobcat_model.dart';
import 'package:esalesapp/widgets/combobox/combocob_widget.dart';
import 'package:esalesapp/widgets/combobox/combommstjobcat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/mstproject/projectcrud_bloc.dart';
import 'package:esalesapp/models/mstproject/projectcrud_model.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/widgets/combobox/combocustomer_widget.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ProjectCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const ProjectCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  ProjectCrudFormPageFormState createState() => ProjectCrudFormPageFormState();
}

class ProjectCrudFormPageFormState extends State<ProjectCrudFormPage> {
  late ProjectCrudBloc projectCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldDatelineController =
      TextEditingController(text: DateTime.now().toIso8601String());
  ComboCustomerModel? fieldComboCustomer;
  ComboCobModel? fieldComboCob;
  ComboMMstJobcatModel? fieldComboMstJobCat;
  final comboCustomerKey = GlobalKey<DropdownSearchState<ComboCustomerModel>>();
  final comboCobKey = GlobalKey<DropdownSearchState<ComboCobModel>>();
  final comboMstJobCatKey =
      GlobalKey<DropdownSearchState<ComboMMstJobcatModel>>();
  var fieldProjectNamaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    projectCrudBloc = BlocProvider.of<ProjectCrudBloc>(context);
    return BlocConsumer<ProjectCrudBloc, ProjectCrudState>(
      builder: (context, state) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Master Project",
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Color(0xffff6101),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Hind',
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(height: 25),
                        cmdBuildComboCustomer(),
                        cmdBuildFieldProjectName(),
                        cmdBuildComboCOB(),
                        cmdBuildComboMstJobCat(),
                        cmdBuildFieldDateline(),
                        const SizedBox(height: 25),
                        FormError(
                          errors: errors,
                          key: null,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _dismissDialog();
                                  },
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(fontSize: 13.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    onSaveForm();
                                  },
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(fontSize: 13.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ));
      },
      listener: (context, state) {
        if (state.isLoaded) {
          if (state.record != null) {
            fieldDatelineController.text =
                state.record!.dateline.toIso8601String();
            fieldProjectNamaController.text = state.record!.projectNama;
          }
          fieldComboCustomer = state.comboCustomer;
          fieldComboCob = state.comboCob;
          fieldComboMstJobCat = state.comboMstJobCat;
          debugPrint("state.comboCob : ${state.comboCob.toString()}");
        }
      },
      buildWhen: (previous, current) {
        return (current.isLoaded);
      },
    );
  }

  void loadData() {
    debugPrint("loadData -> widget.viewMode : ${widget.viewMode}");
    if (widget.viewMode == "ubah") {
      projectCrudBloc.add(ProjectCrudLihatEvent(recordId: widget.recordId));
    }
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      debugPrint("onSaveForm -> errors :${errors.toString()}");
      if (errors.isEmpty) {
        _formKey.currentState!.save();
        ProjectCrudModel record = ProjectCrudModel(
          dateline: DateTime.parse(fieldDatelineController.text),
          mprojectId: '',
          mrekanId: fieldComboCustomer!.mrekanId,
          projectNama: fieldProjectNamaController.text,
          mcobId: fieldComboCob!.mcobId,
          mmstjobcatId: fieldComboMstJobCat!.mmstjobcatId,
        );
        debugPrint("onSaveForm -> fieldComboCob!.mcobId : ${fieldComboCob!.mcobId}");
        if (widget.viewMode == "tambah") {
          projectCrudBloc.add(ProjectCrudTambahEvent(record: record));
        } else if (widget.viewMode == "ubah") {
          record.mprojectId = projectCrudBloc.state.record!.mprojectId;
          projectCrudBloc.add(ProjectCrudUbahEvent(record: record));
        }

        _dismissDialog();
      }
    }
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  DropdownSearch<ComboCustomerModel> cmdBuildComboCustomer() {
    return buildFieldComboCustomer(
      comboKey: comboCustomerKey,
      labelText: 'Client',
      initItem: fieldComboCustomer,
      onChangedCallback: (value) {
        if (value != null) {
          if (value.mrekanId == "") {
            removeError(error: "Field 'Client' tidak boleh kosong.");
          }
          projectCrudBloc.add(ComboCustomerChangedEvent(comboCustomer: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboCustomer = value;
        }
      },
      validatorCallback: (value) {
        if (value?.mrekanId == "") {
          addError(error: "Field 'Client' tidak boleh kosong.");
        }
      },
    );
  }

  DropdownSearch<ComboCobModel> cmdBuildComboCOB() {
    return buildFieldComboCob(
      labelText: 'COB',
      initItem: fieldComboCob,
      onChangedCallback: (value) {
        if (value != null) {
          if (value.mcobId != "") {
            removeError(error: "Field 'COB' tidak boleh kosong.");
          }
          projectCrudBloc.add(ComboCobChangedEvent(comboCob: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboCob = value;
        }
      },
      validatorCallback: (value) {
        if (value?.mcobId == "") {
          addError(error: "Field 'COB' tidak boleh kosong.");
        }
      },
    );
  }

  DropdownSearch<ComboMMstJobcatModel> cmdBuildComboMstJobCat() {
    return buildFieldComboMMstJobcat(
      labelText: 'Task Category',
      initItem: fieldComboMstJobCat,
      comboKey: comboMstJobCatKey,
      rekanId: fieldComboCustomer?.mrekanId ?? "",
      onChangedCallback: (value) {
        if (value != null) {
          if (value.mmstjobcatId != "") {
            removeError(error: "Field 'Task Category' tidak boleh kosong.");
          }
          projectCrudBloc
              .add(ComboMstJobCatChangedEvent(comboMstJobCat: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMstJobCat = value;
        }
      },
      validatorCallback: (value) {
        if (value?.mmstjobcatId == "") {
          addError(error: "Field 'Task Category' tidak boleh kosong.");
        }
      },
    );
  }

  TextFormField cmdBuildFieldProjectName() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      controller: fieldProjectNamaController,
      decoration: const InputDecoration(
        labelText: "Project Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Field 'Project Name' harus diinput");
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: "Field 'Project Name' harus diinput");
          return "";
        }
        return null;
      },
    );
  }

  DateTimeFormField cmdBuildFieldDateline() {
    return DateTimeFormField(
      mode: DateTimeFieldPickerMode.date,
      dateFormat: DateFormat('dd/MM/yyyy'),
      initialValue: DateTime.tryParse(fieldDatelineController.text),
      decoration: const InputDecoration(
        labelText: "Dateline",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: (value) {
        if (value != null) {
          removeError(error: "Field 'Dateline' harus diinput");
          fieldDatelineController.text = value.toIso8601String();
        }
      },
      validator: (value) {
        if (value == null) {
          addError(error: "Field 'Dateline' harus diinput");
          return "";
        }
        return null;
      },
    );
  }
}
