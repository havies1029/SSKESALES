import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/mstjabatan/jabatancrud_bloc.dart';
import 'package:esalesapp/models/mstjabatan/jabatancrud_model.dart';


class JabatanCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const JabatanCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	JabatanCrudFormPageFormState createState() => JabatanCrudFormPageFormState();
}

class JabatanCrudFormPageFormState extends State<JabatanCrudFormPage> {
	late JabatanCrudBloc jabatanCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldJabatanDescController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		jabatanCrudBloc = BlocProvider.of<JabatanCrudBloc>(context);
		return BlocConsumer<JabatanCrudBloc, JabatanCrudState>(
			builder: (context, state) {
				return Dialog(
					shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
					child: SingleChildScrollView(
						child: Padding(
							padding: const EdgeInsets.all(8.0),
							child: Form(
								key: _formKey,
								child: Column(
									children: [
										const SizedBox(height: 10),
										Text(
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Jabatan",
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
											controller: fieldJabatanDescController,
											decoration: const InputDecoration(
												labelText: "Jabatan",
												floatingLabelBehavior: FloatingLabelBehavior.always,
											),
											onChanged: (value) {
												if (value.isNotEmpty) {
													removeError(error: "Field 'Jabatan' tidak boleh kosong.");
												}
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: "Field 'Jabatan' tidak boleh kosong.");
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
					));
				},
				listener: (context, state) {
					if (state.isLoaded) {
						fieldJabatanDescController.text = state.record!.jabatanDesc;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		jabatanCrudBloc.add(
			JabatanCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			JabatanCrudModel record = JabatanCrudModel(
				mjabatanId: '',
				jabatanDesc: fieldJabatanDescController.text,
			);
			if (widget.viewMode == "tambah") {
				jabatanCrudBloc.add(JabatanCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mjabatanId = jabatanCrudBloc.state.record!.mjabatanId;
				jabatanCrudBloc.add(JabatanCrudUbahEvent(record: record));
			}
			_dismissDialog();
		}
	}

	void addError({required String error}) {
		if (!errors.contains(error)){
			setState(() {
				errors.add(error);
			});
		}
	}

	void removeError({required String error}) {
		if (errors.contains(error)){
			setState(() {
				errors.remove(error);
			});
		}
	}

}
