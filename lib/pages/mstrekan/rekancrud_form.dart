import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combocustcat_model.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/models/combobox/combomarketing_model.dart';
import 'package:esalesapp/widgets/combobox/combocustcat_widget.dart';
import 'package:esalesapp/widgets/combobox/combocustomer_widget.dart';
import 'package:esalesapp/widgets/combobox/combomarketing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/mstrekan/rekancrud_bloc.dart';
import 'package:esalesapp/models/mstrekan/rekancrud_model.dart';
import 'package:esalesapp/models/combobox/combotitle_model.dart';
import 'package:esalesapp/widgets/combobox/combotitle_widget.dart';

class RekanCrudFormPage extends StatefulWidget {
  final String rekanTypeId;
  final String viewMode;
  final String recordId;

  const RekanCrudFormPage(
      {super.key,
      required this.rekanTypeId,
      required this.viewMode,
      required this.recordId});

  @override
  RekanCrudFormPageFormState createState() => RekanCrudFormPageFormState();
}

class RekanCrudFormPageFormState extends State<RekanCrudFormPage> {
  late RekanCrudBloc rekanCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldMtiperekanIdController = TextEditingController();
  ComboTitleModel? fieldComboTitle = const ComboTitleModel();
  var fieldRekanNamaController = TextEditingController();
  ComboCustCatModel? fieldComboCustCat = const ComboCustCatModel();
  ComboMarketingModel? fieldComboMarketing = const ComboMarketingModel();
  ComboCustomerModel? fieldComboReferral = const ComboCustomerModel();
  final comboReferralKey = GlobalKey<DropdownSearchState<ComboCustomerModel>>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    rekanCrudBloc = BlocProvider.of<RekanCrudBloc>(context);
    return BlocConsumer<RekanCrudBloc, RekanCrudState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),                    
                    buildFieldComboTitle(
                      labelText: 'Title',
                      initItem: fieldComboTitle,
                      onSaveCallback: (value) {
                        fieldComboTitle = value;
                      },
                    ),
                    TextFormField(
                      controller: fieldRekanNamaController,
                      decoration: const InputDecoration(
                        labelText: "Nama Lengkap",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          removeError(error: 'Nama tidak boleh kosong.');
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: 'Nama tidak boleh kosong.');
                          return "";
                        }
                        return null;
                      },
                    ),
                    buildFieldComboCustCat(
                      usage: "mcst",
                      labelText: 'Category',
                      initItem: fieldComboCustCat,
                      onChangedCallback: (value) {
                        if ((value != null) &&
                            (value.mcustcatId.isNotEmpty)) {
                          removeError(
                              error: "Field Category tidak boleh kosong.");
                          fieldComboCustCat = value;
                        }
                      },
                      onSaveCallback: (value) {
                        if (value != null) {
                          fieldComboCustCat = value;
                        }
                      },
                      validatorCallback: (value) {
                        if ((value == null) || (value.mcustcatId.isEmpty)) {
                          addError(
                              error: "Field Category tidak boleh kosong.");
                          return "";
                        }
                        return null;
                      },
                    ),
                    buildFieldComboMarketing(
                      labelText: 'Marketing',
                      initItem: fieldComboMarketing,
                      onChangedCallback: (value) {
                        if ((value != null) &&
                            (value.msalesId.isNotEmpty)) {
                          removeError(
                              error: "Field Marketing tidak boleh kosong.");
                          fieldComboMarketing = value;
                        }
                      },
                      onSaveCallback: (value) {
                        if (value != null) {
                          fieldComboMarketing = value;
                        }
                      },
                      validatorCallback: (value) {
                        if ((value == null) || (value.msalesId.isEmpty)) {
                          addError(
                              error: "Field Marketing tidak boleh kosong.");
                          return "";
                        }
                        return null;
                      },
                    ),
                    cmdBuildComboReferral(),
                    const SizedBox(height: 25),
                    FormError(
                      errors: errors,
                      key: null,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 120,
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
                          width: 120,
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
          fieldMtiperekanIdController.text = state.record!.mtiperekanId;
          fieldComboTitle = state.record!.comboTitle;
          fieldRekanNamaController.text = state.record!.rekanNama;
          fieldComboCustCat = state.record!.comboCustCat;
          fieldComboMarketing = state.record!.comboMarketing;
          fieldComboReferral = state.record!.comboReferral;
          //debugPrint("fieldComboReferral #20 : ${jsonEncode(fieldComboReferral?.toJson())}");
        }
      },
    );
  }

  void loadData() {
    if (widget.viewMode == "ubah") {
      rekanCrudBloc.add(RekanCrudLihatEvent(recordId: widget.recordId));
    }
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      debugPrint("onSaveForm #10");
      _formKey.currentState!.save();

      //debugPrint("fieldComboReferral #10 : ${fieldComboReferral?.toJson()}");

      RekanCrudModel record = RekanCrudModel(
          mrekanId: '',
          mtiperekanId: widget.rekanTypeId,
          mtitleId: fieldComboTitle?.mtitleId,
          rekanNama: fieldRekanNamaController.text,
          mcustcatId: fieldComboCustCat?.mcustcatId,
          msalesId: fieldComboMarketing?.msalesId,
          referralFrom: fieldComboReferral?.mrekanId);

      if (widget.viewMode == "tambah") {
        rekanCrudBloc.add(RekanCrudTambahEvent(record: record));
      } else if (widget.viewMode == "ubah") {
        record.mrekanId = rekanCrudBloc.state.record!.mrekanId;
        rekanCrudBloc.add(RekanCrudUbahEvent(record: record));
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

  Widget cmdBuildComboReferral() {
    return buildFieldComboCustomer(
      enabled: widget.viewMode != "lihat",
      comboKey: comboReferralKey,
      labelText: 'Referral from',
      initItem: fieldComboReferral,
      onSaveCallback: (value) {
        //if (value != null) {
        fieldComboReferral = value;
        //}
      },
    );
  }
}
