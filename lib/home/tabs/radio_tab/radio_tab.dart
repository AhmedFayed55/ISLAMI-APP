import 'package:flutter/material.dart';
import 'package:islami_app_new/api/api_manager.dart';
import 'package:islami_app_new/home/app_colors.dart';
import 'package:islami_app_new/home/tabs/radio_tab/radio_item.dart';
import 'package:islami_app_new/models/radio_response_model.dart';
import 'package:islami_app_new/models/reciters_response_model.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
//
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * .035),
      child: DefaultTabController(
          length: 2,
          child: Column(
            spacing: height * .02,
            children: [
              Image.asset("assets/images/bar.png"),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xb3202020)
                ),
                child: TabBar(
                    dividerHeight: 0,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        color: AppColor.gold,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    labelStyle: TextStyle(fontSize: 16, color: AppColor.black),
                    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColor.white),
                    tabs: const [
                      Tab(text: 'Radio',),
                      Tab(text: 'Reciters',),
                    ]),
              ),
              Expanded(
                child: TabBarView(children: [
                  FutureBuilder<RadioResponseModel>(
                    future: ApiManager.getRadioData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(color: AppColor
                              .gold,),
                        );
                      } else if (snapshot.hasError) {
                        return Column(
                          children: [
                            const Text('SomeThing went wrong',
                              style: TextStyle(color: AppColor.gold),),
                            ElevatedButton(onPressed: () {
                              ApiManager.getRadioData();
                              setState(() {});
                            },
                                child: const Text('Try Again')),
                          ],
                        );
                      }
                      RadioResponseModel data = snapshot.data!;
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: data.radios!.length,
                        itemBuilder: (context, index) {
                          return RadioItem(
                            name: data.radios![index].name ?? "",
                            url: data.radios![index].url ?? "",);
                        },
                      );
                    },),
                  FutureBuilder<RecitersResponseModel>(
                    future: ApiManager.getRecitersData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(color: AppColor
                              .gold,),
                        );
                      } else if (snapshot.hasError) {
                        return Column(
                          children: [
                            const Text('SomeThing went wrong',
                              style: TextStyle(color: AppColor.gold),),
                            ElevatedButton(onPressed: () {
                              ApiManager.getRecitersData();
                              setState(() {});
                            },
                                child: const Text('Try Again')),
                          ],
                        );
                      }
                      RecitersResponseModel data = snapshot.data!;
                      return FutureBuilder<RecitersResponseModel>(
                        future: ApiManager.getRecitersData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.gold,),
                            );
                          } else if (snapshot.hasError) {
                            return Column(
                              children: [
                                const Text('SomeThing went wrong',
                                  style: TextStyle(color: AppColor.gold),),
                                ElevatedButton(onPressed: () {
                                  ApiManager.getRecitersData();
                                  setState(() {});
                                },
                                    child: const Text('Try Again')),
                              ],
                            );
                          }
                          RecitersResponseModel data = snapshot.data!;
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: data.reciters!.length,
                            itemBuilder: (context, index) {
                              return RadioItem(
                                  name: data.reciters![index].name ?? "",
                                  url: "${data.reciters![index].moshaf![0]
                                      .server}112.mp3");
                            },
                          );
                        },);
                    },),

                ]),
              )
            ],
          )
      ),
    );
  }
}
