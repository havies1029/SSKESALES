
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:esalesapp/models/combobox/combocustomer_model.dart';
import 'package:esalesapp/repositories/combobox/combocustomer_repository.dart';
import 'package:esalesapp/widgets/my_colors.dart';
import 'package:esalesapp/widgets/my_text.dart';

DropdownSearch<ComboCustomerModel> buildFieldComboCustomer4JobReal(
    {GlobalKey<DropdownSearchState<ComboCustomerModel>>? comboKey,
    bool enabled = true,
    required String labelText,
    required String timeline1Id,
    ComboCustomerModel? initItem,
    Function(ComboCustomerModel?)? onChangedCallback,
    required Function(ComboCustomerModel?) onSaveCallback,
    Function(ComboCustomerModel?)? validatorCallback}) {

  //debugPrint("buildFieldComboCustomer : initItem ${jsonEncode(initItem?.toJson())}");

  return DropdownSearch<ComboCustomerModel>(
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
      return ComboCustomerRepository().getComboCustomer4JobReal(timeline1Id, filter);
    },
    suffixProps: const DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: true)),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      disableFilter: false,
      showSelectedItems: true,
      showSearchBox: true,
      itemBuilder: itemBuilderComboCustomer,
    ),
    compareFn: (item, sItem) => item.mrekanId == sItem.mrekanId,
    itemAsString: (item) {
      return "${item.titleDesc} ${item.rekanNama}";
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

Widget itemBuilderComboCustomer(
    BuildContext context, ComboCustomerModel item, bool isSelected, bool isDisabled) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
    child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${item.titleDesc} ${item.rekanNama}",
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_95)),
              Container(height: 5),
              Text("Alamat",
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_40)),
              Container(height: 5),
              Text(item.alamat1,
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_80)),
              Text(item.alamat2,
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_80)),
              Text("Telp",
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_40)),
              Container(height: 5),
              Text(
                  "${item.telp1} ${item.telp2.isNotEmpty ? "/ ${item.telp2}" : ""}",
                  style: MyText.bodyLarge(context)!
                      .copyWith(color: MyColors.grey_80)),
            ]))),
  );

  
}
