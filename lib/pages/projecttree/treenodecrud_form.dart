import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/projecttree/treenodecrud_bloc.dart';
import 'package:esalesapp/models/projecttree/treenodecrud_model.dart';


class TreenodeCrudFormPage extends StatefulWidget {
	final String prjtree1Id;
	final String viewMode;
	final String recordId;

	const TreenodeCrudFormPage({super.key, required this.prjtree1Id, required this.viewMode, required this.recordId});

	@override
	TreenodeCrudFormPageFormState createState() => TreenodeCrudFormPageFormState();
}

class TreenodeCrudFormPageFormState extends State<TreenodeCrudFormPage> {
	late TreenodeCrudBloc treenodeCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldPrjnodetypeIdController = TextEditingController();
	var fieldPrjtree1IdController = TextEditingController();
	var fieldPrjtree2ParentIdController = TextEditingController();
	var fieldRemarks1Controller = TextEditingController();
	var fieldRemarks2Controller = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		treenodeCrudBloc = BlocProvider.of<TreenodeCrudBloc>(context);
		return BlocConsumer<TreenodeCrudBloc, TreenodeCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Project",
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
											controller: fieldPrjnodetypeIdController,
											decoration: const InputDecoration(
												labelText: "prjnodetypeId",
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
											controller: fieldPrjtree1IdController,
											decoration: const InputDecoration(
												labelText: "prjtree1Id",
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
											controller: fieldPrjtree2ParentIdController,
											decoration: const InputDecoration(
												labelText: "prjtree2ParentId",
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
											controller: fieldRemarks1Controller,
											decoration: const InputDecoration(
												labelText: "remarks1",
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
											controller: fieldRemarks2Controller,
											decoration: const InputDecoration(
												labelText: "remarks2",
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
					));
				},
				listener: (context, state) {
					if (state.isLoaded) {
						if (state.record != null){
							fieldPrjnodetypeIdController.text = state.record!.prjnodetypeId;
							fieldPrjtree1IdController.text = state.record!.prjtree1Id;
							fieldPrjtree2ParentIdController.text = state.record!.prjtree2ParentId;
							fieldRemarks1Controller.text = state.record!.remarks1;
							fieldRemarks2Controller.text = state.record!.remarks2;
						}
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		treenodeCrudBloc.add(
			TreenodeCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			TreenodeCrudModel record = TreenodeCrudModel(
				prjnodetypeId: fieldPrjnodetypeIdController.text,
				prjtree1Id: fieldPrjtree1IdController.text,
				prjtree2Id: '',
				prjtree2ParentId: fieldPrjtree2ParentIdController.text,
				remarks1: fieldRemarks1Controller.text,
				remarks2: fieldRemarks2Controller.text,
			);
			if (widget.viewMode == "tambah") {
				treenodeCrudBloc.add(TreenodeCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.prjtree2Id = treenodeCrudBloc.state.record!.prjtree2Id;
				treenodeCrudBloc.add(TreenodeCrudUbahEvent(record: record));
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
