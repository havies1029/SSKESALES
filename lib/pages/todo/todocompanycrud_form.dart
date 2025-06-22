import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/todo/todocompanycrud_bloc.dart';
import 'package:esalesapp/models/todo/todocompanycrud_model.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/widgets/combobox/combocustomer_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';


class TodoCompanyCrudFormPage extends StatefulWidget {
	final String timeline1Id;
	final String viewMode;
	final String recordId;

	const TodoCompanyCrudFormPage({super.key, required this.timeline1Id, required this.viewMode, required this.recordId});

	@override
	TodoCompanyCrudFormPageFormState createState() => TodoCompanyCrudFormPageFormState();
}

class TodoCompanyCrudFormPageFormState extends State<TodoCompanyCrudFormPage> {
	late TodoCompanyCrudBloc todoCompanyCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	ComboCustomerModel? fieldComboCustomer;
	final comboCustomerKey = GlobalKey<DropdownSearchState<ComboCustomerModel>>();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		todoCompanyCrudBloc = BlocProvider.of<TodoCompanyCrudBloc>(context);
		return BlocConsumer<TodoCompanyCrudBloc, TodoCompanyCrudState>(
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
										buildFieldComboCustomer(
											comboKey: comboCustomerKey,
											labelText: 'Customer',
											initItem: fieldComboCustomer,
											onChangedCallback: (value) {
												if (value != null) {
													removeError(
														error: "Field Customer tidak boleh kosong.");
													todoCompanyCrudBloc.add(ComboCustomerChangedEvent(comboCustomer: value));
												}
											},
											onSaveCallback: (value) {
												if (value != null) {
													fieldComboCustomer = value;
												}
											},
											validatorCallback: (value) {
												if (value == null) {
													addError(
														error: "Field Customer tidak boleh kosong.");
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
						if (state.record != null){
						}
						fieldComboCustomer = state.comboCustomer;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		todoCompanyCrudBloc.add(
			TodoCompanyCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			TodoCompanyCrudModel record = TodoCompanyCrudModel(
				mrekanId: fieldComboCustomer?.mrekanId,
				timeline2Id: '',
				timeline1Id: widget.timeline1Id,
			);
			if (widget.viewMode == "tambah") {
				todoCompanyCrudBloc.add(TodoCompanyCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.timeline2Id = todoCompanyCrudBloc.state.record!.timeline2Id;
				todoCompanyCrudBloc.add(TodoCompanyCrudUbahEvent(record: record));
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
