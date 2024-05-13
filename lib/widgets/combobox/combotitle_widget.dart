import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combotitle_model.dart';
import 'package:esalesapp/repositories/combobox/combotitle_repository.dart';

DropdownSearch<ComboTitleModel> buildFieldComboTitle({
    required String labelText,
    ComboTitleModel? initItem,    
    Function(ComboTitleModel?)? onChangedCallback,
    required Function(ComboTitleModel?) onSaveCallback,
    Function(ComboTitleModel?)? validatorCallback}) {
  return DropdownSearch<ComboTitleModel>(
    selectedItem: initItem,
    dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        hintText: '...',
        labelText: labelText,
      ),
    ),
    asyncItems: (String filter) async {
      return ComboTitleRepository().getComboTitle(filter);
    },
    clearButtonProps: const ClearButtonProps(isVisible: true),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      isFilterOnline: false,
      showSelectedItems: true,
      showSearchBox: false,
      itemBuilder: itemBuilderComboTitle,
    ),
    compareFn: (item, sItem) => item.mtitleId == sItem.mtitleId,
    itemAsString: (item) {
      return item.titleDesc;
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

Widget itemBuilderComboTitle(
    BuildContext context, ComboTitleModel item, bool isSelected) {
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
      title: Text(item.titleDesc),
    ),
  );
}
