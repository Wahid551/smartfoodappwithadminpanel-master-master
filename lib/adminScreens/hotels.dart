import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartfoodappwithadminpanel/appColors/colors.dart';

class HotelsList extends StatefulWidget {
  const HotelsList({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HotelsList> {
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.white,
                      backgroundColor,
                    ]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.1, 0.1),
                        blurRadius: 10,
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 15.0, top: 20.0),
                            child: Text(
                              "Krispy Cottage",
                              style: GoogleFonts.pattaya(
                                  textStyle: TextStyle(
                                color: eigengrauColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 15.0),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(imageUrl),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 10.0),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    backgroundColor,
                  ]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.1, 0.1),
                      blurRadius: 10,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            "CFC Cafe",
                            style: GoogleFonts.pattaya(
                                textStyle: TextStyle(
                              color: eigengrauColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(imageUrl1),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            SizedBox(height: 10.0),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    backgroundColor,
                  ]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.1, 0.1),
                      blurRadius: 10,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Text(
                            "AFC Vehari",
                            style: GoogleFonts.pattaya(
                                textStyle: TextStyle(
                              color: eigengrauColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(imageUrl3),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            SizedBox(height: 10.0),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    backgroundColor,
                  ]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.1, 0.1),
                      blurRadius: 10,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 15.0, top: 20.0),
                          child: Text(
                            "Cookooz",
                            style: GoogleFonts.pattaya(
                                textStyle: TextStyle(
                              color: eigengrauColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            SizedBox(height: 10.0),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    backgroundColor,
                  ]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.1, 0.1),
                      blurRadius: 10,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            "Pizza on 8",
                            style: GoogleFonts.pattaya(
                                textStyle: TextStyle(
                              color: eigengrauColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(imageUrl1),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            SizedBox(height: 10.0),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    backgroundColor,
                  ]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.1, 0.1),
                      blurRadius: 10,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10.0, top: 20.0),
                          child: Text(
                            "Densire",
                            style: GoogleFonts.pattaya(
                                textStyle: TextStyle(
                              color: eigengrauColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(imageUrl3),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ));
  }
}
