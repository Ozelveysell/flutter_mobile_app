// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvvm_app/viewmodels/state/participants_state.dart';

class HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(participantsProvider.notifier).fetchParticipants());
  }

  @override
  Widget build(BuildContext context) {
    final participantsState = ref.watch(participantsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Participants'),
      ),
      body: participantsState.when(
        data: (participants) {
          return ListView.builder(
            itemCount: participants.length,
            itemBuilder: (context, index) {
              final participant = participants[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(participant.avatarUrl),
                ),
                title: Text('${participant.firstName} ${participant.lastName}'),
                subtitle: Text(participant.email),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load participants: $error')),
      ),
    );
  }
}
