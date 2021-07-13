import 'package:game_play/models/guildModel.dart';
import 'package:game_play/widgets/radioButtonWidget.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CreateEventController extends GetxController {
  final _selectedGuild = Rx(GuildModel());
  bool get hasSelectedGuild => _selectedGuild.value.id != null;
  GuildModel get selectedGuild => _selectedGuild.value;

  final Rx<CategoryValues?> _categorySelected = Rx(CategoryValues.none);
  CategoryValues? get categorySelected => _categorySelected.value;

  void selectCategory(CategoryValues? category) {
    _categorySelected.value = category;
  }

  void selectGuild(GuildModel guild) {
    _selectedGuild.value = guild;
  }
}
