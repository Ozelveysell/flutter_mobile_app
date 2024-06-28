import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:riverpod_mvvm_app/models/participant.dart';

final participantsProvider = StateNotifierProvider<ParticipantsNotifier, AsyncValue<List<Participant>>>((ref) {
  return ParticipantsNotifier();
});

class ParticipantsNotifier extends StateNotifier<AsyncValue<List<Participant>>> {
  ParticipantsNotifier() : super(AsyncValue.loading());

  Future<void> fetchParticipants() async {
    try {
      final response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

      if (response.statusCode == 200) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        final jsonData = jsonDecode(response.body);
        final participants = (jsonData['data'] as List)
            .map((data) => Participant.fromJson(data))
            .toList();
        state = AsyncValue.data(participants);
      } else {
        state = AsyncValue.error('Failed to load participants');
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
