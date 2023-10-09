import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:midas_test/data/provider/weather_provider.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var str = ref.watch(stateString);
    final data = ref.watch(weatherProvider(str));
    TextEditingController ctrl = TextEditingController();
    return Scaffold(
      body: data.when(data: (data) {
        return ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: SizedBox(
                height: 55,
                child: TextField(
                  onSubmitted: (e) async {
                    ref.read(stateString.notifier).state = e;
                    ref.refresh(weatherProvider(str));
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    suffixIcon: Icon(Icons.search),
                    labelText: 'Cari data',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                  height: 200,
                  child: Container(
                      child: Card(
                    color: Colors.lightBlueAccent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                            'https://openweathermap.org/img/wn/${data.list[0].weather[0].icon}@4x.png'),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.city.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data.list[0].main.temp.toInt().toString() +
                                  " \u2103",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  data.list[0].weather[0].main,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  " - ",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                                Text(
                                  data.list[0].weather[0].description,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ))),
            ),
            ...data.list.map((e) {
              return Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('EEEE, dd MMM yyyy')
                              .format(DateTime.parse(e.dtTxt!)),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Image.network(
                                'https://openweathermap.org/img/wn/${e.weather[0].icon}.png'),
                            Text(e.weather[0].description)
                          ],
                        ),
                        Text(e.main.temp.toInt().toString() + " \u2103",
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  )),
                ),
              );
            })
          ],
        );
      }, error: (error, s) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_rounded,
              color: Colors.orange,
              size: 85,
            ),
            Text(error.toString()),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(stateString.notifier).state = "Jakarta";
                  ref.refresh(weatherProvider(str));
                },
                child: Text("Retry"))
          ],
        ));
      }, loading: () {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.blueAccent,
        ));
      }),
    );
  }
}
