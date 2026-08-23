# Google Play submission pack

Run the preparation script from anywhere in the repository:

```sh
./store/google_play/prepare.sh
```

The script needs ImageMagick 7. It rebuilds and validates:

- `assets/app-icon-512.png`, 512 × 512 and under 1 MB
- `assets/feature-graphic-1024x500.png`, 1024 × 500 and under 15 MB
- four portrait screenshots in `assets/phone`, each 1080 × 1920 and under 8 MB

Copy listing text from `listing-en-US.md`. Use `play-console-answers.md` for the surrounding declarations, publish `privacy-policy.md` at a public HTTPS URL after replacing its placeholders, and copy screenshot descriptions from `asset-notes.md`.

The current official requirements used for this pack are linked in `policy-references.md`.

Before upload, regenerate the deterministic source screenshots if the visible app UI changed:

```sh
./tool/generate_readme_screenshots.sh
./store/google_play/prepare.sh
```

The video is optional. `video-plan.md` contains a short capture plan if you decide to add one.

## Final checks

- Replace every value wrapped in square brackets.
- Compare the Data safety draft with the final release bundle and SDK list.
- Confirm that the production app behaves like the listing and screenshots.
- Confirm rights to every visible cover image.
- Upload assets in the order documented in `asset-notes.md`.
- Complete IARC content rating using the live questionnaire.
- Build the release only through `./tool/build_store.sh android`.
