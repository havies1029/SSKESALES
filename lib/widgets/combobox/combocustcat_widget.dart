import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combocustcat_model.dart';
import 'package:esalesapp/repositories/combobox/combocustcat_repository.dart';

DropdownSearch<ComboCustCatModel> buildFieldComboCustCat(
    {GlobalKey<DropdownSearchState<ComboCustCatModel>>? comboKey,
    bool enabled = true,
    required String usage,
    required String labelText,
    ComboCustCatModel? initItem,
    Function(ComboCustCatModel?)? onChangedCallback,
    required Function(ComboCustCatModel?) onSaveCallback,
    Function(ComboCustCatModel?)? validatorCallback}) {
  return DropdownSearch<ComboCustCatModel>(
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
      return ComboCustCatRepository().getComboCustCat(usage);
    },
    clearButtonProps: const ClearButtonProps(isVisible: true),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      isFilterOnline: false,
      showSelectedItems: true,
      showSearchBox: false,
      itemBuilder: itemBuilderComboCustCat,
    ),
    compareFn: (item, sItem) => item.mcustcatId == sItem.mcustcatId,
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
      //debugPrint("validator : ${value.toString()}");
      if (validatorCallback != null) {
        validatorCallback(value);
        if ((value == null) || (value.mcustcatId.isEmpty)) {
          return "";
        }
      }
      return null;
    },
  );
}

Widget itemBuilderComboCustCat(
    BuildContext context, ComboCustCatModel item, bool isSelected) {
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
