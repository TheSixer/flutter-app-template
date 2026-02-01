import 'dart:convert';
import 'package:http/http.dart' as http;

const String BASE_URL = 'https://inter.deepwavecloud.com';

/// Strategy API Service
class StrategyService {
  /// 获取策略分页列表
  static Future<List<Map<String, dynamic>>> getStrategiesPage({
    int pageNo = 1,
    int pageSize = 12,
    String? strategyCategory,
    String? params,
  }) async {
    try {
      final uri = Uri.parse('$BASE_URL/api/strategies/page');

      final queryParams = <String, String>{
        'pageNo': pageNo.toString(),
        'pageSize': pageSize.toString(),
      };

      if (strategyCategory != null) {
        queryParams['strategyCategory'] = strategyCategory;
      }

      if (params != null) {
        queryParams['params'] = params;
      }

      final response = await http.get(
        uri.replace(queryParameters: queryParams),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 200) {
          return List<Map<String, dynamic>>.from(data['data']['list'] ?? []);
        }
      }

      return [];
    } catch (e) {
      print('Error fetching strategies: $e');
      return [];
    }
  }

  /// 获取类型字典
  static Future<List<Map<String, dynamic>>> getDictData(String dictType) async {
    try {
      final uri = Uri.parse('$BASE_URL/api/dict/$dictType');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 200) {
          return List<Map<String, dynamic>>.from(data['data'] ?? []);
        }
      }

      return [];
    } catch (e) {
      print('Error fetching dict data: $e');
      return [];
    }
  }
}
