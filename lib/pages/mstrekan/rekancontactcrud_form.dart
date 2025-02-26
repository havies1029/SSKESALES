import 'package:esalesapp/models/combobox/combojabatan_model.dart';
import 'package:esalesapp/models/combobox/combotitle_model.dart';
import 'package:esalesapp/widgets/combobox/combojabatan_widget.dart';
import 'package:esalesapp/widgets/combobox/combotitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/mstrekan/rekancontactcrud_bloc.dart';
import 'package:esalesapp/models/mstrekan/rekancontactcrud_model.dart';
import 'package:esalesapp/models/combobox/comboinsurer_model.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RekanContactCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String mrekanId;
  final String recordId;

  const RekanContactCrudFormPage(
      {super.key, required this.viewMode, required this.recordId, required this.mrekanId});

  @override
  RekanContactCrudFormPageFormState createState() =>
      RekanContactCrudFormPageFormState();
}

class RekanContactCrudFormPageFormState
    extends State<RekanContactCrudFormPage> {
  late RekanContactCrudBloc rekanContactCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldContactNamaController = TextEditingController();
  var fieldEmailController = TextEditingController();
  ComboTitleModel? fieldComboTitle = const ComboTitleModel();
  ComboJabatanModel? fieldComboJabatan = const ComboJabatanModel();
  final comboInsurerKey = GlobalKey<DropdownSearchState<ComboInsurerModel>>();
  var fieldNoHpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    rekanContactCrudBloc = BlocProvider.of<RekanContactCrudBloc>(context);
    return BlocConsumer<RekanContactCrudBloc, RekanContactCrudState>(
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
                          "${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Contact Person",
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
                        buildFieldComboTitle(
                          labelText: 'Title',
                          initItem: fieldComboTitle,
                          onSaveCallback: (value) {
                            fieldComboTitle = value;
                          },
                          onChangedCallback: (value) {
                            if (value != null) {
                              removeError(error: "Title tidak boleh kosong.");
                            }
                          },
                          validatorCallback: (value) {
                            if (value == null) {
                              addError(error: "Title tidak boleh kosong.");
                            }
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 3,
                          controller: fieldContactNamaController,
                          decoration: const InputDecoration(
                            labelText: "Nama",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: "Nama Contact harus diisi.");
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: "Nama Contact harus diisi.");
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
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: fieldNoHpController,
                          decoration: const InputDecoration(
                            labelText: "No. Hand Phone",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: "Hand Phone harus diisi.");
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: "Hand Phone harus diisi.");
                              return "";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: fieldEmailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
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
        if (state.isLoaded) {
          fieldContactNamaController.text = state.record!.contactNama;
          fieldEmailController.text = state.record!.email;
          fieldNoHpController.text = state.record!.noHp;
          fieldComboTitle = state.record!.comboTitle;
          fieldComboJabatan = state.record!.comboJabatan;
        }
      },
    );
  }

  void loadData() {
    if (widget.viewMode == "ubah") {
      rekanContactCrudBloc
          .add(RekanContactCrudLihatEvent(recordId: widget.recordId));
    }
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      RekanContactCrudModel record = RekanContactCrudModel(
          contactNama: fieldContactNamaController.text,
          email: fieldEmailController.text,
          mcontactId: '',
          noHp: fieldNoHpController.text,
          mtitleId: fieldComboTitle?.mtitleId,
          mjabatanId: fieldComboJabatan?.mjabatanId,
          mrekanId: widget.mrekanId);
      if (widget.viewMode == "tambah") {
        rekanContactCrudBloc.add(RekanContactCrudTambahEvent(record: record));
      } else if (widget.viewMode == "ubah") {
        record.mcontactId = rekanContactCrudBloc.state.record!.mcontactId;
        rekanContactCrudBloc.add(RekanContactCrudUbahEvent(record: record));
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
