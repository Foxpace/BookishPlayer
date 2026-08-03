part of '../settings_screen.dart';

class _SpeechModelsCard extends StatelessWidget {
  const _SpeechModelsCard();

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return BlocConsumer<SpeechModelsCubit, SpeechModelsState>(
      listenWhen: (previous, current) =>
          current.message != null && previous.message != current.message,
      listener: (context, state) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message!))),
      builder: (context, state) {
        final working = state.status == SpeechModelsStatus.downloading;
        final selectedModel = state.models.isEmpty
            ? null
            : state.models.firstWhere(
                (model) => model.slug == state.selectedModel,
                orElse: () => state.models.first,
              );
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.speechToTextModel,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Material(
                  color:
                      Theme.of(context).inputDecorationTheme.fillColor ??
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: working || state.models.isEmpty
                        ? null
                        : () => _showSpeechModelPicker(context),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 10, 8),
                      child: Row(
                        children: [
                          const Icon(Icons.record_voice_over_outlined),
                          const SizedBox(width: 12),
                          Expanded(
                            child: selectedModel == null
                                ? Text(l10n.noSpeechModelsAvailable)
                                : _SpeechModelLabel(model: selectedModel),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.expand_more_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.status == SpeechModelsStatus.loading) ...[
                  const SizedBox(height: 14),
                  const LinearProgressIndicator(),
                ],
                if (working) ...[
                  const SizedBox(height: 14),
                  LinearProgressIndicator(value: state.downloadProgress),
                  if (state.statusMessage case final message?) ...[
                    const SizedBox(height: 8),
                    Text(message, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ],
                const SizedBox(height: 16),
                Text(
                  l10n.speechModelDescription,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSpeechModelPicker(BuildContext context) {
    final cubit = context.read<SpeechModelsCubit>();
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const _SpeechModelPickerSheet(),
      ),
    );
  }
}

class _SpeechModelPickerSheet extends StatelessWidget {
  const _SpeechModelPickerSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return SafeArea(
      top: false,
      child: BlocBuilder<SpeechModelsCubit, SpeechModelsState>(
        builder: (context, state) {
          final working = state.status == SpeechModelsStatus.downloading;
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.72,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.chooseSpeechModel,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.chooseSpeechModelDescription,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.status == SpeechModelsStatus.loading)
                  const LinearProgressIndicator(),
                if (working) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: LinearProgressIndicator(
                      value: state.downloadProgress,
                    ),
                  ),
                  if (state.statusMessage case final message?)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
                      child: Text(
                        message,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                ],
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                    itemCount: state.models.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final model = state.models[index];
                      final selected = model.slug == state.selectedModel;
                      final availability = model.isDownloaded
                          ? l10n.modelDownloaded
                          : l10n.modelAvailableToDownload;
                      final details = [
                        if (model.sizeMb case final size?) l10n.modelSize(size),
                        availability,
                        if (selected) l10n.modelSelected,
                      ].join(' · ');
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        leading: Icon(
                          selected
                              ? Icons.radio_button_checked_rounded
                              : model.isDownloaded
                              ? Icons.check_circle_outline_rounded
                              : Icons.cloud_download_outlined,
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                        title: Text(
                          model.displayName,
                          style: TextStyle(
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(details),
                        selected: selected,
                        selectedTileColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        onTap: working
                            ? null
                            : () async {
                                final cubit = context.read<SpeechModelsCubit>();
                                await cubit.selectModel(model.slug);
                                if (!model.isDownloaded) {
                                  await cubit.downloadSelectedModel();
                                }
                                if (context.mounted &&
                                    cubit.state.status ==
                                        SpeechModelsStatus.ready) {
                                  Navigator.pop(context);
                                }
                              },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SpeechModelLabel extends StatelessWidget {
  const _SpeechModelLabel({required this.model});

  final SpeechModel model;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final details = [
      if (model.sizeMb case final size?) l10n.modelSize(size),
      model.isDownloaded ? l10n.modelDownloaded : l10n.modelNotDownloaded,
    ].join(' · ');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 3),
            Text(
              details,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
