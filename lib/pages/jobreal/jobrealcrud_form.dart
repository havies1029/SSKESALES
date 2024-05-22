import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2grid_bloc.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/pages/jobreal/jobreal2cari_main.dart';
import 'package:esalesapp/pages/jobreal/jobreal2grid_list_widget.dart';
import 'package:esalesapp/pages/jobreal/jobrealcurd_foto.dart';
import 'package:esalesapp/widgets/combobox/combocustomer_widget.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
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
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldHasilController = TextEditingController();
  var fieldMateriController = TextEditingController();
  ComboJobModel? fieldComboJob;
  ComboJobcatModel? fieldComboJobcat;
  ComboMediaModel? fieldComboMedia;
  ComboCustomerModel? fieldComboCustomer;
  var fieldComboJobController = TextEditingController();
  var fieldPicNameController = TextEditingController();
  var fieldRealJamController = TextEditingController();
  var fieldRealTglController = TextEditingController();
  final comboJobKey = GlobalKey<DropdownSearchState<ComboJobModel>>();
  final comboJobCatKey = GlobalKey<DropdownSearchState<ComboJobcatModel>>();
  final comboCustomerKey = GlobalKey<DropdownSearchState<ComboCustomerModel>>();
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
    return BlocConsumer<JobRealCrudBloc, JobRealCrudState>(
      builder: (context, state) {
        return SingleChildScrollView(
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
                            child: DateTimeFormField(
                              mode: DateTimeFieldPickerMode.date,
                              dateFormat: DateFormat('dd/MM/yyyy'),
                              initialValue: DateTime.now(),
                              decoration: const InputDecoration(
                                labelText: "Tanggal",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              onSaved: (newValue) {
                                fieldRealTglController.text =
                                    newValue?.toIso8601String() ??
                                        DateTime.now().toIso8601String();
                              },
                              onChanged: (value) {
                                if (value != null) {
                                  removeError(
                                      error:
                                          "Field Tanggal tidak boleh kosong.");
                                  fieldRealTglController.text =
                                      value.toIso8601String();
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  addError(
                                      error:
                                          "Field Tanggal tidak boleh kosong.");
                                  return "";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DateTimeFormField(
                              mode: DateTimeFieldPickerMode.time,
                              dateFormat: DateFormat('HH:mm'),
                              initialValue: DateTime.now(),
                              decoration: const InputDecoration(
                                labelText: "Jam",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              onSaved: (newValue) {
                                fieldRealJamController.text =
                                    newValue?.toIso8601String() ??
                                        DateTime.now().toIso8601String();
                              },
                              onChanged: (value) {
                                if (value != null) {
                                  removeError(
                                      error: "Field Jam tidak boleh kosong.");
                                  fieldRealJamController.text =
                                      value.toIso8601String();
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  addError(
                                      error: "Field Jam tidak boleh kosong.");
                                  return "";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    buildFieldComboCustomer(
                      comboKey: comboCustomerKey,
                      labelText: 'Customer',
                      initItem: fieldComboCustomer,
                      onChangedCallback: (value) {
                        if (value != null) {
                          removeError(
                              error: "Field ComboInsurer tidak boleh kosong.");
                          fieldComboCustomer = value;
                          jobRealCrudBloc.add(
                              ComboCustomerJobRealCrudChangedEvent(
                                  comboCustomer: value));
                        }
                      },
                      onSaveCallback: (value) {
                        if (value != null) {
                          fieldComboCustomer = value;
                        }
                      },
                      validatorCallback: (value) {
                        if (value == null) {
                          addError(
                              error: "Field ComboInsurer tidak boleh kosong.");
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 3,
                      controller: fieldPicNameController,
                      decoration: const InputDecoration(
                        labelText: "PIC",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          removeError(error: "Field PIC tidak boleh kosong.");
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: "Field PIC tidak boleh kosong.");
                          return "";
                        }
                        return null;
                      },
                    ),
                    buildFieldComboJobcat(
                      comboKey: comboJobCatKey,
                      labelText: 'Group Task',
                      initItem: fieldComboJobcat,
                      onChangedCallback: (value) {
                        if (value != null) {
                          removeError(
                              error: "Field Group Task tidak boleh kosong.");

                          comboJobKey.currentState?.clear();
                          jobRealCrudBloc
                              .add(ComboJobcatChangedEvent(comboJobcat: value));
                        }
                      },
                      onSaveCallback: (value) {
                        if (value != null) {
                          fieldComboJobcat = value;
                        }
                      },
                      validatorCallback: (value) {
                        if (value == null) {
                          addError(
                              error: "Field Group Task tidak boleh kosong.");
                        }
                      },
                    ),
                    buildFieldComboJob(
                      comboKey: comboJobKey,
                      userEditTextController: fieldComboJobController,
                      labelText: 'Task',
                      initItem: fieldComboJob,
                      externalFilter: comboJobCatKey
                              .currentState?.getSelectedItem?.mjobcatId ??
                          "xx",
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
                      validatorCallback: (value) {
                        if (value == null) {
                          addError(error: "Field Task tidak boleh kosong.");
                        }
                      },
                    ),
                    TextFormField(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: "Field Perihal tidak boleh kosong.");
                          return "";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: "Field Feedback tidak boleh kosong.");
                          return "";
                        }
                        return null;
                      },
                    ),
                    buildFieldComboMedia(
                      labelText: 'Media',
                      initItem: fieldComboMedia,
                      onChangedCallback: (value) {
                        if (value != null) {
                          removeError(
                              error: "Field Media tidak boleh kosong.");
                          fieldComboMedia = value;
                        }
                      },
                      onSaveCallback: (value) {
                        if (value != null) {
                          fieldComboMedia = value;
                        }
                      },
                      validatorCallback: (value) {
                        if (value == null) {
                          addError(
                              error: "Field Media tidak boleh kosong.");
                        }
                      },
                    ),
                    Container(
                      height: 20,
                    ),
                    SizedBox(
                        height: 300,
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
                              //child: Container(),
                            ),
                            Align(
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
                            ),
                          ],
                        )),
                    Container(
                      height: 20,
                    ),
                    JobRealCrudFotoWidget(jobReal1Id: widget.recordId),
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
        );
      },
      listener: (context, state) {
        if (state.isLoaded) {
          debugPrint("state.isLoaded : ${state.isLoaded}");
          debugPrint(
              "state.record?.hasil ?? " " : ${state.record?.hasil ?? ""}");
          if (state.viewMode == "ubah") {
            fieldHasilController.text = state.record?.hasil ?? "";
            fieldMateriController.text = state.record?.materi ?? "";
            fieldPicNameController.text = state.record?.picName ?? "";
            fieldRealJamController.text =
                (state.record?.realJam ?? DateTime.now()).toIso8601String();
            fieldRealTglController.text =
                (state.record?.realTgl ?? DateTime.now()).toIso8601String();
            fieldComboJob = state.comboJob;
            fieldComboJobcat = state.comboJobCat;
            fieldComboMedia = state.comboMedia;
            fieldComboCustomer = state.comboCustomer;

            loadGridPolis(state.record?.jobreal1Id ?? "");
          }
        } 
      },
    );
  }

  void loadGridPolis(String jobreal1Id) {
    if (widget.viewMode == "ubah") {
      if (jobreal1Id.isNotEmpty) {
        jobReal2GridBloc.add(RefreshJobReal2ListEvent(jobreal1Id: jobreal1Id));
      }
    }
  }

  void loadData() {
    if (widget.viewMode == "ubah") {
      jobRealCrudBloc.add(JobRealCrudLihatEvent(recordId: widget.recordId));
    } else {
      debugPrint("JobRealCrudFormPage -> loadData #10");
      debugPrint("state.record?.hasil ?? "
          " : ${jobRealCrudBloc.state.record?.hasil ?? ""}");
      debugPrint(jobRealCrudBloc.state.record?.hasil ?? "hasil null");
    }
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void onSaveForm() {
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
      );

      if (widget.viewMode == "tambah") {
        jobRealCrudBloc.add(JobRealCrudTambahEvent(record: record));
      } else if (widget.viewMode == "ubah") {
        record.jobreal1Id = jobRealCrudBloc.state.record!.jobreal1Id;
        jobRealCrudBloc.add(JobRealCrudUbahEvent(record: record));
      }
      _dismissDialog();
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
}
