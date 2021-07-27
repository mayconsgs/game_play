import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_play/core/secretKeys.dart';
import 'package:game_play/models/guildModel.dart';
import 'package:game_play/models/userModel.dart';
import 'package:game_play/widgets/radioButtonWidget.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class CreateEventController extends GetxController {
  final _selectedGuild = Rx(GuildModel());
  bool get hasSelectedGuild => _selectedGuild.value.id != null;
  GuildModel get selectedGuild => _selectedGuild.value;

  final Rx<Category?> _categorySelected = Rx(Category.none);
  Category? get categorySelected => _categorySelected.value;

  final TextEditingController descriptionController = TextEditingController();

  final Rx<DateTime?> _selectedDate = Rx(null);
  DateTime? get selectedDate => _selectedDate.value;
  bool get hasDate => _selectedDate.value != null;

  final Rx<TimeOfDay?> _selectedTime = Rx(null);
  TimeOfDay? get selectedTime => _selectedTime.value;
  bool get hasTime => _selectedTime.value != null;

  DateTime? get selectedDateTime {
    final date = selectedDate;
    final time = selectedTime;

    if (!hasTime || !hasDate) {
      return null;
    }

    return DateTime(
      date!.year,
      date.month,
      date.day,
      time!.hour,
      time.minute,
    );
  }

  void selectGuild(GuildModel guild) {
    _selectedGuild.value = guild;
  }

  void selectCategory(Category? category) {
    _categorySelected.value = category;
  }

  Future<void> selectDate(BuildContext context) async {
    _selectedDate.value = await showDatePicker(
        context: context,
        initialDate: _selectedDate.value ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30)));
  }

  Future<void> selectTime(BuildContext context) async {
    _selectedTime.value = await showTimePicker(
        context: context, initialTime: _selectedTime.value ?? TimeOfDay.now());
  }

  Future<void> createEvent(UserModel user) async {
    final bodyData = Map<String, dynamic>.from({
      'idGuild': _selectedGuild.value.id,
      'idOwner': user.id,
      'schedule': selectedDateTime.toString(),
      'category': _categorySelected.value != null
          ? _categorySelected.value!.toString
          : null,
      'description': descriptionController.text,
      'participants': [user.id],
    });

    final response = await http.post(
      Uri.http(SecretKeys.apiUrl, 'events'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(bodyData),
    );

    print(response.body);
  }
}
