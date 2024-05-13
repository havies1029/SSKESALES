import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/blocs/jobreal/jobreal2list_bloc.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/pages/jobreal/jobreal2cari_main.dart';
import 'package:esalesapp/pages/jobreal/jobreal2grid_list_widget.dart';
import 'package:esalesapp/widgets/combobox/combocustomer_widget.dart';
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
  late JobReal2ListBloc jobReal2ListBloc;
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
  final jobKey = GlobalKey<DropdownSearchState<ComboJobModel>>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    jobRealCrudBloc = BlocProvider.of<JobRealCrudBloc>(context);
    jobReal2ListBloc = BlocProvider.of<JobReal2ListBloc>(context);
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
                              onChanged: (value) {
                                if (value != null) {
                                  removeError(error: kStringNullError);
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  addError(error: kStringNullError);
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
                              mode: DateTimeFieldPickerMode.date,
                              dateFormat: DateFormat('HH:mm'),
                              initialValue: DateTime.now(),
                              decoration: const InputDecoration(
                                labelText: "Jam",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  removeError(error: kStringNullError);
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  addError(error: kStringNullError);
                                  return "";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    buildFieldComboJobcat(
                      labelText: 'Group Task',
                      initItem: fieldComboJobcat,
                      onChangedCallback: (value) {
                        if (value != null) {
                          removeError(
                              error: "Field ComboJobcat tidak boleh kosong.");

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
                              error: "Field ComboJobcat tidak boleh kosong.");
                        }
                      },
                    ),
                    buildFieldComboJob(
                      comboKey: comboJobKey,
                      userEditTextController: fieldComboJobController,
                      labelText: 'Task',
                      initItem: fieldComboJob,
                      externalFilter: fieldComboJobcat?.mjobcatId ?? "",
                      onChangedCallback: (value) {
                        if (value != null) {
                          removeError(
                              error: "Field ComboJob tidak boleh kosong.");
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
                          addError(error: "Field ComboJob tidak boleh kosong.");
                        }
                      },
                    ),
                    buildFieldComboCustomer(
                      labelText: 'Customer',
                      initItem: fieldComboCustomer,
                      onChangedCallback: (value) {
                        if (value != null) {
                          removeError(
                              error: "Field ComboInsurer tidak boleh kosong.");
                          fieldComboCustomer = value;
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
                    buildFieldComboMedia(
                      labelText: 'Media',
                      initItem: fieldComboMedia,
                      onChangedCallback: (value) {
                        if (value != null) {
                          removeError(
                              error: "Field ComboMedia tidak boleh kosong.");
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
                              error: "Field ComboMedia tidak boleh kosong.");
                        }
                      },
                    ),
                    SizedBox(
                        height: 200, 
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          elevation: 2,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              const JobReal2GridListWidget(),
                              const Spacer(),                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [        
                                  GestureDetector(
                                    onTap: () {
                                      showDialogPickPolicy(context, state.record?.mrekanId??"",
                                      state.record?.mjobcatId??"", state.record?.jobreal1Id??"",
                                      "Customer Name ??");
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      size: 30,
                                    ),
                                  ),                          
                                ],
                              )                          
                            ],
                          ))),
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
                          removeError(error: kStringNullError);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: kStringNullError);
                          return "";
                        }
                        return null;
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
                          removeError(error: kStringNullError);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: kStringNullError);
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
                          removeError(error: kStringNullError);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: kStringNullError);
                          return "";
                        }
                        return null;
                      },
                    ),
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
          fieldHasilController.text = state.record?.hasil ?? "";
          fieldMateriController.text = state.record?.materi ?? "";
          fieldComboJob = state.comboJob;
          fieldComboJobcat = state.comboJobCat;
          fieldComboMedia = state.comboMedia;
          fieldComboCustomer = state.comboCustomer;
          fieldPicNameController.text = state.record?.picName ?? "";
          fieldRealJamController.text =
              (state.record?.realJam ?? DateTime.now()).toIso8601String();
          fieldRealTglController.text =
              (state.record?.realTgl ?? DateTime.now()).toIso8601String();
          loadGridPolis(state.record?.jobreal1Id ?? "");
        }
      },
    );
  }

  void loadGridPolis(String jobreal1Id) {
    if (widget.viewMode == "ubah") {
      if (jobreal1Id.isNotEmpty) {
        jobReal2ListBloc.add(RefreshJobReal2ListEvent(jobreal1Id: jobreal1Id));
      }
    }
  }

  void loadData() {
    if (widget.viewMode == "ubah") {
      jobRealCrudBloc.add(JobRealCrudLihatEvent(recordId: widget.recordId));
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

  void showDialogPickPolicy(BuildContext context, String custId,
    String jobcatId, String jobReal1Id, String custNama) {		
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {        
        return JobReal2CariMainPage(custId: custId, jobCatId: jobcatId, 
              jobReal1Id: jobReal1Id, custName: custNama,);
      }),
    );
	}
}
