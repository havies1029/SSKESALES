import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/blocs/briefing/briefinginfo_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3cari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobreal3grid_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealcari_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealglobal_cubit.dart';
import 'package:esalesapp/blocs/projectplan/planinfo_bloc.dart';
import 'package:esalesapp/blocs/soaclient/dnlist_bloc.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/common/loading_indicator.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/combobox/comboinsurer_model.dart';
import 'package:esalesapp/models/combobox/combomproject_model.dart';
import 'package:esalesapp/models/jobreal/jobreal2cari_model.dart';
import 'package:esalesapp/pages/jobreal/jobreal2cari_main.dart';
import 'package:esalesapp/pages/jobreal/jobreal2grid_list_widget.dart';
import 'package:esalesapp/pages/jobreal/jobreal3cari_main.dart';
import 'package:esalesapp/pages/jobreal/jobreal3grid_list_widget.dart';
import 'package:esalesapp/pages/jobreal/jobrealcurd_foto.dart';
import 'package:esalesapp/widgets/combobox/combocustomer_widget.dart';
import 'package:esalesapp/widgets/combobox/comboinsurer_widget.dart';
import 'package:esalesapp/widgets/combobox/combomproject_widget.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:esalesapp/widgets/speechtotext_widget.dart';
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
  final bool isBriefingHarianMode;
  final bool isSOAClientMode;
  final bool isProjectMode;

  const JobRealCrudFormPage(
      {super.key,
      required this.viewMode,
      required this.recordId,
      required this.isBriefingHarianMode,
      required this.isSOAClientMode,
      required this.isProjectMode});

  @override
  JobRealCrudFormPageFormState createState() => JobRealCrudFormPageFormState();
}

class JobRealCrudFormPageFormState extends State<JobRealCrudFormPage> {
  late JobRealCrudBloc jobRealCrudBloc;
  late JobReal2GridBloc jobReal2GridBloc;
  late JobReal3GridBloc jobReal3GridBloc;
  late JobRealGlobalCubit jobRealGlobalCubit;
  late JobRealCariBloc jobRealCariBloc;
  late BriefingInfoBloc briefingInfoBloc;
  late JobRealFotoBloc jobRealFotoBloc;
  late JobReal2CariBloc jobReal2CariBloc;
  late JobReal3CariBloc jobReal3CariBloc;
  late DnlistBloc dnlistBloc;
  late PlanInfoBloc planInfoBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldHasilController = TextEditingController();
  var fieldMateriController = TextEditingController();
  ComboJobModel? fieldComboJob;
  ComboJobcatModel? fieldComboJobcat;
  ComboMediaModel? fieldComboMedia;
  ComboCustomerModel? fieldComboCustomer;
  ComboInsurerModel? fieldComboInsurer;
  ComboMProjectModel? fieldComboProject;
  var fieldComboJobController = TextEditingController();
  var fieldPicNameController = TextEditingController();
  var fieldRealJamController =
      TextEditingController(text: DateTime.now().toIso8601String());
  var fieldRealTglController =
      TextEditingController(text: DateTime.now().toIso8601String());
  var fieldTaskDescController = TextEditingController();
  final comboJobKey = GlobalKey<DropdownSearchState<ComboJobModel>>();
  final comboJobCatKey = GlobalKey<DropdownSearchState<ComboJobcatModel>>();
  final comboCustomerKey = GlobalKey<DropdownSearchState<ComboCustomerModel>>();
  final comboInsurerKey = GlobalKey<DropdownSearchState<ComboInsurerModel>>();
  final comboProjectKey = GlobalKey<DropdownSearchState<ComboMProjectModel>>();
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
    //debugPrint("JobRealCrudFormPage dispose #10");
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
    fieldTaskDescController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint("JobRealCrudFormPageFormState #10");

    jobRealCrudBloc = BlocProvider.of<JobRealCrudBloc>(context);
    jobReal2GridBloc = BlocProvider.of<JobReal2GridBloc>(context);
    jobReal3GridBloc = BlocProvider.of<JobReal3GridBloc>(context);
    jobRealFotoBloc = BlocProvider.of<JobRealFotoBloc>(context);
    jobReal2CariBloc = BlocProvider.of<JobReal2CariBloc>(context);
    jobReal3CariBloc = BlocProvider.of<JobReal3CariBloc>(context);

