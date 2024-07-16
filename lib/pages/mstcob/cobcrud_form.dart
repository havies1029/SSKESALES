import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/mstcob/cobcrud_bloc.dart';
import 'package:esalesapp/models/mstcob/cobcrud_model.dart';


class CobCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const CobCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	CobCrudFormPageFormState createState() => CobCrudFormPageFormState();
}

class CobCrudFormPageFormState extends State<CobCrudFormPage> {
	late CobCrudBloc cobCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldCobNamaController = TextEditingController();
	var fieldShortNameController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		cobCrudBloc = BlocProvider.of<CobCrudBloc>(context);
		return BlocConsumer<CobCrudBloc, CobCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Class of Business",
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
											controller: fieldCobNamaController,
											decoration: const InputDecoration(
												labelText: "Class of Business",
												floatingLabelBehavior: FloatingLabelBehavior.always,
											),
											onChanged: (value) {
												if (value.isNotEmpty) {
													removeError(error: "Field 'Class of Business' tidak boleh kosong.");
												}
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: "Field 'Class of Business' tidak boleh kosong.");
													return "";
												}
												return null;
											},
										),
										TextFormField(
											controller: fieldShortNameController,
											decoration: const InputDecoration(
												labelText: "Short Name",
												floatingLabelBehavior: FloatingLabelBehavior.always,
											),
											onChanged: (value) {
												if (value.isNotEmpty) {
													removeError(error: "Field 'Short Name' tidak boleh kosong.");
												}
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: "Field 'Short Name' tidak boleh kosong.");
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
						fieldCobNamaController.text = state.record!.cobNama;
						fieldShortNameController.text = state.record!.shortName;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		cobCrudBloc.add(
			CobCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			CobCrudModel record = CobCrudModel(
				cobNama: fieldCobNamaController.text,
				mcobId: '',
				shortName: fieldShortNameController.text,
			);
			if (widget.viewMode == "tambah") {
				cobCrudBloc.add(CobCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mcobId = cobCrudBloc.state.record!.mcobId;
				cobCrudBloc.add(CobCrudUbahEvent(record: record));
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
