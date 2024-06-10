import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/mstjobgroup/jobgroupcrud_bloc.dart';
import 'package:esalesapp/models/mstjobgroup/jobgroupcrud_model.dart';


class JobGroupCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const JobGroupCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	JobGroupCrudFormPageFormState createState() => JobGroupCrudFormPageFormState();
}

class JobGroupCrudFormPageFormState extends State<JobGroupCrudFormPage> {
	late JobGroupCrudBloc jobGroupCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldGroupNameController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		jobGroupCrudBloc = BlocProvider.of<JobGroupCrudBloc>(context);
		return BlocConsumer<JobGroupCrudBloc, JobGroupCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Job Function",
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
											controller: fieldGroupNameController,
											decoration: const InputDecoration(
												labelText: "Job Function",
												floatingLabelBehavior: FloatingLabelBehavior.always,
											),
											onChanged: (value) {
												if (value.isNotEmpty) {
													removeError(error: "Field 'Job Function' tidak boleh kosong.");
												}
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: "Field 'Job Function' tidak boleh kosong.");
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
						fieldGroupNameController.text = state.record!.groupName;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		jobGroupCrudBloc.add(
			JobGroupCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			JobGroupCrudModel record = JobGroupCrudModel(
				groupName: fieldGroupNameController.text,
				mjobgroupId: '',
			);
			if (widget.viewMode == "tambah") {
				jobGroupCrudBloc.add(JobGroupCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mjobgroupId = jobGroupCrudBloc.state.record!.mjobgroupId;
				jobGroupCrudBloc.add(JobGroupCrudUbahEvent(record: record));
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
