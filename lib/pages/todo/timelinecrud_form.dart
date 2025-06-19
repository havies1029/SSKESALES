import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/todo/timelinecrud_bloc.dart';
import 'package:esalesapp/models/todo/timelinecrud_model.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';
import 'package:esalesapp/widgets/combobox/combojobcat_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';

class TimelineCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const TimelineCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	TimelineCrudFormPageFormState createState() => TimelineCrudFormPageFormState();
}

class TimelineCrudFormPageFormState extends State<TimelineCrudFormPage> {
	late TimelineCrudBloc timelineCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldAktivitasController = TextEditingController();
	var fieldJamAkhirController = TextEditingController(text: DateTime.now().toIso8601String());
	var fieldJamMulaiController = TextEditingController(text: DateTime.now().toIso8601String());
	var fieldTglTimelineController = TextEditingController(text: DateTime.now().toIso8601String());
  ComboJobcatModel? fieldCombojobcat = const ComboJobcatModel();
  final comboReferralKey = GlobalKey<DropdownSearchState<ComboJobcatModel>>();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		timelineCrudBloc = BlocProvider.of<TimelineCrudBloc>(context);
		return BlocConsumer<TimelineCrudBloc, TimelineCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} To Do",
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
                    buildFieldTglTimeline(),
                    buildFieldJamMulai(),
                    buildFieldJamAkhir(),
                    buildFieldMjobcatId(labelText: ''),
                    buildFieldMjobId(),
										buildFieldAktivitas(),
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
							fieldAktivitasController.text = state.record!.aktivitas;
							fieldJamAkhirController.text = state.record!.jamAkhir.toIso8601String();
							fieldJamMulaiController.text = state.record!.jamMulai.toIso8601String();
							fieldTglTimelineController.text = state.record!.tglTimeline.toIso8601String();
              fieldCombojobcat = state.record!.combojobcat;
						}
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		timelineCrudBloc.add(
			TimelineCrudLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldTglTimeline(){
		return DateTimeFormField(
			mode: DateTimeFieldPickerMode.date,
			dateFormat: DateFormat('dd/MM/yyyy'),
			initialValue: DateTime.tryParse(fieldTglTimelineController.text),
			decoration: const InputDecoration(
				labelText: "Tanngal TimeLine",
				floatingLabelBehavior: FloatingLabelBehavior.always,
			),
			onChanged: (value) {
				if (value != null) {
				removeError(error: kStringNullError);
					fieldTglTimelineController.text = value.toIso8601String();
				}
			},
			validator: (value) {
				if (value == null) {
					addError(error: kStringNullError);
					return "";
				}
				return null;
			},
		);
	}

  Widget buildFieldJamMulai(){
		return DateTimeFormField(
			mode: DateTimeFieldPickerMode.date,
			dateFormat: DateFormat('HH:mm'),
			initialValue: DateTime.tryParse(fieldJamMulaiController.text),
			decoration: const InputDecoration(
				labelText: "Jam Mulai",
				floatingLabelBehavior: FloatingLabelBehavior.always,
			),
			onChanged: (value) {
				if (value != null) {
				removeError(error: kStringNullError);
					fieldJamMulaiController.text = value.toIso8601String();
				}
			},
			validator: (value) {
				if (value == null) {
					addError(error: kStringNullError);
					return "";
				}
				return null;
			},
		);
	}

  Widget buildFieldJamAkhir(){
		return DateTimeFormField(
			mode: DateTimeFieldPickerMode.date,
			dateFormat: DateFormat('HH:mm'),
			initialValue: DateTime.tryParse(fieldJamAkhirController.text),
			decoration: const InputDecoration(
				labelText: "Jam Akhir",
				floatingLabelBehavior: FloatingLabelBehavior.always,
			),
			onChanged: (value) {
				if (value != null) {
				removeError(error: kStringNullError);
					fieldJamAkhirController.text = value.toIso8601String();
				}
			},
			validator: (value) {
				if (value == null) {
					addError(error: kStringNullError);
					return "";
				}
				return null;
			},
		);
	}

  	Widget buildFieldMjobcatId({required String labelText}){
		return TextFormField(
      decoration: const InputDecoration(
				labelText: "Program",
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
		);
	}

  	Widget buildFieldMjobId(){
		return TextFormField(
      decoration: const InputDecoration(
				labelText: "Program Kerja",
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
		);
	}

	Widget buildFieldAktivitas(){
		return TextFormField(
			controller: fieldAktivitasController,
			decoration: const InputDecoration(
				labelText: "Aktivitas",
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
		);
	}


	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			TimelineCrudModel record = TimelineCrudModel(
				aktivitas: fieldAktivitasController.text,
				jamAkhir: DateTime.parse(fieldJamAkhirController.text),
				jamMulai: DateTime.parse(fieldJamMulaiController.text),
				tglTimeline: DateTime.parse(fieldTglTimelineController.text),
				timeline1Id: '',
        mjobcatId: fieldCombojobcat?.mjobcatId, combojobcat: null
			);
			if (widget.viewMode == "tambah") {
				timelineCrudBloc.add(TimelineCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.timeline1Id = timelineCrudBloc.state.record!.timeline1Id;
				timelineCrudBloc.add(TimelineCrudUbahEvent(record: record));
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
