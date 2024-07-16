import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combocustcat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/mstjob/jobcrud_bloc.dart';
import 'package:esalesapp/models/mstjob/jobcrud_model.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';
import 'package:esalesapp/widgets/combobox/combojobcat_widget.dart';
import 'package:esalesapp/common/thousand_separator_input_formatter.dart';
import 'package:intl/intl.dart';
import '../../widgets/combobox/combocustcat_widget.dart';

class JobCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const JobCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  JobCrudFormPageFormState createState() => JobCrudFormPageFormState();
}

class JobCrudFormPageFormState extends State<JobCrudFormPage> {
  late JobCrudBloc jobCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldJobNamaController = TextEditingController();
  ComboJobcatModel? fieldComboJobcat;
  ComboCustCatModel? fieldComboCustCat;
  final comboJobCatKey = GlobalKey<DropdownSearchState<ComboJobcatModel>>();
  final comboCustCatKey = GlobalKey<DropdownSearchState<ComboCustCatModel>>();
  var fieldurutRenewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    jobCrudBloc = BlocProvider.of<JobCrudBloc>(context);
    return BlocConsumer<JobCrudBloc, JobCrudState>(
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
                          "${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Task",
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
                        buildFieldComboCustCat(
                          enabled: false,
                          usage: "mjobcat",
                          comboKey: comboCustCatKey,
                          labelText: 'Customer Category',
                          initItem: fieldComboCustCat,
                          onChangedCallback: (value) {
                            if (value != null) {
                              removeError(
                                  error: "Field Category tidak boleh kosong.");
                              //fieldComboCustCat = value;
                              comboJobCatKey.currentState?.clear();
                              debugPrint(
                                  "comboCustCatKey.currentState?.getSelectedItem?.mcustcatId?? : ${comboCustCatKey.currentState?.getSelectedItem?.mcustcatId ?? 'not found'}");
                            }
                          },
                          onSaveCallback: (value) {
                            if (value != null) {
                              fieldComboCustCat = value;
                            }
                          },
                          validatorCallback: (value) {
                            if (value == null) {
                              addError(
                                  error: "Field Category tidak boleh kosong.");
                            }
                          },
                        ),
                        buildFieldComboJobcat(
                          comboKey: comboJobCatKey,
                          labelText: 'Job Category',
                          initItem: fieldComboJobcat,
                          custCatId: fieldComboCustCat?.mcustcatId ?? "",
                          /*
                          custCatId: comboCustCatKey
                                  .currentState?.getSelectedItem?.mcustcatId ??
                              "",
                          */
                          onChangedCallback: (value) {
                            if (value != null) {
                              removeError(
                                  error:
                                      "Field 'Category' tidak boleh kosong.");
                              fieldComboJobcat = value;
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
                                  error:
                                      "Field 'Category' tidak boleh kosong.");
                            }
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 3,
                          controller: fieldJobNamaController,
                          decoration: const InputDecoration(
                            labelText: "Task Name",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(
                                  error:
                                      "Field 'Task Name' tidak boleh kosong.");
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(
                                  error:
                                      "Field 'Task Name' tidak boleh kosong.");
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

                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 3,
                          controller: fieldurutRenewController,
                          decoration: const InputDecoration(
                            labelText: "No Urut",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
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
            ));
      },
      listener: (context, state) {
        debugPrint("JobCrudFormPage #10");
        if (state.isLoaded) {
          debugPrint("JobCrudFormPage -> listener");          
          debugPrint("JobCrudFormPage : idget.viewMode : ${widget.viewMode}");
          if (widget.viewMode == "ubah") {                        
            fieldJobNamaController.text = state.record!.jobNama;
            fieldComboJobcat = state.record!.comboJobcat;
            fieldComboCustCat = state.record!.comboCustCat;
            fieldurutRenewController.text =
              NumberFormat("#,###").format(state.record!.urutRenew); 
          } else if (widget.viewMode == "tambah") {
            fieldComboJobcat = state.comboJobCat;
            fieldComboCustCat = state.comboCustCat;
          }

          debugPrint(
              "fieldComboJobcat : ${jsonEncode(fieldComboJobcat?.toJson())}");
          debugPrint(
              "fieldComboCustCat : ${jsonEncode(fieldComboCustCat?.toJson())}");
        }
      },
    );
  }

  void loadData() {
    debugPrint("JobCrudFormPage -> loadData #10");
    if (widget.viewMode == "ubah") {
      jobCrudBloc.add(JobCrudLihatEvent(recordId: widget.recordId));
    }
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      JobCrudModel record = JobCrudModel(
        jobNama: fieldJobNamaController.text,
        mjobId: '',
        mjobcatId: fieldComboJobcat?.mjobcatId,
        urutRenew: double.parse(fieldurutRenewController.text.replaceAll(',', '')),		
      );
      if (widget.viewMode == "tambah") {
        jobCrudBloc.add(JobCrudTambahEvent(record: record));
      } else if (widget.viewMode == "ubah") {
        record.mjobId = jobCrudBloc.state.record!.mjobId;
        jobCrudBloc.add(JobCrudUbahEvent(record: record));
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
}
