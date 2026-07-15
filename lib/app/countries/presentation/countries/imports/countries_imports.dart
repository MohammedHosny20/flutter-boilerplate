import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/countries/data/datasource/countries_remote_data_source.dart';
import 'package:flutter_boilerplate/app/countries/data/model/models.dart';
import 'package:flutter_boilerplate/app/countries/data/repository/countries_repository_impl.dart';
import 'package:flutter_boilerplate/app/countries/domain/repository/countries_repository.dart';
import 'package:flutter_boilerplate/app/countries/domain/usecase/get_countries_usecase.dart';
import 'package:flutter_boilerplate/app/countries/domain/usecase/get_country_details_usecase.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/providers.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playx/playx.dart';

part '../provider/countries_notifier.dart';
part '../provider/countries_provider.dart';
part '../view/countries_list_view.dart';
part '../widgets/countries_error_widget.dart';
part '../widgets/country_list_item.dart';
