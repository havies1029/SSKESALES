import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/mstjobcat/jobcatcrud_bloc.dart';
import 'package:esalesapp/models/mstjobcat/jobcatcrud_model.dart';


class JobCatCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const JobCatCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	JobCatCrudFormPageFormState createState() => JobCatCrudFormPageFormState();
}

class JobCatCrudFormPageFormState extends State<JobCatCrudFormPage> {
	late JobCatCrudBloc jobCatCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldCatNameController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		jobCatCrudBloc = BlocProvider.of<JobCatCrudBloc>(context);
		return BlocConsumer<JobCatCrudBloc, JobCatCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Task Category",
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
											controller: fieldCatNameController,
											decoration: const InputDecoration(
												labelText: "catName",
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
						fieldCatNameController.text = state.record!.catName;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		jobCatCrudBloc.add(
			JobCatCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			JobCatCrudModel record = JobCatCrudModel(
				catName: fieldCatNameController.text,
				mjobcatId: '',
			);
			if (widget.viewMode == "tambah") {
				jobCatCrudBloc.add(JobCatCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mjobcatId = jobCatCrudBloc.state.record!.mjobcatId;
				jobCatCrudBloc.add(JobCatCrudUbahEvent(record: record));
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
