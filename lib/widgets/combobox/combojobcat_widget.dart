import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combojobcat_model.dart';
import 'package:esalesapp/repositories/combobox/combojobcat_repository.dart';

DropdownSearch<ComboJobcatModel> buildFieldComboJobcat({
  GlobalKey<DropdownSearchState<ComboJobcatModel>>? comboKey,
	required String labelText,
	ComboJobcatModel? initItem,
	Function(ComboJobcatModel?)? onChangedCallback,
	required Function(ComboJobcatModel?) onSaveCallback,
	Function(ComboJobcatModel?)? validatorCallback
	}) {
	return DropdownSearch<ComboJobcatModel>(
    key: comboKey,
		selectedItem: initItem,
		dropdownDecoratorProps: DropDownDecoratorProps(
			dropdownSearchDecoration: InputDecoration(
				hintText: '...',
				labelText: labelText,
			),
		),
			asyncItems: (String filter) async {
				return ComboJobcatRepository().getComboJobcat();
			},
			clearButtonProps: const ClearButtonProps(isVisible: true),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
				isFilterOnline: false,
				showSelectedItems: true,
				showSearchBox: false,
				itemBuilder: itemBuilderComboJobcat,
			),
			compareFn: (item, sItem) => item.mjobcatId == sItem.mjobcatId,
			itemAsString: (item) {
				return item.catName;
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

Widget itemBuilderComboJobcat(
	BuildContext context, ComboJobcatModel item, bool isSelected) {
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
			title: Text(item.catName),
		),
	);
}
