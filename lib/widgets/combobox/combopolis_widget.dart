import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combopolis_model.dart';
import 'package:esalesapp/repositories/combobox/combopolis_repository.dart';

DropdownSearch<ComboPolisModel> buildFieldComboPolis({
	required String labelText,
	ComboPolisModel? initItem,
	Function(ComboPolisModel?)? onChangedCallback,
	required Function(ComboPolisModel?) onSaveCallback,
	Function(ComboPolisModel?)? validatorCallback
	}) {
	return DropdownSearch<ComboPolisModel>(
		selectedItem: initItem,
		decoratorProps: DropDownDecoratorProps(
			decoration: InputDecoration(
				hintText: '...',
				labelText: labelText,
			),
		),
			items: (filter, infiniteScrollProps) async {
				return ComboPolisRepository().getComboPolis(filter);
			},
			suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: true)),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
				disableFilter: false,
				showSelectedItems: true,
				showSearchBox: true,
				itemBuilder: itemBuilderComboPolis,
			),
			compareFn: (item, sItem) => item.polis1Id == sItem.polis1Id,
			itemAsString: (item) {
				return item.placing1Id;
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

Widget itemBuilderComboPolis(
	BuildContext context, ComboPolisModel item, bool isSelected, bool isDisabled) {
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
			title: Text(item.placing1Id),
		),
	);
}