    dnlistBloc = BlocProvider.of<DnlistBloc>(context);

    //debugPrint("JobRealCrudFormPageFormState #15");

    jobRealCariBloc = BlocProvider.of<JobRealCariBloc>(context);

    //debugPrint("JobRealCrudFormPageFormState #20");

    jobRealGlobalCubit = BlocProvider.of<JobRealGlobalCubit>(context);

    //debugPrint("JobRealCrudFormPageFormState #30");
    return MultiBlocListener(
      listeners: [
        BlocListener<JobReal3CariBloc, JobReal3CariState>(
            listener: (context, state) {
          if (state.isSaved) {
            jobReal3GridBloc
                .add(RefreshJobReal3GridEvent(jobreal1Id: widget.recordId));
          }
        }),
        BlocListener<JobReal2CariBloc, JobReal2CariState>(
            listener: (context, state) {
          if (state.isSaved) {
            jobReal2GridBloc
                .add(RefreshJobReal2ListEvent(jobreal1Id: widget.recordId));
          }
        }),
        BlocListener<JobRealFotoBloc, JobRealFotoState>(
          listener: (context, state) {
            //debugPrint("JobRealFotoBloc state.isUploaded ");

            if (state.isUploaded) {
              //debugPrint("JobRealFotoBloc state.isUploaded ");
              jobRealCrudBloc.add(SetFotoUploadedEvent());
            }
          },
          listenWhen: (previous, current) {
            return current.isUploaded;
          },
        ),
      ],
      child: BlocConsumer<JobRealCrudBloc, JobRealCrudState>(
        builder: (context, state) {
          //debugPrint("BlocConsumer -> state.isLoaded : ${state.isLoaded}");
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
                            cmdBuildComboProject(),
                            buildFieldCustomerPIC(),
                            cmdBuildFieldComboJobCat(),
                            cmdBuildFieldComboJob(state),
                            buildFieldTaskDesc(state),
                            buildFieldPerihal(),
                            buildFieldFeedback(),
                            cmdBuildFieldMedia(),
                            buildGridSPPA(state),
                            buildGridCob(state),
                            buildWidgetFoto(),
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
            //debugPrint("listener -> state.isLoaded : ${state.isLoaded}");
            //debugPrint("requireComboInsurer : ${state.requireComboInsurer}");
            fieldComboJob = state.comboJob;
            fieldComboJobcat = state.comboJobCat;
            fieldComboMedia = state.comboMedia;
            fieldComboCustomer = state.comboCustomer;
            fieldComboInsurer = state.comboInsurer;
            fieldComboProject = state.comboProject;

            //debugPrint("listener fieldComboProject : ${fieldComboProject.toString()}");

            if (state.viewMode != "tambah") {
              fieldHasilController.text = state.record?.hasil ?? "";
              fieldMateriController.text = state.record?.materi ?? "";
              fieldPicNameController.text = state.record?.picName ?? "";
              fieldRealJamController.text =
                  (state.record?.realJam ?? DateTime.now()).toIso8601String();
              fieldRealTglController.text =
                  (state.record?.realTgl ?? DateTime.now()).toIso8601String();
              fieldTaskDescController.text = state.record?.taskDesc ?? "";

              if (fieldComboJobcat?.mjobcatdoctypeId == "sppa") {
                loadGridPolis(state.record?.jobreal1Id ?? "");
              } else if (fieldComboJobcat?.mjobcatdoctypeId == "cob") {
                loadGridCob(state.record?.jobreal1Id ?? "");
              }
            } else if (widget.isBriefingHarianMode) {
              fieldPicNameController.text = state.record?.picName ?? "";
              fieldTaskDescController.text = state.record?.taskDesc ?? "";
              fieldMateriController.text = state.record?.materi ?? "";
            } else if (widget.isSOAClientMode) {
              fieldMateriController.text = state.record?.materi ?? "";
            }

            if (state.forceChangeComboCustomer) {
              //debugPrint("listener -> state.forceChangeComboCustomer");
              //undo combo changed
              comboCustomerKey.currentState
                  ?.changeSelectedItem(fieldComboCustomer);
            }
          }
        },
      ),
    );
  }

  void loadGridPolis(String jobreal1Id) {
    if (widget.viewMode != "tambah") {
      if (jobreal1Id.isNotEmpty) {
        jobReal2GridBloc.add(RefreshJobReal2ListEvent(jobreal1Id: jobreal1Id));
      }
    }
  }

  void loadGridCob(String jobreal1Id) {
    if (widget.viewMode != "tambah") {
      if (jobreal1Id.isNotEmpty) {
        jobReal3GridBloc.add(RefreshJobReal3GridEvent(jobreal1Id: jobreal1Id));
      }
    }
  }

  void loadData() {
    //debugPrint("JobRealCrudFormPage -> loadData #10");

    if (widget.viewMode != "tambah") {
      jobRealCrudBloc.add(JobRealCrudLihatEvent(recordId: widget.recordId));
    } else if (widget.isBriefingHarianMode) {
      briefingInfoBloc = BlocProvider.of<BriefingInfoBloc>(context);
      BriefingInfoState briefingState = briefingInfoBloc.state;

      //debugPrint("briefingState.selectedItem : ${jsonEncode(briefingState.selectedItem)}");

      jobRealCrudBloc.add(GetInitValueNewBriefingHarianModeEvent(
          jobId: briefingState.selectedItem.jobId,
          jobCatId: briefingState.selectedItem.jobCatId));
    } else if (widget.isSOAClientMode) {
      DnlistState dnState = dnlistBloc.state;
      jobRealCrudBloc
          .add(GetInitValueNewSOAClientModeEvent(dn1Id: dnState.selectedDNId));
    } else if (widget.isProjectMode) {
      planInfoBloc = BlocProvider.of<PlanInfoBloc>(context);
      PlanInfoState planState = planInfoBloc.state;
      jobRealCrudBloc.add(GetInitValueNewProjectTaskModeEvent(
          plan1Id: planState.selectedItem.plan1Id));
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
        if (fieldComboJob?.isReqDetail ?? false) {
          if (jobReal2GridBloc.state.items.isEmpty) {
            errorCount++;
            addError(error: "Pilih salah satu SPPA.");
          }
        }
      }
      if (state.comboJobCat?.mjobcatdoctypeId == "cob") {
        if (fieldComboJob?.isReqDetail ?? false) {
          if (jobReal3GridBloc.state.items.isEmpty) {
            errorCount++;
            addError(error: "Pilih salah satu COB.");
          }
        }
      }
      if (state.requireComboInsurer) {
        if (fieldComboInsurer?.mrekanId == "") {
          errorCount++;
          addError(error: "Field Insurer tidak boleh kosong.");
        }
      }

      //cek foto
      debugPrint("Check foto for a validation");
      bool hasPhoto = false;

      debugPrint("state.record!.hasFoto : ${state.record!.hasFoto}");
      if (state.record!.hasFoto) {
        debugPrint("state.record!.hasFoto : ${state.record!.hasFoto}");
        hasPhoto = true;
      }

      if (!hasPhoto) {
        JobRealFotoState fotoState = jobRealFotoBloc.state;

        if (AppData.kIsWeb) {
          debugPrint(
              "fotoState.fotoBytes?.length : ${fotoState.fotoBytes?.length}");
          if (fotoState.fotoBytes?.isNotEmpty ?? false) {
            debugPrint(
                "fotoState.fotoBytes?.isNotEmpty : ${fotoState.fotoBytes?.isNotEmpty}");
            hasPhoto = true;
          }
        } else {
          if (!hasPhoto) {
            debugPrint("fotoState.fotoPath : ${fotoState.fotoPath}");
            if (fotoState.fotoPath.isNotEmpty) {
              debugPrint(
                  "fotoState.fotoPath.isNotEmpty :${fotoState.fotoPath.isNotEmpty}");
              debugPrint("fotoState.fotoPath :${fotoState.fotoPath}");
              hasPhoto = true;
            }
          }
        }
      }

      if (!hasPhoto) {
        errorCount++;
        addError(error: "Dokumentasi foto tidak boleh kosong.");
      }
    }

    return errorCount;
  }

  void onSaveForm(bool isRequestConfirm, JobRealCrudState state,
      {bool dismissDialog = true}) {
    debugPrint("onSaveForm #10");
    removeErrValidation();
    if (validateForm(isRequestConfirm, state) == 0) {
      if (_formKey.currentState!.validate()) {
        //debugPrint("berhasil validasi form");
        //debugPrint("errors.isEmpty : ${errors.isEmpty}");

        if (errors.isEmpty) {
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
              isConfirmed: isRequestConfirm,
              projectId: fieldComboProject?.mprojectId ?? "");

          //debugPrint("fieldComboJobcat?.mjobcatId : ${fieldComboJobcat?.mjobcatId}");

          //debugPrint("widget.viewMode #103 : ${widget.viewMode}");
          if (widget.viewMode == "tambah") {
            List<JobReal2CariModel> listSelectedPolis =
                jobReal2GridBloc.state.items;

            //debugPrint("listSelectedPolis :${jsonEncode(listSelectedPolis)}");

            jobRealCrudBloc.add(JobRealCrudTambahEvent(
                record: record, selectedSppa: listSelectedPolis));
          } else if (widget.viewMode == "ubah") {
            //debugPrint("onSaveForm #30");
            record.jobreal1Id = jobRealCrudBloc.state.record!.jobreal1Id;
            jobRealCrudBloc.add(JobRealCrudUbahEvent(record: record));
          }
          if (dismissDialog) {
            _dismissDialog();
          }
        }
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
    debugPrint("showDialogPickPolicy");
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
        if (widget.viewMode == "tambah") {
          JobReal2CariBloc jobReal2CariBloc =
              BlocProvider.of<JobReal2CariBloc>(context);
          jobReal2GridBloc.add(GetPickedPoliciesJobReal2ListEvent(
              pickedPolicies: jobReal2CariBloc.state.selectedItems));
        }

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
      //jobReal3GridBloc.add(ReloadGridJobReal3ListEvent());

      if (widget.viewMode == "tambah") {
        /*
        JobReal3CariBloc jobReal3CariBloc =
            BlocProvider.of<JobReal3CariBloc>(context);            
            */
        jobReal3GridBloc.add(GetPickedCobJobReal3ListEvent(
            pickedCob: jobReal3CariBloc.state.selectedItems));
      }

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

  int maxDays2BackDate() {
    //angka 1 mulai dari minggu
    int dayOfWeek = DateTime.now().weekday;
    int backDays = 0;

    //debugPrint("dayOfWeek : $dayOfWeek");

    backDays = (dayOfWeek <= 3)
        ? 5
        : (dayOfWeek == 7)
            ? 4
            : 3;

    return backDays * -1;
  }

  DateTimeFormField buildTanggalJob() {
    //debugPrint("buildTanggalJob : ${DateTime.tryParse(fieldRealTglController.text)}");
    return DateTimeFormField(
      mode: DateTimeFieldPickerMode.date,
      dateFormat: DateFormat('dd/MM/yyyy'),
      firstDate: DateTime.now().add(Duration(days: maxDays2BackDate())),
      initialValue: DateTime.tryParse(fieldRealTglController.text),
      /*
      initialValue: widget.viewMode == "tambah"
          ? DateTime.now()
          : DateTime.tryParse(fieldRealTglController.text),
      */
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
    //debugPrint("buildJamJob : ${DateTime.tryParse(fieldRealJamController.text)}");
    return DateTimeFormField(
      enableFeedback: false,
      mode: DateTimeFieldPickerMode.time,
      dateFormat: DateFormat('HH:mm'),
      initialValue: DateTime.tryParse(fieldRealJamController.text),
      /*
      initialValue: widget.viewMode == "tambah"
          ? DateTime.now()
          : DateTime.tryParse(fieldRealJamController.text),
      */
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
      enabled: (widget.viewMode != "lihat" && (!widget.isProjectMode)),
      comboKey: comboCustomerKey,
      labelText: 'Customer',
      initItem: fieldComboCustomer,
      onChangedCallback: (value) {
        //debugPrint("cmdBuildComboCustomer -> onChangedCallback ");
        comboProjectKey.currentState?.clear();
        if (value != null) {
          if ((fieldComboCustomer?.mrekanId == "") ||
              (jobRealCrudBloc.state.forceChangeComboCustomer)) {
            onComboCustomerChangeTaskA(value);
            if (jobRealCrudBloc.state.forceChangeComboCustomer) {
              jobRealCrudBloc
                  .add(FinishedUndoComboCustomerJobRealCrudChangedEvent());
            }
          } else {
            if (isSudahAdaSPPA()) {
              confirmCustomerChange(value);
            } else {
              onComboCustomerChangeTaskA(value);
            }
          }
          removeError(error: "Field Customer tidak boleh kosong.");
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

  void onComboCustomerChangeTaskA(newValue) {
    //comboJobKey.currentState?.clear();
    jobRealCrudBloc
        .add(ComboCustomerJobRealCrudChangedEvent(comboCustomer: newValue));
  }

  void onComboCustomerChangeTaskB() {
    //reset sppa
    debugPrint("state.forceChangeComboCustomer -> reset sppa");
    jobReal2GridBloc
        .add(DeleteAllJobReal2ListEvent(jobreal1Id: widget.recordId));
  }

  bool isSudahAdaSPPA() {
    return jobReal2GridBloc.state.items.isNotEmpty;
  }

  void confirmCustomerChange(newValue) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Perhatian!"),
              content: const Text(
                  "Perubahan Customer akan menghapus list SPPA sebelumnya.\nApakah Anda yakin untuk menghapus data ini?"),
              actions: [
                TextButton(
                  child: const Text("Ya"),
                  onPressed: () {
                    debugPrint("showDialog => Tab : Ya");
                    onComboCustomerChangeTaskA(newValue);
                    onComboCustomerChangeTaskB();
                    onSaveForm(false, jobRealCrudBloc.state,
                        dismissDialog: false);
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text("Batal"),
                  onPressed: () {
                    Navigator.pop(context, "Batal");
                  },
                ),
              ]);
        }).then((value) {
      if (value == "Batal") {
        debugPrint(
            "confirmCustomerChange -> fieldComboCustomer : ${fieldComboCustomer?.rekanNama}");

        jobRealCrudBloc.add(UndoComboCustomerJobRealCrudChangedEvent(
            comboCustomer: fieldComboCustomer));
      }
    });
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
      enabled: (widget.viewMode != "lihat" && (!widget.isProjectMode)),
      comboKey: comboJobCatKey,
      labelText: 'Task Category',
      initItem: fieldComboJobcat,
      custCatId: fieldComboCustomer?.custCatId ?? "",
      jobCatGroupId:
          jobRealGlobalCubit.state.selectedJobCatGroup.mjobcatgroupId,
      onChangedCallback: (value) {
        if (value != null) {
          removeError(error: "Field 'Task Category' tidak boleh kosong.");

          comboJobKey.currentState?.clear();
          fieldComboJob = const ComboJobModel();
          fieldComboJobcat = value;
          jobRealCrudBloc.add(ComboJobcatChangedEvent(comboJobcat: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboJobcat = value;
        }
      },
      validatorCallback: (value) {
        //debugPrint("FieldComboJobCat =====>>>>>> validatorCallback");
        //debugPrint("value?.mjobcatId.isEmpty : ${value?.mjobcatId.isEmpty}");
        if ((value == null) || (value.mjobcatId.isEmpty)) {
          //debugPrint("validasi -> error");
          addError(error: "Field 'Task Category' tidak boleh kosong.");
          return "";
        }
      },
    );
  }

  Widget cmdBuildFieldComboJob(JobRealCrudState state) {
    return Visibility(
      //visible: state.comboJobCat?.mjobcatdoctypeId != "others",
      visible: true,
      child: buildFieldComboJob(
        enabled: (widget.viewMode != "lihat" && (!widget.isProjectMode)),
        comboKey: comboJobKey,
        userEditTextController: fieldComboJobController,
        labelText: 'Task',
        initItem: fieldComboJob,
        jobCatId: fieldComboJobcat?.mjobcatId ?? "",
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
      decoration: InputDecoration(
          labelText: "Perihal",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
            mainAxisSize: MainAxisSize.min, // added line
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
                mainAxisSize: MainAxisSize.min, // added line
                children: [
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      fieldMateriController.text = "";
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const SpeechToTextWidget();
                          }),
                        ).then((value) {
                          debugPrint("value : $value");
                          if (value != null) {
                            String message = value as String;
                            if (message.isNotEmpty) {
                              if (fieldMateriController.text.isNotEmpty) {
                                fieldMateriController.text += ' ';
                              }
                              fieldMateriController.text += value;
                            }
                          }
                        });
                      },
                      icon: const Icon(Icons.mic)),
                ],
              ),
            ],
          )),
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
      decoration: InputDecoration(
          labelText: "Feedback",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
            mainAxisSize: MainAxisSize.min, // added line
            children: [
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  fieldHasilController.text = "";
                },
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const SpeechToTextWidget();
                      }),
                    ).then((value) {
                      debugPrint("value : $value");
                      if (value != null) {
                        String message = value as String;
                        if (message.isNotEmpty) {
                          if (fieldHasilController.text.isNotEmpty) {
                            fieldHasilController.text += ' ';
                          }
                          fieldHasilController.text += value;
                        }
                      }
                    });
                  },
                  icon: const Icon(Icons.mic)),
            ],
          )),
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
    //debugPrint("buildGridSPPA");
    //debugPrint("state.comboJobCat : ${state.comboJobCat?.toJson()}");
    //debugPrint("state.comboJobCat?.mjobcatdoctypeId : ${state.comboJobCat?.mjobcatdoctypeId}");
    return Visibility(
      visible: (state.comboJobCat?.mjobcatdoctypeId == "sppa"),
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
                          borderSide: const BorderSide(width: 3)),
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
                                  Icons.check_box_outlined,
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

  Visibility buildWidgetFoto() {
    return Visibility(
        //visible: !(widget.viewMode == "tambah" && AppData.kIsWeb),
        visible: true,
        child: Column(
          children: [
            Container(
              height: 20,
            ),
            JobRealCrudFotoWidget(jobReal1Id: widget.recordId),
          ],
        ));
  }

  Visibility buildGridCob(JobRealCrudState state) {
    return Visibility(
      visible: state.comboJobCat?.mjobcatdoctypeId == "cob",
      /*
      visible: ((state.comboJobCat?.mjobcatdoctypeId == "cob") &&
          !(widget.viewMode == "tambah" && AppData.kIsWeb)),
      */
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
                  (widget.viewMode != "lihat" && (! widget.isProjectMode))
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

  Widget cmdBuildComboProject() {
    return Visibility(
      visible: ((jobRealGlobalCubit.state.selectedJobCatGroup.mjobcatgroupId ==
                  "10010" ||
              jobRealGlobalCubit.state.selectedJobCatGroup.mjobcatgroupId ==
                  "10030" ||
              widget.isProjectMode)
          ? true
          : false),
      child: buildFieldComboMProject(
        enabled: (widget.viewMode != "lihat" && (!widget.isProjectMode)),
        labelText: 'Project',
        initItem: fieldComboProject,
        rekanId: fieldComboCustomer?.mrekanId ?? "",
        comboKey: comboProjectKey,
        onChangedCallback: (value) {
          if (value != null) {
            jobRealCrudBloc
                .add(ComboProjectJobRealCrudChangedEvent(comboProject: value));
          }
        },
        onSaveCallback: (value) {
          if (value != null) {
            fieldComboProject = value;
          }
        },
      ),
    );
  }
}
