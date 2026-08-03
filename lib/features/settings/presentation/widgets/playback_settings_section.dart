part of '../settings_screen.dart';

class _PlaybackSettingsSection extends StatelessWidget {
  const _PlaybackSettingsSection();

  static const _skipOptions = [5, 10, 15, 30, 45, 60];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) => previous.playback != current.playback,
      builder: (context, state) {
        final playback = state.playback;
        final cubit = context.read<SettingsCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Playback',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Tune Bookish for narration, sleep, and precise seeking.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.replay_rounded),
                    title: const Text('Rewind interval'),
                    trailing: DropdownButton<int>(
                      value: playback.rewindSeconds,
                      items: [
                        for (final seconds in _skipOptions)
                          DropdownMenuItem(
                            value: seconds,
                            child: Text('$seconds sec'),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          unawaited(
                            cubit.setPlaybackPreferences(
                              playback.copyWith(rewindSeconds: value),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.forward_rounded),
                    title: const Text('Forward interval'),
                    trailing: DropdownButton<int>(
                      value: playback.forwardSeconds,
                      items: [
                        for (final seconds in _skipOptions)
                          DropdownMenuItem(
                            value: seconds,
                            child: Text('$seconds sec'),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          unawaited(
                            cubit.setPlaybackPreferences(
                              playback.copyWith(forwardSeconds: value),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.timer_outlined),
                    title: const Text('Chapter timer fallback'),
                    subtitle: const Text(
                      'Stops even if a chapter boundary is missing',
                    ),
                    trailing: DropdownButton<int>(
                      value: playback.chapterFallbackMinutes,
                      items: const [
                        DropdownMenuItem(value: 0, child: Text('Off')),
                        DropdownMenuItem(value: 15, child: Text('15 min')),
                        DropdownMenuItem(value: 30, child: Text('30 min')),
                        DropdownMenuItem(value: 45, child: Text('45 min')),
                        DropdownMenuItem(value: 60, child: Text('60 min')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          unawaited(
                            cubit.setPlaybackPreferences(
                              playback.copyWith(chapterFallbackMinutes: value),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.fast_forward_rounded),
                    title: const Text('Shorten silence'),
                    subtitle: const Text(
                      'Gently skips quiet gaps on supported devices',
                    ),
                    value: playback.shortenSilence,
                    onChanged: (value) => unawaited(
                      cubit.setPlaybackPreferences(
                        playback.copyWith(shortenSilence: value),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.record_voice_over_rounded),
                    title: const Text('Voice boost'),
                    subtitle: const Text(
                      'Emphasizes narration on supported devices',
                    ),
                    value: playback.voiceBoost,
                    onChanged: (value) => unawaited(
                      cubit.setPlaybackPreferences(
                        playback.copyWith(voiceBoost: value),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.auto_awesome_motion_rounded),
                    title: const Text('Continue series'),
                    subtitle: const Text(
                      'Start the next unfinished volume automatically',
                    ),
                    value: playback.continueSeries,
                    onChanged: (value) => unawaited(
                      cubit.setPlaybackPreferences(
                        playback.copyWith(continueSeries: value),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
