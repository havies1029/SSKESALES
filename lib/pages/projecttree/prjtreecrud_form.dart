import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/widgets/form_error.dart';
import 'package:esalesapp/blocs/projecttree/prjtreecrud_bloc.dart';
import 'package:esalesapp/models/projecttree/prjtreecrud_model.dart';
import 'package:esalesapp/models/combobox/combommstjobcat_model.dart';
import 'package:esalesapp/widgets/combobox/combommstjobcat_widget.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/widgets/combobox/combocustomer_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';


class PrjtreeCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const PrjtreeCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	PrjtreeCrudFormPageFormState createState() => PrjtreeCrudFormPageFormState();
}

class PrjtreeCrudFormPageFormState extends State<PrjtreeCrudFormPage> {
	late PrjtreeCrudBloc prjtreeCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	ComboMMstJobcatModel? fieldComboMMstJobcat;
	final comboMMstJobcatKey = GlobalKey<DropdownSearchState<ComboMMstJobcatModel>>();
	ComboCustomerModel? fieldComboCustomer;
	final comboCustomerKey = GlobalKey<DropdownSearchState<ComboCustomerModel>>();
	var fieldProjectNamaController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		prjtreeCrudBloc = BlocProvider.of<PrjtreeCrudBloc>(context);
		return BlocConsumer<PrjtreeCrudBloc, PrjtreeCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Project Tree",
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
										buildFieldMrekanId(),
										buildFieldProjectNama(),
										buildFieldMmstjobcatId(),
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
							fieldProjectNamaController.text = state.record!.projectNama;
						}
						fieldComboMMstJobcat = state.comboMMstJobcat;
						fieldComboCustomer = state.comboCustomer;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		prjtreeCrudBloc.add(
			PrjtreeCrudLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldMmstjobcatId(){
		return buildFieldComboMMstJobcat(
			comboKey: comboMMstJobcatKey,
			labelText: 'Task Category',
			initItem: fieldComboMMstJobcat,
      rekanId: fieldComboCustomer?.mrekanId??"",
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field 'Task Category' tidak boleh kosong.");
					prjtreeCrudBloc.add(ComboMMstJobcatChangedEvent(comboMMstJobcat: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMMstJobcat = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field 'Task Category' tidak boleh kosong.");
				}
			}, 
		);
	}

	Widget buildFieldMrekanId(){
		return buildFieldComboCustomer(
			comboKey: comboCustomerKey,
			labelText: 'Client',
			initItem: fieldComboCustomer,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field 'Client' tidak boleh kosong.");
					prjtreeCrudBloc.add(ComboCustomerChangedEvent(comboCustomer: value));
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
						error: "Field 'Client' tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldProjectNama(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldProjectNamaController,
			decoration: const InputDecoration(
				labelText: "Project Name",
				floatingLabelBehavior: FloatingLabelBehavior.always,
			),
			onChanged: (value) {
				if (value.isNotEmpty) {
				removeError(error: "Field 'Project Name' tidak boleh kosong.");
				}
			},
			validator: (value) {
				if (value == null || value.isEmpty) {
					addError(error: "Field 'Project Name' tidak boleh kosong.");
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
			PrjtreeCrudModel record = PrjtreeCrudModel(
				mmstjobcatId: fieldComboMMstJobcat?.mmstjobcatId,
				mrekanId: fieldComboCustomer?.mrekanId,
				prjtree1Id: '',
				projectNama: fieldProjectNamaController.text,
			);
			if (widget.viewMode == "tambah") {
				prjtreeCrudBloc.add(PrjtreeCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.prjtree1Id = prjtreeCrudBloc.state.record!.prjtree1Id;
				prjtreeCrudBloc.add(PrjtreeCrudUbahEvent(record: record));
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
