import 'package:get_it/get_it.dart';
import '../model/app_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AppModel>(AppModelImplementation());
}
