import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/mststaff/staffcrud_bloc.dart';
import 'package:esalesapp/models/mststaff/staffcrud_model.dart';
import 'package:esalesapp/models/combobox/combojabatan_model.dart';
import 'package:esalesapp/widgets/combobox/combojabatan_widget.dart';
import 'package:intl/intl.dart';
import 'package:esalesapp/common/thousand_separator_input_formatter.dart';

class StaffCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const StaffCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  StaffCrudFormPageFormState createState() => StaffCrudFormPageFormState();
}

class StaffCrudFormPageFormState extends State<StaffCrudFormPage> {
  late StaffCrudBloc staffCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldAlamatController = TextEditingController();
  var fieldEmailController = TextEditingController();
  var fieldGajiController = TextEditingController();
  var fieldHpController = TextEditingController();
  var fieldKtpController = TextEditingController();
  ComboJabatanModel fieldComboJabatan = const ComboJabatanModel();
  var fieldStaffNamaController = TextEditingController();
  var fieldUangMakanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    staffCrudBloc = BlocProvider.of<StaffCrudBloc>(context);
    return BlocConsumer<StaffCrudBloc, StaffCrudState>(
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
                          "${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Karyawan",
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
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 3,
                          controller: fieldAlamatController,
                          decoration: const InputDecoration(
                            labelText: "Alamat",
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
                          controller: fieldEmailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
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
                          controller: fieldGajiController,
                          decoration: const InputDecoration(
                            labelText: "Gaji (Rp)",
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
                          controller: fieldHpController,
                          decoration: const InputDecoration(
                            labelText: "HP",
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
                          controller: fieldKtpController,
                          decoration: const InputDecoration(
                            labelText: "No. KTP",
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
                        buildFieldComboJabatan(
                          labelText: 'Jabatan',
                          initItem: fieldComboJabatan,
                          onChangedCallback: (value) {
                            if (value != null) {
                              removeError(error: "Jabatan tidak boleh kosong.");
                            }
                          },
                          validatorCallback: (value) {
                            if (value == null) {
                              addError(error: "Jabatan tidak boleh kosong.");
                            }
                          },
                          onSaveCallback: (value) {
                            fieldComboJabatan = value!;
                          },
                        ),
                        TextFormField(
                          controller: fieldStaffNamaController,
                          decoration: const InputDecoration(
                            labelText: "Nama Lengkap",
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
                          controller: fieldUangMakanController,
                          decoration: const InputDecoration(
                            labelText: "Uang Makan (Rp)",
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
            ));
      },
      listener: (context, state) {
        if (state.isLoaded) {
          fieldAlamatController.text = state.record!.alamat;
          fieldEmailController.text = state.record!.email;
          fieldGajiController.text =
              NumberFormat("#,###").format(state.record!.gaji);
          fieldHpController.text = state.record!.hp;
          fieldKtpController.text = state.record!.ktp;
          fieldComboJabatan = ComboJabatanModel(
              mjabatanId: state.record!.mjabatanId,
              jabatanDesc: state.record!.jabatanDesc!);
          fieldStaffNamaController.text = state.record!.staffNama;
          fieldUangMakanController.text =
              NumberFormat("#,###").format(state.record!.uangMakan);
        }
      },
    );
  }

  void loadData() {
    if (widget.viewMode == "ubah") {
      staffCrudBloc.add(StaffCrudLihatEvent(recordId: widget.recordId));
    }
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      StaffCrudModel record = StaffCrudModel(
        alamat: fieldAlamatController.text,
        email: fieldEmailController.text,
        gaji: double.parse(fieldGajiController.text.replaceAll(',', '')),
        hp: fieldHpController.text,
        ktp: fieldKtpController.text,
        mjabatanId: fieldComboJabatan.mjabatanId,
        mstaffId: '',
        staffNama: fieldStaffNamaController.text,
        uangMakan:
            double.parse(fieldUangMakanController.text.replaceAll(',', '')),
      );
      if (widget.viewMode == "tambah") {
        staffCrudBloc.add(StaffCrudTambahEvent(record: record));
      } else if (widget.viewMode == "ubah") {
        record.mstaffId = staffCrudBloc.state.record!.mstaffId;
        staffCrudBloc.add(StaffCrudUbahEvent(record: record));
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
