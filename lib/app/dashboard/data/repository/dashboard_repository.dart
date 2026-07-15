import 'package:flutter_boilerplate/app/dashboard/data/datasource/dashboard_datasource.dart';

class DashboardRepository {
  final DashboardDatasource _dataSource;
  DashboardRepository({
    required DashboardDatasource dataSource,
  }) : _dataSource = dataSource;
}
