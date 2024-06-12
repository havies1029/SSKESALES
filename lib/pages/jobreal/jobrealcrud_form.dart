import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3grid_bloc.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/common/loading_indicator.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/combobox/comboinsurer_model.dart';
import 'package:esalesapp/pages/jobreal/jobreal2cari_main.dart';
import 'package:esalesapp/pages/jobreal/jobreal2grid_list_widget.dart';
import 'package:esalesapp/pages/jobreal/jobreal3cari_main.dart';
import 'package:esalesapp/pages/jobreal/jobreal3grid_list_widget.dart';
import 'package:esalesapp/pages/jobreal/jobrealcurd_foto.dart';
import 'package:esalesapp/widgets/combobox/combocustomer_widget.dart';
import 'package:esalesapp/widgets/combobox/comboinsurer_widget.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/models/jobreal/jobrealcrud_model.dart';
import 'package:esalesapp/models/combobox/combojob_model.dart';
import 'package:esalesapp/widgets/combobox/combojob_widget.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';
import 'package:esalesapp/widgets/combobox/combojobcat_widget.dart';
import 'package:esalesapp/models/combobox/combomedia_model.dart';
import 'package:esalesapp/widgets/combobox/combomedia_widget.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';

class JobRealCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const JobRealCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  JobRealCrudFormPageFormState createState() => JobRealCrudFormPageFormState();
}

class JobRealCrudFormPageFormState extends State<JobRealCrudFormPage> {
  late JobRealCrudBloc jobRealCrudBloc;
  late JobReal2GridBloc jobReal2GridBloc;
  late JobReal3GridBloc jobReal3GridBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldHasilController = TextEditingController();
  var fieldMateriController = TextEditingController();
  ComboJobModel? fieldComboJob;
  ComboJobcatModel? fieldComboJobcat;
  ComboMediaModel? fieldComboMedia;
  ComboCustomerModel? fieldComboCustomer;
  ComboInsurerModel? fieldComboInsurer;
  var fieldComboJobController = TextEditingController();
  var fieldPicNameController = TextEditingController();
  var fieldRealJamController = TextEditingController();
  var fieldRealTglController = TextEditingController();
  var fieldTaskDescController = TextEditingController();
  final comboJobKey = GlobalKey<DropdownSearchState<ComboJobModel>>();
  final comboJobCatKey = GlobalKey<DropdownSearchState<ComboJobcatModel>>();
  final comboCustomerKey = GlobalKey<DropdownSearchState<ComboCustomerModel>>();
  final comboInsurerKey = GlobalKey<DropdownSearchState<ComboInsurerModel>>();
  final jobKey = GlobalKey<DropdownSearchState<ComboJobModel>>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  void dispose() {
    debugPrint("JobRealCrudFormPage dispose #10");
    disposalController();
    super.dispose();
  }

