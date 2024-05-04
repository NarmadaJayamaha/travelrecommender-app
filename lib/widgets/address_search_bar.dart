import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AddressSearchbar extends StatefulWidget {
  final Function getData;
  final Function getPlacesOnSelect;
  const AddressSearchbar({
    super.key,
    required this.getData,
    required this.getPlacesOnSelect
  });

  @override
  State<AddressSearchbar> createState() => _AddressSearchbarState();
}

class _AddressSearchbarState extends State<AddressSearchbar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DropdownSearch<dynamic>(
      asyncItems: (filter) => widget.getData(filter),
      onChanged: (value) {
        widget.getPlacesOnSelect(value);
      },
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: "All",
          hintStyle: TextStyle(
            fontSize: 10,
          ),
          border: InputBorder.none
        )
      ),
      dropdownButtonProps: const DropdownButtonProps(isVisible: false),
      dropdownBuilder:(context, selectedItem) {
        return Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          width: size.width,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
          ),
          child: Align(
            alignment: selectedItem == null ? Alignment.centerLeft : Alignment.center,
            child: Text(
              selectedItem ?? "Search Hotels, Destinations",
              style: TextStyle(
                fontSize: 10,
                color: selectedItem != null ? Colors.black : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
      popupProps: PopupPropsMultiSelection.modalBottomSheet(
        showSearchBox: true,
        itemBuilder: itemWidget,
        searchFieldProps: const TextFieldProps(
          padding: EdgeInsets.only(top: 20, left: 15, right: 15),
          showCursor: false,
        ),
        modalBottomSheetProps: const ModalBottomSheetProps(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
          )
        ),
      ),
    );
  }

  Widget itemWidget(BuildContext context, dynamic name, bool isSelected) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 8, left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.location_pin,
            size: 18,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }
}