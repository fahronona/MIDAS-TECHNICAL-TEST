import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:midas_test/data/model/weather_model.dart';
import 'package:midas_test/data/service/weather_service.dart';

var weatherServiceProvider =
    Provider<WeatherService>((ref) => WeatherService());

final weatherProvider =
    FutureProvider.family<WeatherModel, String>((ref, city) async {
  return ref.watch(weatherServiceProvider).getWeather(city);
});

final stateString = StateProvider<String>((ref) => "Jakarta");
