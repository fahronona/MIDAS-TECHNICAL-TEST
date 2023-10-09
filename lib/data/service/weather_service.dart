import 'package:dio/dio.dart';
import 'package:midas_test/data/model/weather_model.dart';

class WeatherService {
  final Dio dio = Dio();
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';
  final String apiKey =
      '41032a104170b409adcfd97eae3b02d0'; // Gantilah dengan kunci API cuaca Anda

  Future<WeatherModel> getWeather(String city) async {
    try {
      final response = await dio.get(
        baseUrl,
        queryParameters: {
          'q': city,
          'appid': apiKey,
          'units': 'metric',
          'cnt': '10'
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return WeatherModel.fromJson(data);
      } else {
        throw Exception('Gagal mengambil data cuaca');
      }
    } catch (e) {
      throw Exception('Gagal mengambil data cuaca');
    }
  }
}
