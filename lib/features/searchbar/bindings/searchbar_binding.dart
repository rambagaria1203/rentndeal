import 'package:rentndeal/constants/consts.dart';
import 'package:rentndeal/features/searchbar/controllers/searchbar_controller.dart';
import 'package:rentndeal/features/searchbar/interfaces/i_searchbar_repository.dart';
import 'package:rentndeal/features/searchbar/repositories/searchbar_repository.dart';

class SearchBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ISearchBarRepository>(() => SearchBarRepository());
    Get.lazyPut(()=> SearchBarController(repository: Get.find<ISearchBarRepository>()));
  }
}