  void disposalController() {
    fieldHasilController.dispose();
    fieldMateriController.dispose();
    fieldComboJobController.dispose();
    fieldPicNameController.dispose();
    fieldRealJamController.dispose();
    fieldRealTglController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    jobRealCrudBloc = BlocProvider.of<JobRealCrudBloc>(context);
    jobReal2GridBloc = BlocProvider.of<JobReal2GridBloc>(context);
    jobReal3GridBloc = BlocProvider.of<JobReal3GridBloc>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<JobReal3GridBloc, JobReal3GridState>(
            listenWhen: (previous, current) {
          return (current.status == ListStatus.success);
        }, listener: (context, state) {
          if (state.status == ListStatus.success) {
            debugPrint(
                "MultiBlocListener -> JobReal3GridBloc state.items : ${state.items.length}");
          }
        }),
      ],
      child: BlocConsumer<JobRealCrudBloc, JobRealCrudState>(
        builder: (context, state) {
          debugPrint("BlocConsumer -> state.isLoaded : ${state.isLoaded}");
          return (state.isLoaded || widget.viewMode == "tambah")
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: buildTanggalJob()),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: buildJamJob(),
                                  ),
                                ),
                              ],
                            ),
                            cmdBuildComboCustomer(),
                            cmdBuildComboInsurer(state),
                            buildFieldCustomerPIC(),
                            cmdBuildFieldComboJobCat(),
                            cmdBuildFieldComboJob(state),
                            buildFieldTaskDesc(state),
                            buildFieldPerihal(),
                            buildFieldFeedback(),
                            cmdBuildFieldMedia(),
                            buildGridSPPA(state),
                            buildGridCob(state),
                            Container(
                              height: 20,
                            ),
                            JobRealCrudFotoWidget(jobReal1Id: widget.recordId),
                            const SizedBox(height: 25),
                            FormError(
                              errors: errors,
                              key: null,
                            ),
                            buildBtnForm(state),
                          ],
                        )),
                  ),
                )
              : const LoadingIndicator();
        },
        buildWhen: (previous, current) {
          return (current.isLoaded);
        },
        listener: (context, state) {
          if (state.isLoaded) {
            debugPrint("listener -> state.isLoaded : ${state.isLoaded}");

            debugPrint("requireComboInsurer : ${state.requireComboInsurer}");

            fieldComboJob = state.comboJob;
            fieldComboJobcat = state.comboJobCat;
            fieldComboMedia = state.comboMedia;
            fieldComboCustomer = state.comboCustomer;
            fieldComboInsurer = state.comboInsurer;

            //debugPrint("fieldComboCustomer : ${jsonEncode(fieldComboCustomer?.toJson())}");
            //debugPrint("fieldComboJobcat : ${jsonEncode(fieldComboJobcat?.toJson())}");
            //debugPrint("state.comboJobCat?.mjobcatdoctypeId : ${state.comboJobCat?.mjobcatdoctypeId}");

            if (state.viewMode == "ubah") {
              fieldHasilController.text = state.record?.hasil ?? "";
              fieldMateriController.text = state.record?.materi ?? "";
              fieldPicNameController.text = state.record?.picName ?? "";
              fieldRealJamController.text =
                  (state.record?.realJam ?? DateTime.now()).toIso8601String();
              fieldRealTglController.text =
                  (state.record?.realTgl ?? DateTime.now()).toIso8601String();
              fieldTaskDescController.text = state.record?.taskDesc ?? "";

              /*
              fieldComboJob = state.record?.comboJob;
              fieldComboJobcat = state.record?.comboJobcat;
              fieldComboMedia = state.record?.comboMedia;
              fieldComboCustomer = state.record?.comboCustomer;
              fieldComboInsurer = state.record?.comboInsurer;
              */
              debugPrint(jsonEncode(fieldComboCustomer?.toJson()));

              debugPrint(
                  "fieldComboJobcat?.mjobcatdoctypeId : ${fieldComboJobcat?.mjobcatdoctypeId}");

              if (fieldComboJobcat?.mjobcatdoctypeId == "sppa") {
                loadGridPolis(state.record?.jobreal1Id ?? "");
              } else if (fieldComboJobcat?.mjobcatdoctypeId == "cob") {
                loadGridCob(state.record?.jobreal1Id ?? "");
              }
            }
            fieldComboJob = state.comboJob;
            fieldComboJobcat = state.comboJobCat;
            fieldComboMedia = state.comboMedia;
            fieldComboCustomer = state.comboCustomer;
            fieldComboInsurer = state.comboInsurer;
          }
        },
      ),
    );
  }

  void loadGridPolis(String jobreal1Id) {
    if (widget.viewMode == "ubah") {
      if (jobreal1Id.isNotEmpty) {
        jobReal2GridBloc.add(RefreshJobReal2ListEvent(jobreal1Id: jobreal1Id));
      }
    }
  }

  void loadGridCob(String jobreal1Id) {
    if (widget.viewMode == "ubah") {
      if (jobreal1Id.isNotEmpty) {
        jobReal3GridBloc.add(RefreshJobReal3GridEvent(jobreal1Id: jobreal1Id));
      }
    }
  }

  void loadData() {
    debugPrint("JobRealCrudFormPage -> loadData #10");
    if (widget.viewMode != "tambah") {
      jobRealCrudBloc.add(JobRealCrudLihatEvent(recordId: widget.recordId));
    }
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void removeErrValidation() {
    errors.clear();
  }

  int validateForm(bool isRequestConfirm, JobRealCrudState state) {
    var errorCount = 0;
    if (isRequestConfirm) {
      if (fieldRealTglController.text.isEmpty) {
        errorCount++;
        addError(error: "Field Tanggal tidak boleh kosong.");
      }
      if (fieldRealJamController.text.isEmpty) {
        errorCount++;
        addError(error: "Field Jam tidak boleh kosong.");
      }
      if (fieldPicNameController.text.isEmpty) {
        errorCount++;
        addError(error: "Field PIC tidak boleh kosong.");
      }
      if (fieldComboJobcat?.mjobcatId == "") {
        errorCount++;
        addError(error: "Field Task Category tidak boleh kosong.");
      }
      if (state.comboJobCat?.mjobcatdoctypeId != "others") {
        if (fieldComboJob?.mjobId == "") {
          errorCount++;
          addError(error: "Field Task tidak boleh kosong.");
        }
      }
      if (state.comboJobCat?.mjobcatdoctypeId == "others") {
        if (fieldTaskDescController.text.isEmpty) {
          errorCount++;
          addError(error: "Field Task Description tidak boleh kosong.");
        }
      }
      if (fieldMateriController.text.isEmpty) {
        errorCount++;
        addError(error: "Field Perihal tidak boleh kosong.");
      }
      if (fieldHasilController.text.isEmpty) {
        errorCount++;
        addError(error: "Field Feedback tidak boleh kosong.");
      }
      if (fieldComboMedia?.mmediaId == "") {
        errorCount++;
        addError(error: "Field Media tidak boleh kosong.");
      }
      if (state.comboJobCat?.mjobcatdoctypeId == "sppa") {
        if (jobReal2GridBloc.state.items.isEmpty) {
          errorCount++;
          addError(error: "Pilih salah satu SPPA.");
        }
      }
      if (state.comboJobCat?.mjobcatdoctypeId == "cob") {
        if (jobReal3GridBloc.state.items.isEmpty) {
          errorCount++;
          addError(error: "Pilih salah satu COB.");
        }
      }
      if (state.requireComboInsurer) {
        if (fieldComboInsurer?.mrekanId == "") {
          errorCount++;
          addError(error: "Field Insurer tidak boleh kosong.");
        }
      }
    }

    return errorCount;
  }

  void onSaveForm(bool isRequestConfirm, JobRealCrudState state) {
    debugPrint("onSaveForm #10");
    removeErrValidation();
    if (validateForm(isRequestConfirm, state) == 0) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        JobRealCrudModel record = JobRealCrudModel(
            hasil: fieldHasilController.text,
            jobreal1Id: '',
            materi: fieldMateriController.text,
            mjobId: fieldComboJob?.mjobId,
            mjobcatId: fieldComboJobcat?.mjobcatId,
            mmediaId: fieldComboMedia?.mmediaId,
            mrekanId: fieldComboCustomer?.mrekanId,
            picName: fieldPicNameController.text,
            realJam: DateTime.parse(fieldRealJamController.text),
            realTgl: DateTime.parse(fieldRealTglController.text),
            rdpartyId: fieldComboInsurer?.mrekanId,
            taskDesc: fieldTaskDescController.text,
            isConfirmed: isRequestConfirm);

        if (widget.viewMode == "tambah") {
          jobRealCrudBloc.add(JobRealCrudTambahEvent(record: record));
        } else if (widget.viewMode == "ubah") {
          debugPrint("onSaveForm #30");
          record.jobreal1Id = jobRealCrudBloc.state.record!.jobreal1Id;
          jobRealCrudBloc.add(JobRealCrudUbahEvent(record: record));
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

  void showDialogPickPolicy(BuildContext context) {
    String custId = fieldComboCustomer?.mrekanId ?? "";
    if (custId.isNotEmpty) {
      String custName = fieldComboCustomer?.rekanNama ?? "";
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return JobReal2CariMainPage(
            custId: custId,
            custName: custName,
            jobReal1Id: widget.recordId,
          );
        }),
      ).then((value) {
        //var viewMode = context.read<JobRealCrudBloc>().state.viewMode;
        //loadGridPolis(jobRealCrudBloc.state.record?.jobreal1Id ?? "");
        jobReal2GridBloc.add(ReloadGridJobReal2ListEvent());

        return null;
      });
    }
  }

  void showDialogPickCob(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return JobReal3CariMainPage(
          jobReal1Id: widget.recordId,
        );
      }),
    ).then((value) {
      debugPrint("showDialogPickCob -> closed");
      jobReal3GridBloc.add(ReloadGridJobReal3ListEvent());

      return null;
    });
  }

  void notifyDataSaved() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => SafeArea(
                child: SizedBox(
              height: 80,
              child: Text("Data has been saved!",
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_40)),
            )));
  }

  Widget buildBtnForm(JobRealCrudState state) {
    return Row(
      mainAxisAlignment: state.viewMode == "lihat"
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: AppData.kIsWeb ? 120 : MediaQuery.of(context).size.width * 0.3,
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
        state.viewMode != "lihat"
            ? SizedBox(
                width: AppData.kIsWeb
                    ? 120
                    : MediaQuery.of(context).size.width * 0.3,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      onSaveForm(false, state);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
              )
            : Container(),
        state.viewMode != "lihat"
            ? SizedBox(
                width: AppData.kIsWeb
                    ? 120
                    : MediaQuery.of(context).size.width * 0.3,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      onSaveForm(true, state);
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  DateTimeFormField buildTanggalJob() {
    return DateTimeFormField(
      mode: DateTimeFieldPickerMode.date,
      dateFormat: DateFormat('dd/MM/yyyy'),
      firstDate: DateTime.now().add(const Duration(days: -3)),
      initialValue: widget.viewMode == "tambah"
          ? DateTime.now()
          : DateTime.parse(fieldRealJamController.text),
      decoration: const InputDecoration(
        labelText: "Tanggal",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (newValue) {
        fieldRealTglController.text =
            newValue?.toIso8601String() ?? DateTime.now().toIso8601String();
      },
      onChanged: (value) {
        if (value != null) {
          removeError(error: "Field Tanggal tidak boleh kosong.");
          fieldRealTglController.text = value.toIso8601String();
        }
      },
    );
  }

  DateTimeFormField buildJamJob() {
    return DateTimeFormField(
      enableFeedback: false,
      mode: DateTimeFieldPickerMode.time,
      dateFormat: DateFormat('HH:mm'),
      initialValue: widget.viewMode == "tambah"
          ? DateTime.now()
          : DateTime.parse(fieldRealJamController.text),
      decoration: const InputDecoration(
        labelText: "Jam",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (newValue) {
        fieldRealJamController.text =
            newValue?.toIso8601String() ?? DateTime.now().toIso8601String();
      },
      onChanged: (value) {
        if (value != null) {
          removeError(error: "Field Jam tidak boleh kosong.");
          fieldRealJamController.text = value.toIso8601String();
        }
      },
    );
  }

  Widget cmdBuildComboCustomer() {
    return buildFieldComboCustomer(
      enabled: widget.viewMode != "lihat",
      comboKey: comboCustomerKey,
      labelText: 'Customer',
      initItem: fieldComboCustomer,
      onChangedCallback: (value) {
        if (value != null) {
          removeError(error: "Field Customer tidak boleh kosong.");
          comboJobKey.currentState?.clear();
          jobRealCrudBloc
              .add(ComboCustomerJobRealCrudChangedEvent(comboCustomer: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboCustomer = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          addError(error: "Field Customer tidak boleh kosong.");
        }
      },
    );
  }

  Widget cmdBuildComboInsurer(JobRealCrudState state) {
    return Visibility(
      visible: state.requireComboInsurer,
      child: buildFieldComboInsurer(
        enabled: widget.viewMode != "lihat",
        comboKey: comboInsurerKey,
        labelText: 'Insurer',
        initItem: fieldComboInsurer,
        onChangedCallback: (value) {
          if (value != null) {
            removeError(error: "Field Insurer tidak boleh kosong.");
            comboJobCatKey.currentState?.clear();
            comboJobKey.currentState?.clear();
            jobRealCrudBloc
                .add(ComboInsurerJobRealCrudChangedEvent(comboInsurer: value));
          }
        },
        onSaveCallback: (value) {
          if (value != null) {
            fieldComboInsurer = value;
          }
        },
        validatorCallback: (value) {
          if (value == null) {
            addError(error: "Field Insurer tidak boleh kosong.");
          }
        },
      ),
    );
  }

  TextFormField buildFieldCustomerPIC() {
    return TextFormField(
      enabled: widget.viewMode != "lihat",
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      controller: fieldPicNameController,
      decoration: const InputDecoration(
        labelText: "PIC",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: (value) {
        fieldPicNameController.text = value;
        if (value.isNotEmpty) {
          removeError(error: "Field PIC tidak boleh kosong.");
        }
      },
    );
  }

  Widget cmdBuildFieldComboJobCat() {
    return buildFieldComboJobcat(
      enabled: widget.viewMode != "lihat",
      comboKey: comboJobCatKey,
      labelText: 'Task Category',
      initItem: fieldComboJobcat,
      custCatId: fieldComboCustomer?.custCatId ?? "",
      //comboCustomerKey.currentState?.getSelectedItem?.custCatId ?? "",
      onChangedCallback: (value) {
        if (value != null) {
          removeError(error: "Field 'Task Category' tidak boleh kosong.");

          comboJobKey.currentState?.clear();
          fieldComboJob = const ComboJobModel();
          jobRealCrudBloc.add(ComboJobcatChangedEvent(comboJobcat: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboJobcat = value;
        }
      },
    );
  }

  Widget cmdBuildFieldComboJob(JobRealCrudState state) {
    return Visibility(
      visible: state.comboJobCat?.mjobcatdoctypeId != "others",
      child: buildFieldComboJob(
        enabled: widget.viewMode != "lihat",
        comboKey: comboJobKey,
        userEditTextController: fieldComboJobController,
        labelText: 'Task',
        initItem: fieldComboJob,
        jobCatId: fieldComboJobcat?.mjobcatId ?? "",
        //jobCatId: comboJobCatKey.currentState?.getSelectedItem?.mjobcatId ?? "",
        onChangedCallback: (value) {
          if (value != null) {
            removeError(error: "Field Task tidak boleh kosong.");
            fieldComboJob = value;
          }
        },
        onSaveCallback: (value) {
          if (value != null) {
            fieldComboJob = value;
          }
        },
      ),
    );
  }

  TextFormField buildFieldPerihal() {
    return TextFormField(
      enabled: widget.viewMode != "lihat",
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      controller: fieldMateriController,
      decoration: const InputDecoration(
        labelText: "Perihal",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Field Perihal tidak boleh kosong.");
        }
      },
    );
  }

  TextFormField buildFieldFeedback() {
    return TextFormField(
      enabled: widget.viewMode != "lihat",
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      controller: fieldHasilController,
      decoration: const InputDecoration(
        labelText: "Feedback",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Field Feedback tidak boleh kosong.");
        }
      },
    );
  }

  Widget cmdBuildFieldMedia() {
    return buildFieldComboMedia(
      enabled: widget.viewMode != "lihat",
      labelText: 'Media',
      initItem: fieldComboMedia,
      onChangedCallback: (value) {
        if (value != null) {
          removeError(error: "Field Media tidak boleh kosong.");
          fieldComboMedia = value;
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMedia = value;
        }
      },
    );
  }

  Visibility buildGridSPPA(JobRealCrudState state) {
    return Visibility(
      visible: state.comboJobCat?.mjobcatdoctypeId == "sppa",
      child: Column(
        children: [
          Container(
            height: 20,
          ),
          SizedBox(
              height: 250,
              child: Stack(
                children: [
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'List SPPA',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const JobReal2GridListWidget(),
                  ),
                  widget.viewMode != "lihat"
                      ? Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              showDialogPickPolicy(context);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 0, 0, 0),
                              radius: 20,
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 254),
                                radius: 19,
                                child: Icon(
                                  Icons.checklist,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              )),
        ],
      ),
    );
  }

  Visibility buildGridCob(JobRealCrudState state) {
    return Visibility(
      visible: state.comboJobCat?.mjobcatdoctypeId == "cob",
      child: Column(
        children: [
          Container(
            height: 20,
          ),
          SizedBox(
              height: 250,
              child: Stack(
                children: [
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'List COB',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    //child: Container(),
                    child: const JobReal3GridListWidget(),
                  ),
                  widget.viewMode != "lihat"
                      ? Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              showDialogPickCob(context);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 0, 0, 0),
                              radius: 20,
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 254),
                                radius: 19,
                                child: Icon(
                                  Icons.checklist,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              )),
        ],
      ),
    );
  }

  Visibility buildFieldTaskDesc(JobRealCrudState state) {
    return Visibility(
      visible: state.comboJobCat?.mjobcatdoctypeId == "others",
      child: Column(
        children: [
          Container(
            height: 20,
          ),
          TextFormField(
            enabled: widget.viewMode != "lihat",
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 3,
            controller: fieldTaskDescController,
            decoration: const InputDecoration(
              labelText: "Task Description",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(
                    error: "Field 'Task Description' tidak boleh kosong.");
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                addError(error: "Field 'Task Description' tidak boleh kosong.");
                return "";
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
