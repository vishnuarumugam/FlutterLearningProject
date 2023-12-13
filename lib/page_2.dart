import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_project/common/common_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:learning_project/model/popular_diets_model.dart';

class PageTwo extends StatelessWidget{
  const PageTwo({super.key});

Future<void> _init() async{
    fetchPopularDiet();
  }

Future<List<PopularDiets>> fetchPopularDiet() async {
  try {
    final response = await http.get(Uri.parse(
        'https://3158f1be-ff9a-4a83-ad7a-502a3542e606.mock.pstmn.io/get_diet_plan'));

    if (response.statusCode == 200) {
      final dynamic jsonList = jsonDecode(response.body);
      developer.log('jsonList', name: '${jsonList}');
      List<PopularDiets> popularDietsList = [];
      print('Type of stringValue: ${jsonList.runtimeType}');

      for (var jsonItem in jsonList) {
        print('Type of jsonItem: ${jsonItem}');
        popularDietsList.add(
            PopularDiets.fromJson(jsonItem as Map<String, dynamic>));
      }
      print(popularDietsList.runtimeType);

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
      appBar: CommonAppBar(
        title: 'Popular Diet', 
        onLeadingTap: (){
          Navigator.pop(context);
          }, 
          onActionTap: (){},
          showLeading: true,
          showAction: false,),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<PopularDiets>>(
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
            // Data has been received, build the ListView
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
                            MaterialPageRoute(builder: (context) => PageTwo()
                            // PopularDietPage(
                            //   popularDiet: popularDiets[index],
                            //   )
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
      ),
    );
  }
}

// ListView.separated(
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               separatorBuilder: (context, index) => const SizedBox(height: 25),
//               itemCount: popularDiets.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                         onTap: (){
//                           Navigator.push(
//                             context, 
//                             MaterialPageRoute(builder: (context) => PageTwo()
//                             // PopularDietPage(
//                             //   popularDiet: popularDiets[index],
//                             //   )
//                             )
//                           );},
//                         child: Container(
//                   height: 100,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     color: Colors.white,
//                     boxShadow: [BoxShadow(
//                     color: const Color(0xff1D1617).withOpacity(0.11),
//                     blurRadius: 40,
//                     spreadRadius: 0.0
//                     )]
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SvgPicture.asset(
//                         popularDiets[index].iconPath,
//                         width: 65,
//                         height: 65,
//                       ), 
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             popularDiets[index].name,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                               fontSize: 16
//                             ),
//                           ),
//                           Text(
//                             '${popularDiets[index].level}|${popularDiets[index].duration}|${popularDiets[index].calorie}',
//                             style: const TextStyle(
//                               color: Color(0xff7B6F72),
//                               fontSize: 13,
//                               fontWeight: FontWeight.w400
//                             ),
//                           )
//                         ]
//                       ),
//                       SvgPicture.asset('assets/icons/button.svg',
//                           width: 30,
//                           height: 30,
//                           ),
//                     ]
                    
//                   ),
//                   )
//                 );
//               },
//             )