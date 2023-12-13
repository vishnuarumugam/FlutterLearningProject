import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_project/common/common_app_bar.dart';
import 'package:learning_project/model/category_model.dart';
import 'package:learning_project/model/diet_model.dart';
import 'package:learning_project/model/popular_diets_model.dart';
import 'package:learning_project/page_2.dart';
import 'package:learning_project/popularDiet/popular_diet_page.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:convert';


class HomePage extends StatelessWidget{
  HomePage({super.key});
  
  List<Category> categories = [];
  List<Diet> diets = [];
  List<PopularDiets> popularDiets = [];
  // late Future<List<PopularDiets>> apiPopularDiets;
  void _getCategories(){
    categories = Category.getCategories();
  }

  void _getDiet(){
    diets = Diet.getDiets();
  }

  void _getPopularDiets(){
    // popularDiets = PopularDiets.getPopularDiets();  
  }


  void _init() async{
    _getCategories();
    _getDiet();
  }

Future<List<PopularDiets>>  fetchPopularDiet() async {
  try {
    final response = await http.get(Uri.parse(
        'https://3158f1be-ff9a-4a83-ad7a-502a3542e606.mock.pstmn.io/get_diet_plan'));

    if (response.statusCode == 200) {
      final dynamic jsonList = jsonDecode(response.body);
      developer.log('jsonList', name: '${jsonList}');
      List<PopularDiets> popularDietsList = [];

      for (var jsonItem in jsonList) {
        popularDietsList.add(
            PopularDiets.fromJson(jsonItem as Map<String, dynamic>));
      }

      popularDiets = popularDietsList;

      developer.log('Popular Diets List', name: '$popularDietsList[0]');
      return popularDietsList;
    } else {
      // Log the status code and response body for debugging purposes
      developer.log('Error: HTTP ${response.statusCode}', name: 'HTTP Error');
      developer.log('Response Body: ${response.body}', name: 'HTTP Error');
      throw Exception('Failed to load diets. HTTP ${response.statusCode}');
    }
  } catch (error, stackTrace) {
    developer.log('Error fetching Popular Diets: $error', error: error, stackTrace: stackTrace);
    // Handle the error gracefully, e.g., show an error message
    throw Exception('Failed to load diets. $error');
  }
}


  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      appBar: CommonAppBar(title: 'Home',
       onLeadingTap: (){},
          onActionTap: (){},
          showLeading: false,
          showAction: false,
         ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          searchBar(),
          const SizedBox(height: 30),
          categoryComponent(),
          const SizedBox(height: 30),
          recommendationComponent(),
          const SizedBox(height: 30),
          popularDietComponent()
        ],
      ),
    );
  }

  FutureBuilder popularDietComponent() {

    return FutureBuilder<List<PopularDiets>>(
        future: fetchPopularDiet(),
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final data = snapshot.data;
            return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20, right: 20),
              separatorBuilder: (context, index) => const SizedBox(height: 25),
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) =>
                            PopularDietPage(
                              popularDiet: popularDiets[index],
                              )
                            )
                          );},
                        child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                    color: const Color(0xff1D1617).withOpacity(0.11),
                    blurRadius: 40,
                    spreadRadius: 0.0
                    )]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        data[index].iconPath,
                        width: 65,
                        height: 65,
                      ), 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16
                            ),
                          ),
                          Text(
                            '${data[index].level}|${data[index].duration}|${data[index].calorie}',
                            style: const TextStyle(
                              color: Color(0xff7B6F72),
                              fontSize: 13,
                              fontWeight: FontWeight.w400
                            ),
                          )
                        ]
                      ),
                      SvgPicture.asset('assets/icons/button.svg',
                          width: 30,
                          height: 30,
                          ),
                    ]
                    
                  ),
                  )
                );
              },
            );
          }
        },
      );
  }

  Column recommendationComponent() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text('Recommendation for Diet',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black
                )
              ),
            ),
            const SizedBox(height:15),
            SizedBox(
              height: 240,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 25),
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemCount: diets.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 210,
                    decoration: BoxDecoration(
                      color: diets[index].boxColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                          SvgPicture.asset(diets[index].iconPath),
                          Text(diets[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 14
                            )
                          ),
                          Text(
                            '${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}',
                            style: const TextStyle(
                              color: Color(0xff7B6F72),
                              fontSize: 13,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                colors: [
                                  diets[index].viewIsSelected ? const Color(0xff9DCEFF) : Colors.transparent,
                                  diets[index].viewIsSelected ? const Color(0xff92A3FD) : Colors.transparent
                                ]
                                )
                            ),
                            child: Center(
                              child: Text('View',
                                style: TextStyle(
                                  color: diets[index].viewIsSelected ? Colors.white : const Color(0xffC58BF2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                                )
                              ),
                            )
                          )
                      ]
                    ),
                    );
                } ),
            )
          ]
        );
  }

  Column categoryComponent() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text('Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black)),
            ),
            const SizedBox(height:15),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 25),
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemCount: categories.length,
                itemBuilder: (context, index){
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: categories[index].boxColor.withOpacity(0.30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SvgPicture.asset(categories[index].iconPath),
                          ),
                        ),
                        Text(categories[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black)
                            ),
                      ]
                    ),
                  );
                },
                ),
            )
          ]
        );
  }

  Container searchBar() {
    return Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              color: const Color(0xff1D1617).withOpacity(0.11),
              blurRadius: 40,
              spreadRadius: 0.0
            )]
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search the Pan Cake',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xffCCCCCC),
                fontWeight: FontWeight.normal
              ),
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset('assets/icons/search.svg'),
              ),
              suffixIcon: SizedBox(
                width: 80,
                child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const VerticalDivider(
                            color: Color(0xffCCCCCC),
                            indent: 10,
                            endIndent: 10,
                            thickness: 0.4,
                          ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: SvgPicture.asset('assets/icons/Filter.svg'),
                        ),
                      ],
                    )
                ),
              ),
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)
            ),
          )
          );
  }

}