import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_notification/domain/entities/push_message.dart';
import 'package:push_notification/presentation/blocs/notifications/notications_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.pushMessageId});
  final String pushMessageId;
  @override
  Widget build(BuildContext context) {
    final PushMessage? message =
        context.watch<NotificationsBloc>().getMessageById(pushMessageId);
    return Scaffold(
      appBar: AppBar(title: Text('Detalles Push')),
      body: (message != null)
          ? _DetailsView(message: message)
          : const Center(child: Text('Notificacion no existe')),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final PushMessage message;
  const _DetailsView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          if (message.imageUrl != null) Image.network(message.imageUrl!),
          const SizedBox(height: 30),
          Text(message.title, style: textStyles.titleMedium),
          Text(message.body),
          Divider(),
          Text(message.data.toString())
        ],
      ),
    );
  }
}
