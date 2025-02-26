import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combommstjobcat_model.dart';
import 'package:esalesapp/repositories/combobox/combommstjobcat_repository.dart';

DropdownSearch<ComboMMstJobcatModel> buildFieldComboMMstJobcat({
	required String labelText,
  required String rekanId,
	GlobalKey<DropdownSearchState<ComboMMstJobcatModel>>? comboKey,
	ComboMMstJobcatModel? initItem,
	Function(ComboMMstJobcatModel?)? onChangedCallback,
	required Function(ComboMMstJobcatModel?) onSaveCallback,
	Function(ComboMMstJobcatModel?)? validatorCallback
	}) {
	return DropdownSearch<ComboMMstJobcatModel>(
		key: comboKey,
		selectedItem: initItem,
		decoratorProps: DropDownDecoratorProps(
			decoration: InputDecoration(
				hintText: '...',
				labelText: labelText,
			),
		),
			items: (filter, infiniteScrollProps) async {
				return ComboMMstJobcatRepository().getComboMMstJobcat(rekanId, filter);
			},
			suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: false)),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
				disableFilter: true,
				showSelectedItems: true,
				showSearchBox: true,
				itemBuilder: itemBuilderComboMMstJobcat,
			),
			compareFn: (item, sItem) => item.mmstjobcatId == sItem.mmstjobcatId,
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

Widget itemBuilderComboMMstJobcat(
	BuildContext context, ComboMMstJobcatModel item, bool isSelected, bool isDisabled) {
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
