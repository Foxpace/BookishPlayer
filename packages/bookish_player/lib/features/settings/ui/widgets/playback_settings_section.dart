import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/bookish_switch_list_tile.dart';
import '../../models/playback_preferences.dart';

class PlaybackSettingsSection extends StatelessWidget {
  const PlaybackSettingsSection({
    required this.playback,
    required this.onChanged,
    super.key,
  });

  final PlaybackPreferences playback;
  final ValueChanged<PlaybackPreferences> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).playbackTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          S.of(context).playbackDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 18),
        _PlaybackPreferencesCard(playback: playback, onChanged: onChanged),
      ],
    );
  }
}

class _PlaybackPreferencesCard extends StatelessWidget {
  const _PlaybackPreferencesCard({
    required this.playback,
    required this.onChanged,
  });

  final PlaybackPreferences playback;
  final ValueChanged<PlaybackPreferences> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _SkipPreferences(playback: playback, onChanged: onChanged),
          const Divider(height: 1),
          _PlaybackBehaviorPreferences(
            playback: playback,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _SkipPreferences extends StatelessWidget {
  const _SkipPreferences({required this.playback, required this.onChanged});

  final PlaybackPreferences playback;
  final ValueChanged<PlaybackPreferences> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SkipIntervalTile(
          icon: Icons.replay_rounded,
          title: S.of(context).rewindInterval,
          value: playback.rewindSeconds,
          onChanged: (value) =>
              onChanged(playback.copyWith(rewindSeconds: value)),
        ),
        const Divider(height: 1),
        _SkipIntervalTile(
          icon: Icons.forward_rounded,
          title: S.of(context).forwardInterval,
          value: playback.forwardSeconds,
          onChanged: (value) =>
              onChanged(playback.copyWith(forwardSeconds: value)),
        ),
        const Divider(height: 1),
        _ChapterFallbackTile(
          value: playback.chapterFallbackMinutes,
          onChanged: (value) =>
              onChanged(playback.copyWith(chapterFallbackMinutes: value)),
        ),
      ],
    );
  }
}

class _PlaybackBehaviorPreferences extends StatelessWidget {
  const _PlaybackBehaviorPreferences({
    required this.playback,
    required this.onChanged,
  });

  final PlaybackPreferences playback;
  final ValueChanged<PlaybackPreferences> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PlaybackSwitchTile(
          icon: Icons.fast_forward_rounded,
          title: S.of(context).shortenSilence,
          description: S.of(context).shortenSilenceDescription,
          value: playback.shortenSilence,
          onChanged: (value) =>
              onChanged(playback.copyWith(shortenSilence: value)),
        ),
        const Divider(height: 1),
        _PlaybackSwitchTile(
          icon: Icons.record_voice_over_rounded,
          title: S.of(context).voiceBoost,
          description: S.of(context).voiceBoostDescription,
          value: playback.voiceBoost,
          onChanged: (value) => onChanged(playback.copyWith(voiceBoost: value)),
        ),
        const Divider(height: 1),
        _PlaybackSwitchTile(
          icon: Icons.auto_awesome_motion_rounded,
          title: S.of(context).continueSeries,
          description: S.of(context).continueSeriesDescription,
          value: playback.continueSeries,
          onChanged: (value) =>
              onChanged(playback.copyWith(continueSeries: value)),
        ),
      ],
    );
  }
}

class _SkipIntervalTile extends StatelessWidget {
  const _SkipIntervalTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  static const _options = [5, 10, 15, 30, 45, 60];

  final IconData icon;
  final String title;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final options = {..._options, value}.toList()..sort();
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: DropdownButton<int>(
        value: value,
        items: [
          for (final seconds in options)
            DropdownMenuItem(
              value: seconds,
              child: Text(S.of(context).secondsShort(seconds)),
            ),
        ],
        onChanged: (selection) {
          if (selection != null) {
            onChanged(selection);
          }
        },
      ),
    );
  }
}

class _ChapterFallbackTile extends StatelessWidget {
  const _ChapterFallbackTile({required this.value, required this.onChanged});

  static const _options = [0, 15, 30, 45, 60];

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => ListTile(
    leading: const Icon(Icons.timer_outlined),
    title: Text(S.of(context).chapterTimerFallback),
    subtitle: Text(S.of(context).chapterFallbackDescription),
    trailing: DropdownButton<int>(
      value: value,
      items: [
        for (final minutes in {..._options, value}.toList()..sort())
          DropdownMenuItem(
            value: minutes,
            child: Text(
              minutes == 0
                  ? S.of(context).off
                  : S.of(context).minutesShort(minutes),
            ),
          ),
      ],
      onChanged: (selection) {
        if (selection != null) {
          onChanged(selection);
        }
      },
    ),
  );
}

class _PlaybackSwitchTile extends StatelessWidget {
  const _PlaybackSwitchTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => BookishSwitchListTile(
    content: (icon: icon, title: Text(title), subtitle: Text(description)),
    value: value,
    onChanged: onChanged,
  );
}
