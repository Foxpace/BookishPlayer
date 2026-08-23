# Suggested Play Console answers

These answers describe the current store build. Recheck them against the final Android App Bundle and every SDK before submission.

## Store settings

- App or game: App
- Category: Music & Audio
- Suggested tags: Audiobooks, Audio player, Offline
- Ads: No, the app does not contain ads
- App access: All functionality is available without login, membership, location, or special access
- Target audience: Ages 13 and over. The app is not designed primarily for children
- News app: No
- Health app: No
- Government app: No
- Financial features: No

## Reviewer instructions

Bookish does not require an account or internet connection. On first launch, use the add button to choose an audio file through Android's system document picker. The app supports MP3, M4A, M4B, AAC, FLAC, WAV, OGG, and Opus. Playback, chapters, notes, listening insights, settings, backup, and storage tools are then available without restricted access.

No credentials are required.

## Permissions explanation

- Microphone: records a voice note only after the user starts recording
- Music and audio files: the user selects audiobook files through Android's document picker
- Notifications and foreground media playback: keeps playback controllable while Bookish is in the background
- Nearby devices or Bluetooth: lets the user choose and control an audio output when Android requires permission
- Wake lock: prevents an active audiobook from stopping when the screen sleeps
- Internet: declared in the production manifest, but the store build does not send library data to a Bookish server

## Data safety draft

- Does the app collect or share any required user data types? No
- Is all user data encrypted in transit? Not applicable because the publisher does not collect or transmit user data to its servers
- Can users request data deletion? There is no account or publisher-held data. Users can delete books and notes, remove imported files, or reset all app data from the app's storage tools or Android settings
- Account deletion requirement: Not applicable because Bookish has no accounts

Data created by the user, including library metadata, playback history, notes, preferences, and imported audio, remains on the device. System file pickers, export destinations, and share targets operate only after a user action. If the user sends a note or backup to another app or service, that destination's privacy terms apply.

## Content rating draft

Bookish is a utility player and contains no bundled audiobook catalog, social feed, advertising, purchases, gambling, violence, sexual content, controlled substances, or user-to-user communication. Users may import their own audio, but the publisher does not provide or distribute that content. Complete the IARC questionnaire using the exact wording shown in the current console.

## Required publisher fields

Replace these before submission:

- Developer name: `[PUBLISHER NAME]`
- Support email: `[SUPPORT EMAIL]`
- Support website: `[SUPPORT WEBSITE]`
- Privacy-policy URL: `[PUBLIC HTTPS URL FOR privacy-policy.md]`
- Countries and regions: `[DISTRIBUTION CHOICE]`
- Pricing: `[FREE OR PAID]`
