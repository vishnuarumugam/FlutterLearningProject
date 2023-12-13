import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_project/common/common_app_bar.dart';
import 'package:learning_project/model/popular_diets_model.dart';

class PopularDietPage extends StatelessWidget{
  final PopularDiets popularDiet;

  const PopularDietPage({super.key, 
    required this.popularDiet
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Popular Diet', 
        onLeadingTap: (){
          Navigator.pop(context);
          }, 
          onActionTap: (){},
          showLeading: true,
          showAction: false,),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageContainer(),
                Text(
                  popularDiet.name,
                  style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(height:30),
                dietDetailContainer(),
                Container(
                  height: 50,
                  width: 120,
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(25),
                    
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }

  Container dietDetailContainer() {
    return Container(
                height: 100,
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                decoration: BoxDecoration(
                  color: const  Color(0xffEEA4CE).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8, left:8, right:8, bottom:4),
                            child: Text(popularDiet.level,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top:4, left:8, right:8, bottom:8),
                            child: Text('Level',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)
                            ),
                          )
                      ]),
                      const VerticalDivider(
                          color: Color(0xffCCCCCC),
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8, left:8, right:8, bottom:4),
                            child: Text(popularDiet.duration,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top:4, left:8, right:8, bottom:8),
                            child: Text('Duration',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)
                            ),
                          )
                      ]),
                      const VerticalDivider(
                          color: Color(0xffCCCCCC),
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8, left:8, right:8, bottom:4),
                            child: Text(popularDiet.calorie,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top:4, left:8, right:8, bottom:8),
                            child: Text('Calories',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)
                            ),
                          )
                      ]),
                    ],
                ),
              );
  }

  Container imageContainer() {
    return Container(
                margin: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(
                    color: const  Color(0xff1D1617).withOpacity(0.21),
                    blurRadius: 50,
                    spreadRadius: 0.0
                  )]
                
                ),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(popularDiet.iconPath),
                    ),
              );
  }

}