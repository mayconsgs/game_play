import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_play/controllers/authController.dart';
import 'package:game_play/controllers/createEventController.dart';
import 'package:game_play/core/appImages.dart';
import 'package:game_play/widgets/guildsListWidget.dart';
import 'package:game_play/widgets/radioButtonWidget.dart';
import 'package:get/get.dart';

class CreateEventScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final _createEventController = CreateEventController();

  CreateEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar partida'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [
                Obx(() {
                  return RadioButtonWidget(
                    iconPath: AppImages.rankingSvg,
                    text: 'Ranked',
                    value: Category.ranked,
                    onChanged: () {
                      _createEventController.selectCategory(Category.ranked);
                    },
                    groupValue: _createEventController.categorySelected,
                  );
                }),
                const SizedBox(width: 24),
                Obx(() {
                  return RadioButtonWidget(
                    iconPath: AppImages.espadasSvg,
                    text: 'Duelo',
                    value: Category.duel,
                    onChanged: () {
                      _createEventController.selectCategory(Category.duel);
                    },
                    groupValue: _createEventController.categorySelected,
                  );
                }),
                const SizedBox(width: 24),
                Obx(() {
                  return RadioButtonWidget(
                    iconPath: AppImages.controleSvg,
                    text: 'Diversão',
                    value: Category.joke,
                    onChanged: () {
                      _createEventController.selectCategory(Category.joke);
                    },
                    groupValue: _createEventController.categorySelected,
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListViewWidget(
                    createEventController: _createEventController,
                  );
                },
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF243189),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Obx(() {
                    if (_createEventController.hasSelectedGuild)
                      return ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl:
                                _createEventController.selectedGuild.iconUrl!,
                            width: 68,
                            height: 68,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8));

                    return Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D2766),
                        border: Border(
                          right: const BorderSide(
                            color: const Color(0xFF243189),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  }),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Text(
                              _createEventController.hasSelectedGuild
                                  ? _createEventController.selectedGuild.name!
                                  : 'Selecione',
                              style: TextStyle(fontSize: 18),
                              softWrap: true,
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Icon(
                      Icons.chevron_right,
                      color: Color(0xFFABB1CC),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dia e mês', style: TextStyle(fontSize: 18)),
              const Text('Hora e minuto', style: TextStyle(fontSize: 18))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(onTap: () async {
                await _createEventController.selectDate(context);
              }, child: Obx(() {
                return Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFF1D2766),
                        border: Border.all(color: Color(0xFF243189)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(_createEventController.hasDate
                            ? '${_createEventController.selectedDate!.day}'
                            : ''),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text('/', style: Theme.of(context).textTheme.subtitle1),
                    const SizedBox(width: 4),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFF1D2766),
                        border: Border.all(color: Color(0xFF243189)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(_createEventController.hasDate
                            ? '${_createEventController.selectedDate!.month}'
                            : ''),
                      ),
                    ),
                  ],
                );
              })),
              InkWell(onTap: () async {
                await _createEventController.selectTime(context);
              }, child: Obx(() {
                return Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFF1D2766),
                        border: Border.all(color: Color(0xFF243189)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(_createEventController.hasTime
                            ? '${_createEventController.selectedTime!.hour}'
                            : ''),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(':', style: Theme.of(context).textTheme.subtitle1),
                    const SizedBox(width: 4),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFF1D2766),
                        border: Border.all(color: Color(0xFF243189)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(_createEventController.hasTime
                            ? '${_createEventController.selectedTime!.minute}'
                            : ''),
                      ),
                    ),
                  ],
                );
              })),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Descrição', style: TextStyle(fontSize: 18)),
              Text(
                'Max 100 caracteres',
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _createEventController.descriptionController,
            minLines: 3,
            maxLines: 5,
            maxLength: 100,
          ),
          const SizedBox(height: 56),
          ElevatedButton(
            onPressed: () async {
              _createEventController.createEvent(_authController.user);
            },
            child: Text('Agendar'),
          ),
        ],
      ),
    );
  }
}
