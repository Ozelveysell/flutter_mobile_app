import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvvm_app/viewmodels/state/participants_state.dart';


class ParticipantsListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participantsAsyncValue = ref.watch(participantsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Katılımcılar'),
      ),
      body: participantsAsyncValue.when(
        data: (participants) {
          return ListView.builder(
            itemCount: participants.length,
            itemBuilder: (context, index) {
              final participant = participants[index];
              return ListTile(
                title: Text(participant.firstName + ' ' + participant.lastName),
                subtitle: Text(participant.email),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(participant.avatarUrl),
                ),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Hata: $error')),
      ),
    );
  }
}
