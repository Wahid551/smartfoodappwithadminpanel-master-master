import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfoodappwithadminpanel/Models/admin_Model.dart';
import 'package:smartfoodappwithadminpanel/adminScreens/colors/appcolors.dart';
import 'package:smartfoodappwithadminpanel/providers/hotels_listLprovider.dart';
import 'package:smartfoodappwithadminpanel/screens/home/home_screen.dart';

// ignore: must_be_immutable
class HotelsList extends StatefulWidget {
  String city;
  HotelsList({required this.city});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HotelsList> {
  @override
  void initState() {
    HotelsListProvider data = Provider.of(context, listen: false);
    data.getHotelsList(widget.city);
    super.initState();
  }

  List<AdminModel> hotelsData = [];
  late HotelsListProvider _hotelList;

  String imageUrl =
      "https://st.depositphotos.com/1005682/2476/i/600/depositphotos_24762569-stock-photo-fast-food-hamburger-hot-dog.jpg";
  String imageUrl1 =
      "https://img.jakpost.net/c/2016/09/29/2016_09_29_12990_1475116504._large.jpg";
  String imageUrl2 =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTveeuSnb_TzDg8AW7zOTG9sEk65G9HQpHMP8NfLFAyl1OfrXygFAZfuUXA1sWEyUd_-r4&usqp=CAU";
  String imageUrl3 =
      "https://www.eatthis.com/wp-content/uploads/sites/4/media/images/ext/305133437/burger-king-spread.jpg?fit=1024%2C750&ssl=1";

  @override
  Widget build(BuildContext context) {
    _hotelList = Provider.of<HotelsListProvider>(context);
    hotelsData = _hotelList.getHotelsDataList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Hotels List'),
      ),
      body: hotelsData.isEmpty
          ? Center(
              child: Container(
                child: Center(
                  child: Text("No Data"),
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: GridView.builder(
                itemCount: hotelsData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  AdminModel data = hotelsData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                uid: data.userUid,
                              )));
                      // _custom.getCustomerOrders(FirebaseAuth.instance.currentUser!.uid);
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                      //     ShirtDescription(data: data,)
                      // ));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width * 0.25,
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: AppColors.platiniumColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1, 1),
                                blurRadius: 5),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Image(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Text(
                            data.hotelName,
                            style: TextStyle(
                                color: AppColors.trueBlueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
