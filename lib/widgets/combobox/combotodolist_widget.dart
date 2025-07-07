import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combotodolist_model.dart';
import 'package:esalesapp/repositories/combobox/combotodolist_repository.dart';
import 'package:intl/intl.dart';

DropdownSearch<ComboTodoListModel> buildFieldComboTodoList({
  bool enabled = true,
	required String labelText,
	GlobalKey<DropdownSearchState<ComboTodoListModel>>? comboKey,
	ComboTodoListModel? initItem,
  required String jobCatGroupId,
  required DateTime tgl,
	Function(ComboTodoListModel?)? onChangedCallback,
	required Function(ComboTodoListModel?) onSaveCallback,
	Function(ComboTodoListModel?)? validatorCallback
	}) {
	return DropdownSearch<ComboTodoListModel>(
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
				return ComboTodoListRepository().getComboTodoList(jobCatGroupId, tgl, filter);
			},
			suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: true)),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
				disableFilter: false,
				showSelectedItems: true,
				showSearchBox: false,
				itemBuilder: itemBuilderComboTodoList,
			),
			compareFn: (item, sItem) => item.timeline1Id == sItem.timeline1Id,
			itemAsString: (item) {
				return item.aktivitas;
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

Widget itemBuilderComboTodoList(
	BuildContext context, ComboTodoListModel item, bool isSelected, bool isDisabled) {
	final DateFormat jamFormat = DateFormat('HH:mm');
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
			contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
			tileColor: isSelected ? Colors.blue.shade50 : Colors.white,
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(12),
			),
			leading: const Icon(Icons.access_time, color: Colors.cyan),
			selected: isSelected,
			title: Text(
				"${jamFormat.format(item.jamMulai!)} - ${jamFormat.format(item.jamAkhir!)}",
				style: const TextStyle(
				fontSize: 16,
				fontWeight: FontWeight.bold,
				color: Colors.black87,
				),
			),
			subtitle: Text(
				item.aktivitas,
				style: const TextStyle(
				fontSize: 15,
				color: Colors.grey,
				),
			),
			),

	);
}
