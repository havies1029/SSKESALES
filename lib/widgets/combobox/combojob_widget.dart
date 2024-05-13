import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combojob_model.dart';
import 'package:esalesapp/repositories/combobox/combojob_repository.dart';

DropdownSearch<ComboJobModel> buildFieldComboJob(
    {GlobalKey<DropdownSearchState<ComboJobModel>>? comboKey,
    required String labelText,
    TextEditingController? userEditTextController,
    String? externalFilter,
    ComboJobModel? initItem,
    Function(ComboJobModel?)? onChangedCallback,
    required Function(ComboJobModel?) onSaveCallback,
    Function(ComboJobModel?)? validatorCallback}) {
  debugPrint("buildFieldComboJob #10");
  debugPrint("buildFieldComboJob -> initItem : $initItem");
  debugPrint("buildFieldComboJob -> externalFilter : $externalFilter");
  
  return DropdownSearch<ComboJobModel>(
    key: comboKey,
    selectedItem: initItem,    
    dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        hintText: '...',
        labelText: labelText,
      ),
    ),
    asyncItems: (String filter) async {
      debugPrint("asyncItems -> externalFilter : $externalFilter");
      return ComboJobRepository().getComboJob(externalFilter!);
    },
    clearButtonProps: const ClearButtonProps(isVisible: true),
    popupProps: PopupPropsMultiSelection.modalBottomSheet(
      isFilterOnline: true,
      showSelectedItems: true,
      showSearchBox: true,
      itemBuilder: itemBuilderComboJob,
      searchFieldProps: TextFieldProps(
        controller: userEditTextController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              userEditTextController?.clear();
            },
          ),
        ),
      ),
    ),
    compareFn: (item, sItem) => item.mjobId == sItem.mjobId,
    itemAsString: (item) {
      return item.jobNama;
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

Widget itemBuilderComboJob(
    BuildContext context, ComboJobModel item, bool isSelected) {
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
      title: Text(item.jobNama),
    ),
  );
}
