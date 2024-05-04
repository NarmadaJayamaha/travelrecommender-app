import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelrecommender/config/url.dart';
import 'package:travelrecommender/widgets/address_search_bar.dart';
import 'package:travelrecommender/widgets/list_title.dart';
import 'package:travelrecommender/widgets/list_view.dart';

class AddressSearchScreen extends StatefulWidget {
  @override
  _AddressSearchScreenState createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {

  List<dynamic> hotels = [];
  List<dynamic> destinations = [];
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    getAllPlaces();
  }

  startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  getAllPlaces() async {
    startLoading();
    final dio = Dio();
    final response = await dio.get(Urls.getPlacesUrl, 
    queryParameters: {
      'city': ''
    });
    setState(() {
      hotels = response.data['hotels'];
      destinations = response.data['destinations'];
    });
    stopLoading();
  }

  getPlacesOnSelect(String city) async {
    startLoading();
    final dio = Dio();
    final response = await dio.get(Urls.getPlacesUrl, 
    queryParameters: {
      'city': city
    });
    setState(() {
      hotels = response.data['hotels'];
      destinations = response.data['destinations'];
    });
    stopLoading();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            expandedHeight: 230,
            collapsedHeight: 60,
            forceElevated: true,
            stretch: true,
            surfaceTintColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            flexibleSpace: FlexibleSpaceBar(
              title: AddressSearchbar(
                getData: (filter) => getData(filter), 
                getPlacesOnSelect: (value) {
                  getPlacesOnSelect(value);
                }
              ),
              background: Image.asset(
                'assets/appbar_bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        body: !isLoading ? ListView(
          children: [
            hotels.isNotEmpty ? const ListTitle(title: "HOTELS",) : Container(),
            BuildListView(type: 'hotel', list: hotels),
            const SizedBox(height: 40),
            destinations.isNotEmpty ? const ListTitle(title: "DESTINATIONS",) : Container(),
            BuildListView(type: 'destinations', list: destinations),
          ],
        ) : const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> getData(filter) async {
    var response = await Dio().get(Urls.getCitiesUrl);
    List<dynamic> list = response.data;
    return list;
  }
}