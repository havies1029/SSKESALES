import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combomproject_model.dart';
import 'package:esalesapp/repositories/combobox/combomproject_repository.dart';

DropdownSearch<ComboMProjectModel> buildFieldComboMProject({
  bool enabled = true,
	required String labelText,  
  required String rekanId,
	GlobalKey<DropdownSearchState<ComboMProjectModel>>? comboKey,
	ComboMProjectModel? initItem,
	Function(ComboMProjectModel?)? onChangedCallback,
	required Function(ComboMProjectModel?) onSaveCallback,
	Function(ComboMProjectModel?)? validatorCallback
	}) {
	return DropdownSearch<ComboMProjectModel>(
    enabled: enabled,
		key: comboKey,
		selectedItem: initItem,
		decoratorProps: DropDownDecoratorProps(
			decoration: InputDecoration(
				hintText: '...',
				labelText: labelText,
			),
		),
			items: (filter, infiniteScrollProps) async {
				return ComboMProjectRepository().getComboMProject(rekanId);
			},
			suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: false)),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
				disableFilter: true,
				showSelectedItems: true,
				showSearchBox: true,
				itemBuilder: itemBuilderComboMProject,
			),
			compareFn: (item, sItem) => item.mprojectId == sItem.mprojectId,
			itemAsString: (item) {
				return item.projectNama;
			},
			onChanged: (value) {
				if (onChangedCallback != null) {
					onChangedCallback(value);
				}
			},
			onSaved: (value) {
				onSaveCallback(value);
			},
			validator: (value) {
				if (validatorCallback != null) {
					validatorCallback(value);
					if (value == null) {
						return "";
					}
				}
				return null;
			},
		);
}

Widget itemBuilderComboMProject(
	BuildContext context, ComboMProjectModel item, bool isSelected, bool isDisabled) {
	return Container(
		margin: const EdgeInsets.symmetric(horizontal: 8),
		decoration: !isSelected
			? null
			: BoxDecoration(
				border: Border.all(color: Theme.of(context).primaryColor),
				borderRadius: BorderRadius.circular(5),
				color: Colors.white,
			),
		child: ListTile(
			selected: isSelected,
			title: Text(item.projectNama),
		),
	);
}
