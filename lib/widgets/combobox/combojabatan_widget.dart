import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combojabatan_model.dart';
import 'package:esalesapp/repositories/combobox/combojabatan_repository.dart';

DropdownSearch<ComboJabatanModel> buildFieldComboJabatan(
  {   required String labelText,
      ComboJabatanModel? initItem,       
      Function(ComboJabatanModel?)? onChangedCallback,
      required Function(ComboJabatanModel?) onSaveCallback,
      Function(ComboJabatanModel?)? validatorCallback
  }) {
  return DropdownSearch<ComboJabatanModel>(
    selectedItem: initItem,
    decoratorProps: DropDownDecoratorProps(
      decoration: InputDecoration(
        hintText: '...',
        labelText: labelText,
      ),
    ),
    items: (filter, infiniteScrollProps) async {
      return ComboJabatanRepository().getComboJabatan(filter);
    },
		suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: true)),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      disableFilter: false,
      showSelectedItems: true,
      showSearchBox: false,
      itemBuilder: itemBuilderComboJabatan,
    ),
    compareFn: (item, sItem) => item.mjabatanId == sItem.mjabatanId,
    itemAsString: (item) {
      return item.jabatanDesc;
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

Widget itemBuilderComboJabatan(
    BuildContext context, ComboJabatanModel item, bool isSelected, bool isDisabled) {
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
      title: Text(item.jabatanDesc),
    ),
  );
}
