import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/projectplan/plancrud_bloc.dart';
import 'package:esalesapp/models/projectplan/plancrud_model.dart';
import 'package:esalesapp/models/combobox/combomproject_model.dart';
import 'package:esalesapp/widgets/combobox/combomproject_widget.dart';
import 'package:intl/intl.dart';
import 'package:esalesapp/common/thousand_separator_input_formatter.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';


class PlanCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const PlanCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	PlanCrudFormPageFormState createState() => PlanCrudFormPageFormState();
}

class PlanCrudFormPageFormState extends State<PlanCrudFormPage> {
	late PlanCrudBloc planCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldJobNamaController = TextEditingController();
	ComboMProjectModel? fieldComboMProject;
	final comboMProjectKey = GlobalKey<DropdownSearchState<ComboMProjectModel>>();
	var fieldPlanDurasiController = TextEditingController();
	var fieldPlanFinishController = TextEditingController(text: DateTime.now().toIso8601String());
	var fieldPlanStartController = TextEditingController(text: DateTime.now().toIso8601String());
	var fieldUrutanController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		planCrudBloc = BlocProvider.of<PlanCrudBloc>(context);
		return BlocConsumer<PlanCrudBloc, PlanCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Running Project",
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
										TextFormField(
										),
										buildFieldComboMProject(
                      rekanId: "",
											comboKey: comboMProjectKey,
											labelText: 'mprojectId',
											initItem: fieldComboMProject,
											onChangedCallback: (value) {
												if (value != null) {
													removeError(
														error: "Field ComboMProject tidak boleh kosong.");
													planCrudBloc.add(ComboMProjectChangedEvent(comboMProject: value));
												}
											},
											onSaveCallback: (value) {
												if (value != null) {
													fieldComboMProject = value;
												}
											},
											validatorCallback: (value) {
												if (value == null) {
													addError(
														error: "Field ComboMProject tidak boleh kosong.");
												}
											},
										),
										TextFormField(
											keyboardType: TextInputType.number,
											inputFormatters: [ThousandsSeparatorInputFormatter()],
											controller: fieldPlanDurasiController,
											decoration: const InputDecoration(
												labelText: "planDurasi",
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
										DateTimeFormField(
											mode: DateTimeFieldPickerMode.date,
											dateFormat: DateFormat('dd/MM/yyyy'),
											initialValue: DateTime.tryParse(fieldPlanFinishController.text),
											decoration: const InputDecoration(
												labelText: "planFinish",
												floatingLabelBehavior: FloatingLabelBehavior.always,
											),
											onChanged: (value) {
												if (value != null) {
													removeError(error: kStringNullError);
													fieldPlanFinishController.text = value.toIso8601String();
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
											initialValue: DateTime.tryParse(fieldPlanStartController.text),
											decoration: const InputDecoration(
												labelText: "planStart",
												floatingLabelBehavior: FloatingLabelBehavior.always,
											),
											onChanged: (value) {
												if (value != null) {
													removeError(error: kStringNullError);
													fieldPlanStartController.text = value.toIso8601String();
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
											keyboardType: TextInputType.number,
											inputFormatters: [ThousandsSeparatorInputFormatter()],
											controller: fieldUrutanController,
											decoration: const InputDecoration(
												labelText: "urutan",
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
						if (state.record != null){
							fieldJobNamaController.text = state.record!.jobNama;
							fieldPlanDurasiController.text = state.record!.planDurasi.toString();
							fieldPlanFinishController.text = state.record!.planFinish.toIso8601String();
							fieldPlanStartController.text = state.record!.planStart.toIso8601String();
							fieldUrutanController.text = state.record!.urutan.toString();
						}
						fieldComboMProject = state.comboMProject;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		planCrudBloc.add(
			PlanCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			PlanCrudModel record = PlanCrudModel(
				jobNama: fieldJobNamaController.text,
				mprojectId: fieldComboMProject?.mprojectId,
				planDurasi: int.parse(fieldPlanDurasiController.text),
				planFinish: DateTime.parse(fieldPlanFinishController.text),
				planStart: DateTime.parse(fieldPlanStartController.text),
				plan1Id: '',
				urutan: int.parse(fieldUrutanController.text),
			);
			if (widget.viewMode == "tambah") {
				planCrudBloc.add(PlanCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.plan1Id = planCrudBloc.state.record!.plan1Id;
				planCrudBloc.add(PlanCrudUbahEvent(record: record));
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
