import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combocob_model.dart';
import 'package:esalesapp/repositories/combobox/combocob_repository.dart';

DropdownSearch<ComboCobModel> buildFieldComboCob({
	required String labelText,
	ComboCobModel? initItem,
	Function(ComboCobModel?)? onChangedCallback,
	required Function(ComboCobModel?) onSaveCallback,
	Function(ComboCobModel?)? validatorCallback
	}) {
	return DropdownSearch<ComboCobModel>(
		selectedItem: initItem,
		decoratorProps: DropDownDecoratorProps(
			decoration: InputDecoration(
				hintText: '...',
				labelText: labelText,
			),
		),
			items: (filter, infiniteScrollProps) async {
				return ComboCobRepository().getComboCob(filter);
			},
			suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: false)),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
        disableFilter: true,
				showSelectedItems: true,
				showSearchBox: true,
				itemBuilder: itemBuilderComboCob,
			),
			compareFn: (item, sItem) => item.mcobId == sItem.mcobId,
			itemAsString: (item) {
				return item.cobNama;
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

Widget itemBuilderComboCob(
	BuildContext context, ComboCobModel item, bool isSelected, bool isDisabled) {
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
			title: Text(item.cobNama),
		),
	);
}
