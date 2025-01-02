import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combojob_model.dart';
import 'package:esalesapp/repositories/combobox/combojob_repository.dart';

DropdownSearch<ComboJobModel> buildFieldComboJob(
    {GlobalKey<DropdownSearchState<ComboJobModel>>? comboKey,
    bool enabled = true,
    required String labelText,
    TextEditingController? userEditTextController,
    required String jobCatId,
    ComboJobModel? initItem,
    Function(ComboJobModel?)? onChangedCallback,
    required Function(ComboJobModel?) onSaveCallback,
    Function(ComboJobModel?)? validatorCallback}) {
  return DropdownSearch<ComboJobModel>(
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
      return ComboJobRepository().getComboJob(jobCatId);
    },
    suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: true)),
    popupProps: PopupPropsMultiSelection.modalBottomSheet(
      disableFilter: false,
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
    BuildContext context, ComboJobModel item, bool isSelected, bool isDisabled) {
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
      leading: item.urutan > 0 ? Text("${item.urutan}"):Container(),
      title: Text(item.jobNama),
    ),
  );
}
