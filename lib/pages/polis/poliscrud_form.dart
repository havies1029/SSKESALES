import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/widgets/combobox/combocustomer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/polis/poliscrud_bloc.dart';
import 'package:esalesapp/models/polis/poliscrud_model.dart';
import 'package:esalesapp/models/combobox/combocob_model.dart';
import 'package:esalesapp/widgets/combobox/combocob_widget.dart';
import 'package:intl/intl.dart';
import 'package:esalesapp/common/thousand_separator_input_formatter.dart';
import 'package:date_field/date_field.dart';

class PolisCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const PolisCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  PolisCrudFormPageFormState createState() => PolisCrudFormPageFormState();
}

class PolisCrudFormPageFormState extends State<PolisCrudFormPage> {
  late PolisCrudBloc polisCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldCstPremiController = TextEditingController();
  var fieldInsuredNamaController = TextEditingController();
  ComboCobModel? fieldComboCob;
  ComboCustomerModel? fieldComboCustomer;
  var fieldPeriodeAkhirController = TextEditingController();
  var fieldPeriodeAwalController = TextEditingController();
  var fieldPolisNoController = TextEditingController();
  var fieldTsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    polisCrudBloc = BlocProvider.of<PolisCrudBloc>(context);
    return BlocConsumer<PolisCrudBloc, PolisCrudState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),                    
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [ThousandsSeparatorInputFormatter()],
                      controller: fieldCstPremiController,
                      decoration: const InputDecoration(
                        labelText: "Premium",
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
                      textAlign: TextAlign.right,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 3,
                      controller: fieldInsuredNamaController,
                      decoration: const InputDecoration(
                        labelText: "Insured Name",
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
                    buildFieldComboCob(
                      labelText: 'COB',
                      initItem: fieldComboCob,
                      onChangedCallback: (value) {
                        if (value != null) {
                          removeError(
                              error: "Field ComboCob tidak boleh kosong.");
                          fieldComboCob = value;
                        }
                      },
                      onSaveCallback: (value) {
                        if (value != null) {
                          fieldComboCob = value;
                        }
                      },
                      validatorCallback: (value) {
                        if (value == null) {
                          addError(
                              error: "Field ComboCob tidak boleh kosong.");
                        }
                      },
                    ),
                    buildFieldComboCustomer(
                      labelText: 'Client',
                      initItem: fieldComboCustomer,
                      onChangedCallback: (value) {
                        if (value != null) {
                          removeError(
                              error: "Field Client tidak boleh kosong.");
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
                              error: "Field Client tidak boleh kosong.");
                        }
                      },
                    ),
                    DateTimeFormField(
                      mode: DateTimeFieldPickerMode.date,
                      dateFormat: DateFormat('dd/MM/yyyy'),
                      initialValue: DateTime.now(),
                      decoration: const InputDecoration(
                        labelText: "Period End",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                    DateTimeFormField(
                      mode: DateTimeFieldPickerMode.date,
                      dateFormat: DateFormat('dd/MM/yyyy'),
                      initialValue: DateTime.now(),
                      decoration: const InputDecoration(
                        labelText: "Period Start",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                    TextFormField(
                      controller: fieldPolisNoController,
                      decoration: const InputDecoration(
                        labelText: "Policy No",
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [ThousandsSeparatorInputFormatter()],
                      controller: fieldTsiController,
                      decoration: const InputDecoration(
                        labelText: "TSI",
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
                      textAlign: TextAlign.right,
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
          fieldCstPremiController.text =
              NumberFormat("#,###").format(state.record!.cstPremi);
          fieldInsuredNamaController.text = state.record!.insuredNama;
          fieldComboCob = state.record!.comboCob;
          fieldComboCustomer = state.record!.comboCustomer;
          fieldPeriodeAkhirController.text =
              state.record!.periodeAkhir.toIso8601String();
          fieldPeriodeAwalController.text =
              state.record!.periodeAwal.toIso8601String();
          fieldPolisNoController.text = state.record!.polisNo;
          fieldTsiController.text =
              NumberFormat("#,###").format(state.record!.tsi);
        }
      },
    );
  }

  void loadData() {
    if (widget.viewMode == "ubah") {
      polisCrudBloc.add(PolisCrudLihatEvent(recordId: widget.recordId));
    }
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint("fieldPeriodeAwalController.text : ${fieldPeriodeAwalController.text}");
      debugPrint("fieldPeriodeAkhirController.text : ${fieldPeriodeAkhirController.text}");
      PolisCrudModel record = PolisCrudModel(
        cstPremi:
            double.parse(fieldCstPremiController.text.replaceAll(',', '')),
        insuredNama: fieldInsuredNamaController.text,
        mcobId: fieldComboCob?.mcobId,
        mrekanId: fieldComboCustomer?.mrekanId,
        periodeAkhir: DateTime.tryParse(fieldPeriodeAkhirController.text) ??
            DateTime.now(),
        periodeAwal: DateTime.tryParse(fieldPeriodeAwalController.text) ??
            DateTime.now(),
        polisNo: fieldPolisNoController.text,
        polis1Id: '',
        tsi: double.parse(fieldTsiController.text.replaceAll(',', '')),
      );
      if (widget.viewMode == "tambah") {
        polisCrudBloc.add(PolisCrudTambahEvent(record: record));
      } else if (widget.viewMode == "ubah") {
        record.polis1Id = polisCrudBloc.state.record!.polis1Id;
        polisCrudBloc.add(PolisCrudUbahEvent(record: record));
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
