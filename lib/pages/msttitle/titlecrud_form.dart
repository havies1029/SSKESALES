import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/msttitle/titlecrud_bloc.dart';
import 'package:esalesapp/models/msttitle/titlecrud_model.dart';

class TitleCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const TitleCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	TitleCrudFormPageFormState createState() => TitleCrudFormPageFormState();
}

class TitleCrudFormPageFormState extends State<TitleCrudFormPage> {
	late TitleCrudBloc titleCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldTitleDescController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		titleCrudBloc = BlocProvider.of<TitleCrudBloc>(context);
		return BlocConsumer<TitleCrudBloc, TitleCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Title",
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
											controller: fieldTitleDescController,
											decoration: const InputDecoration(
												labelText: "Title",
												floatingLabelBehavior: FloatingLabelBehavior.always,
											),
										),
										const SizedBox(height: 25),
										FormError(
											errors: errors,
											key: null,
										),
										Padding(
											padding: const EdgeInsets.all(8.0),
											child: SizedBox(
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
										),
									],
								)),
						),
					));
				},
				listener: (context, state) {
					if (state.isLoaded) {
						fieldTitleDescController.text = state.record!.titleDesc;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		titleCrudBloc.add(
			TitleCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			TitleCrudModel record = TitleCrudModel(
				mtitleId: '',
				titleDesc: fieldTitleDescController.text,
			);
			if (widget.viewMode == "tambah") {
				titleCrudBloc.add(TitleCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mtitleId = titleCrudBloc.state.record!.mtitleId;
				titleCrudBloc.add(TitleCrudUbahEvent(record: record));
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
