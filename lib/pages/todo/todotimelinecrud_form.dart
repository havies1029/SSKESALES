import 'package:esalesapp/pages/todo/todocompanylist_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/todo/todotimelinecrud_bloc.dart';
import 'package:esalesapp/models/todo/todotimelinecrud_model.dart';
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';
import 'package:esalesapp/widgets/combobox/combojobcatgroup_widget.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';


class TodoTimelineCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const TodoTimelineCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	TodoTimelineCrudFormPageFormState createState() => TodoTimelineCrudFormPageFormState();
}

class TodoTimelineCrudFormPageFormState extends State<TodoTimelineCrudFormPage> {
	late TodoTimelineCrudBloc todoTimelineCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldAktivitasController = TextEditingController();
	var fieldJamAkhirController = TextEditingController(text: DateTime.now().toIso8601String());
	var fieldJamMulaiController = TextEditingController(text: DateTime.now().toIso8601String());
	ComboJobcatgroupModel? fieldComboJobcatgroup;
	final comboJobcatgroupKey = GlobalKey<DropdownSearchState<ComboJobcatgroupModel>>();
	var fieldTglTimelineController = TextEditingController(text: DateTime.now().toIso8601String());

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		todoTimelineCrudBloc = BlocProvider.of<TodoTimelineCrudBloc>(context);
		return BlocConsumer<TodoTimelineCrudBloc, TodoTimelineCrudState>(
			builder: (context, state) {
				return SingleChildScrollView(
					child: Padding(
						padding: const EdgeInsets.all(8.0),
						child: Form(
							key: _formKey,
							child: Column(
								children: [
									const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              buildFieldTglTimeline(),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container()
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              buildFieldJamMulai(),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              buildFieldJamAkhir(),                                
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
				
									buildFieldMjobcatgroupId(),
				                    const SizedBox(height: 10),
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
												width: 100,
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
												width: 100,
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
				);
				},
				listener: (context, state) {
					if (state.isLoaded) {
						if (state.record != null){
							fieldAktivitasController.text = state.record!.aktivitas??"";
							fieldJamAkhirController.text = state.record!.jamAkhir?.toIso8601String()?? DateTime.now().toIso8601String();
							fieldJamMulaiController.text = state.record!.jamMulai?.toIso8601String()?? DateTime.now().toIso8601String();
							fieldTglTimelineController.text = state.record!.tglTimeline?.toIso8601String()?? DateTime.now().toIso8601String();
						}
						fieldComboJobcatgroup = state.comboJobcatgroup;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
      todoTimelineCrudBloc.add(
        TodoTimelineCrudLihatEvent(recordId: widget.recordId));
		}
    else if (widget.viewMode == "tambah") {
      todoTimelineCrudBloc.add(
        TodoTimelineCrudResetEvent());
    }
	}

	Widget buildFieldAktivitas(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldAktivitasController,
			decoration: const InputDecoration(
				labelText: "aktivitas",
				floatingLabelBehavior: FloatingLabelBehavior.always,
			),
			onChanged: (value) {
				if (value.isNotEmpty) {
					removeError(error: "Field Aktivitas tidak boleh kosong.");
				}
			},
			validator: (value) {
				if (value == null || value.isEmpty) {
					addError(error: "Field Aktivitas tidak boleh kosong.");
					return "";
				}
				return null;
			},
		);
	}

	Widget buildFieldJamAkhir(){
		return DateTimeFormField(
      canClear: false,
			mode: DateTimeFieldPickerMode.time,
			dateFormat: DateFormat('HH:mm'),
			initialValue: DateTime.tryParse(fieldJamAkhirController.text),
			decoration: const InputDecoration(
				labelText: "Jam Selesai",
				floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:Icon(Icons.access_alarm),
			),
			onChanged: (value) {
				if (value != null) {
				  removeError(error: "Jam Selesai tidak boleh kosong.");
					final mulai = DateTime.tryParse(fieldJamMulaiController.text);
          if (mulai != null && value.isBefore(mulai)) {
            final baru = value.add(const Duration(hours: -1));
            fieldJamMulaiController.text = baru.toIso8601String();
            setState(() {}); // trigger rebuild
          } else {
            fieldJamAkhirController.text = value.toIso8601String();
          }
				}
			},
			validator: (value) {
				if (value == null) {
					addError(error: "Jam Selesai tidak boleh kosong.");
					return "";
				}
				return null;
			},
		);
	}

	Widget buildFieldJamMulai(){
		return DateTimeFormField(
      canClear: false,
			mode: DateTimeFieldPickerMode.time,
      dateFormat: DateFormat('HH:mm'),
			initialValue: DateTime.tryParse(fieldJamMulaiController.text),
			decoration: const InputDecoration(
				labelText: "Jam Mulai",
				floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:Icon(Icons.access_alarm),
			),
			onChanged: (value) {
				if (value != null) {
					removeError(error: "Jam Mulai tidak boleh kosong.");
					fieldJamMulaiController.text = value.toIso8601String();

          final akhir = value.add(const Duration(hours: 1));
          fieldJamAkhirController.text = akhir.toIso8601String();
          setState(() {});
				}
			},
			validator: (value) {
				if (value == null) {
					addError(error: "Jam Mulai tidak boleh kosong.");
					return "";
				}
				return null;
			},
		);
	}

	Widget buildFieldMjobcatgroupId(){
		return buildFieldComboJobcatgroup(
			comboKey: comboJobcatgroupKey,
			labelText: 'Jenis Pekerjaan',
			initItem: fieldComboJobcatgroup,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field Jenis Pekerjaan tidak boleh kosong.");
					todoTimelineCrudBloc.add(ComboJobcatgroupChangedEvent(comboJobcatgroup: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboJobcatgroup = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field Jenis Pekerjaan tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldTglTimeline(){
		return DateTimeFormField(
      canClear: false,
			mode: DateTimeFieldPickerMode.date,
			dateFormat: DateFormat('dd/MM/yyyy'),
			initialValue: DateTime.tryParse(fieldTglTimelineController.text),
			decoration: const InputDecoration(
				labelText: "Tanggal",
				floatingLabelBehavior: FloatingLabelBehavior.always,
			),
			onChanged: (value) {
				if (value != null) {
					removeError(error: "Field Tanggal tidak boleh kosong.");
					fieldTglTimelineController.text = value.toIso8601String();
				}
			},
			validator: (value) {
				if (value == null) {
					addError(error: "Field Tanggal tidak boleh kosong.");
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
			TodoTimelineCrudModel record = TodoTimelineCrudModel(
				aktivitas: fieldAktivitasController.text,
				jamAkhir: DateTime.parse(fieldJamAkhirController.text),
				jamMulai: DateTime.parse(fieldJamMulaiController.text),
				mjobcatgroupId: fieldComboJobcatgroup?.mjobcatgroupId,
				tglTimeline: DateTime.parse(fieldTglTimelineController.text),
				timeline1Id: '',
			);
      		//debugPrint("record: ${record.toJson()}");
			if (widget.viewMode == "tambah") {
				todoTimelineCrudBloc.add(TodoTimelineCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.timeline1Id = todoTimelineCrudBloc.state.record!.timeline1Id;
				todoTimelineCrudBloc.add(TodoTimelineCrudUbahEvent(record: record));
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
