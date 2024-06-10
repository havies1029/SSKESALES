import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combomedia_model.dart';
import 'package:esalesapp/repositories/combobox/combomedia_repository.dart';

DropdownSearch<ComboMediaModel> buildFieldComboMedia({
  bool enabled = true,
	required String labelText,
	ComboMediaModel? initItem,
	Function(ComboMediaModel?)? onChangedCallback,
	required Function(ComboMediaModel?) onSaveCallback,
	Function(ComboMediaModel?)? validatorCallback
	}) {
	return DropdownSearch<ComboMediaModel>(
    enabled: enabled,
		selectedItem: initItem,
		dropdownDecoratorProps: DropDownDecoratorProps(
			dropdownSearchDecoration: InputDecoration(
				hintText: '...',
				labelText: labelText,
			),
		),
			asyncItems: (String filter) async {
				return ComboMediaRepository().getComboMedia();
			},
			clearButtonProps: const ClearButtonProps(isVisible: true),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
				isFilterOnline: false,
				showSelectedItems: true,
				showSearchBox: false,
				itemBuilder: itemBuilderComboMedia,
			),
			compareFn: (item, sItem) => item.mmediaId == sItem.mmediaId,
			itemAsString: (item) {
				return item.mediaNama;
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

Widget itemBuilderComboMedia(
	BuildContext context, ComboMediaModel item, bool isSelected) {
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
			title: Text(item.mediaNama),
		),
	);
}
