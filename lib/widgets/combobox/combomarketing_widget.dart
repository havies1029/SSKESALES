import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combomarketing_model.dart';
import 'package:esalesapp/repositories/combobox/combomarketing_repository.dart';

DropdownSearch<ComboMarketingModel> buildFieldComboMarketing({
	required String labelText,
	GlobalKey<DropdownSearchState<ComboMarketingModel>>? comboKey,
	ComboMarketingModel? initItem,
	Function(ComboMarketingModel?)? onChangedCallback,
	required Function(ComboMarketingModel?) onSaveCallback,
	Function(ComboMarketingModel?)? validatorCallback
	}) {
	return DropdownSearch<ComboMarketingModel>(
		key: comboKey,
		selectedItem: initItem,
		decoratorProps: DropDownDecoratorProps(
			decoration: InputDecoration(
				hintText: '...',
				labelText: labelText,
			),
		),
			items: (filter, infiniteScrollProps) async {
				return ComboMarketingRepository().getComboMarketing();
			},
			suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: true)),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
				disableFilter: false,
				showSelectedItems: true,
				showSearchBox: true,
				itemBuilder: itemBuilderComboMarketing,
			),
			compareFn: (item, sItem) => item.msalesId == sItem.msalesId,
			itemAsString: (item) {
				return item.salesNama;
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

Widget itemBuilderComboMarketing(
	BuildContext context, ComboMarketingModel item, bool isSelected, bool isDisabled) {
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
			title: Text(item.salesNama),
		),
	);
}
