import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combojobcatgroup_model.dart';
import 'package:esalesapp/repositories/combobox/combojobcatgroup_repository.dart';

DropdownSearch<ComboJobcatgroupModel> buildFieldComboJobcatgroup({
	required String labelText,
	GlobalKey<DropdownSearchState<ComboJobcatgroupModel>>? comboKey,
	ComboJobcatgroupModel? initItem,
	Function(ComboJobcatgroupModel?)? onChangedCallback,
	required Function(ComboJobcatgroupModel?) onSaveCallback,
	Function(ComboJobcatgroupModel?)? validatorCallback
	}) {
	return DropdownSearch<ComboJobcatgroupModel>(
		key: comboKey,
		selectedItem: initItem,
		decoratorProps: DropDownDecoratorProps(
			decoration: InputDecoration(
				hintText: '...',
				labelText: labelText,
			),
		),
			items: (filter, infiniteScrollProps) async {
				return ComboJobcatgroupRepository().getComboJobcatgroup();
			},
			suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: false)),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
        disableFilter: true,
				showSelectedItems: true,
				showSearchBox: false,
				itemBuilder: itemBuilderComboJobcatgroup,
			),
			compareFn: (item, sItem) => item.mjobcatgroupId == sItem.mjobcatgroupId,
			itemAsString: (item) {
				return item.groupNama;
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

Widget itemBuilderComboJobcatgroup(
	BuildContext context, ComboJobcatgroupModel item, bool isSelected, bool isDisabled) {
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
			title: Text(item.groupNama),
		),
	);
}
