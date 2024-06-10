import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/comboinsurer_model.dart';
import 'package:esalesapp/repositories/combobox/comboinsurer_repository.dart';

DropdownSearch<ComboInsurerModel> buildFieldComboInsurer(
  { GlobalKey<DropdownSearchState<ComboInsurerModel>>? comboKey,
    bool enabled = true,
    required String labelText,
    ComboInsurerModel? initItem,
    Function(ComboInsurerModel?)? onChangedCallback,
    required Function(ComboInsurerModel?) onSaveCallback,
    Function(ComboInsurerModel?)? validatorCallback}) 
  {
  return DropdownSearch<ComboInsurerModel>(
    enabled: enabled,
    key: comboKey,
    selectedItem: initItem,
    dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        hintText: '...',
        labelText: labelText,
      ),
    ),
    asyncItems: (String filter) async {
      return ComboInsurerRepository().getComboInsurer(filter);
    },
    clearButtonProps: const ClearButtonProps(isVisible: true),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      isFilterOnline: true,
      showSelectedItems: true,
      showSearchBox: true,
      itemBuilder: itemBuilderComboInsurer,
    ),
    compareFn: (item, sItem) => item.mrekanId == sItem.mrekanId,
    itemAsString: (item) {
      return item.rekanNama;
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

Widget itemBuilderComboInsurer(
    BuildContext context, ComboInsurerModel item, bool isSelected) {
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
      title: Text(item.rekanNama),
    ),
  );
}
