import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/mstjob/jobcrud_bloc.dart';
import 'package:esalesapp/models/mstjob/jobcrud_model.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';
import 'package:esalesapp/widgets/combobox/combojobcat_widget.dart';


class JobCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const JobCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	JobCrudFormPageFormState createState() => JobCrudFormPageFormState();
}

class JobCrudFormPageFormState extends State<JobCrudFormPage> {
	late JobCrudBloc jobCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldJobNamaController = TextEditingController();
	ComboJobcatModel? fieldComboJobcat;

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		jobCrudBloc = BlocProvider.of<JobCrudBloc>(context);
		return BlocConsumer<JobCrudBloc, JobCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Task",
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
											controller: fieldJobNamaController,
											decoration: const InputDecoration(
												labelText: "jobNama",
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
										buildFieldComboJobcat(
											labelText: 'mjobcatId',
											initItem: fieldComboJobcat,
											onChangedCallback: (value) {
												if (value != null) {
													removeError(
														error: "Field ComboJobcat tidak boleh kosong.");
													fieldComboJobcat = value;
												}
											},
											onSaveCallback: (value) {
												if (value != null) {
													fieldComboJobcat = value;
												}
											},
											validatorCallback: (value) {
												if (value == null) {
													addError(
														error: "Field ComboJobcat tidak boleh kosong.");
												}
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
						fieldJobNamaController.text = state.record!.jobNama;
						fieldComboJobcat = state.record!.comboJobcat;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		jobCrudBloc.add(
			JobCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			JobCrudModel record = JobCrudModel(
				jobNama: fieldJobNamaController.text,
				mjobId: '',
				mjobcatId: fieldComboJobcat?.mjobcatId,
			);
			if (widget.viewMode == "tambah") {
				jobCrudBloc.add(JobCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mjobId = jobCrudBloc.state.record!.mjobId;
				jobCrudBloc.add(JobCrudUbahEvent(record: record));
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
