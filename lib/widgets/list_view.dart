import 'package:flutter/material.dart';
import 'package:travelrecommender/widgets/destination_card.dart';
import 'package:travelrecommender/widgets/hotel_card.dart';

class BuildListView extends StatefulWidget {
  final String type;
  final List<dynamic> list;
  const BuildListView({
    super.key,
    required this.type,
    required this.list
  });

  @override
  State<BuildListView> createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  @override
  Widget build(BuildContext context) {
    return widget.list.isNotEmpty ? ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        if(widget.type == 'hotel') {
          return HotelCard(data: widget.list[index]);
        }
        return DestinationCard(data: widget.list[index]);
      },
    ) : Container();
  }
}