# Bolt Inspection & Training — Flutter Web

Public marketing site + Firebase-backed admin panel, built with Flutter Web.

## 1. First-time setup

```bash
flutter pub get
```

## 2. Connect Firebase (required before the contact form or admin panel work)

1. Install the FlutterFire CLI once: `dart pub global activate flutterfire_cli`
2. From the project root, run: `flutterfire configure`
   - Select (or create) your Firebase project
   - Select **Web** as the platform
   - This overwrites `lib/firebase_options.dart` with your real project's values — the file currently in this project is a placeholder and will not connect to anything.
3. In the Firebase Console, enable:
   - **Authentication** → Sign-in method → Email/Password
   - **Firestore Database** → Create database (production mode)
4. Under Authentication → Users → Add user, create your admin login (this is the only way to create an admin account — there is no public sign-up screen by design).
5. Apply the Firestore security rules below (Firestore → Rules tab).

### Firestore security rules

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Anyone can submit the contact form, no one but an authenticated
    // admin can read, edit, or delete submissions.
    match /contact_submissions/{docId} {
      allow create: if true;
      allow read, update, delete: if request.auth != null;
    }

    // Homepage content: publicly readable (so the site renders),
    // only an authenticated admin can write.
    match /site_content/{docId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

## 3. Run locally

```bash
flutter run -d chrome
```

## 4. Build & deploy

```bash
flutter build web
firebase init hosting   # first time only — point it at the build/web folder
firebase deploy
```

## 5. Required assets

The app runs with graceful fallbacks if these are missing (colored placeholder boxes/text instead of broken images), so you can drop them in whenever they're ready — nothing blocks `flutter run` in the meantime.

All icons in the app (service icons, stat icons, nav/social/contact icons) are built with Flutter's built-in Material Icons directly in code — **no icon image files needed at all.** Only these photographic/logo assets need to be supplied:

| # | Filename | Folder | Size (px) | Source |
|---|---|---|---|---|
| 1 | `logo_color.png` | `assets/logos/` | Export at 400×~120 (transparent bg) | Your real logo file — already have this |
| 2 | `logo_white.png` | `assets/logos/` | Same dimensions as #1 | Needs creating — see Prompt A below |
| 3 | `hero_crane_inspection.jpg` | `assets/images/` | 1920×900 min | AI-generated or real photography — see Prompt B |
| 4 | `cert_iso_9001.png` | `assets/certifications/` | 300×300, transparent bg | Official ISO 9001 badge artwork |
| 5 | `cert_iso_17020.png` | `assets/certifications/` | 300×300, transparent bg | Official ISO 17020 badge artwork |
| 6 | `cert_vision_2030.png` | `assets/certifications/` | 300×300, transparent bg | Official Vision 2030 logo |
| 7 | `cert_saudi_accreditation.png` | `assets/certifications/` | 300×300, transparent bg | Official Saudi Accreditation Center logo |
| 8 | `favicon.png` | `web/` | 32×32 | Cropped from logo icon mark |
| 9 | `icons/Icon-192.png` | `web/` | 192×192 | Cropped from logo icon mark |
| 10 | `icons/Icon-512.png` | `web/` | 512×512 | Cropped from logo icon mark |
| 11 | `icons/apple-touch-icon.png` | `web/` | 180×180 | Cropped from logo icon mark |

### Prompt A — white/mono logo variant

Attach your real logo image to this prompt so it has the exact shapes to convert:

```
Take the attached logo exactly as-is — same letterforms, same bolt-thread icon 
shape, same proportions, same layout — and output only a color change: convert 
every element (the "Bölt" wordmark, the bolt-thread icon, the "inspection & 
Training" tagline text) to solid white (#FFFFFF), on a transparent background. 
Do not redraw, restyle, resize, or alter the design in any way — this is a 
recolor only, not a redesign.
```

### Prompt B — hero photo

```
A realistic photograph, industrial/documentary style, of a heavy-equipment 
inspection site in Saudi Arabia at golden hour. Foreground: a man in a white 
hard hat and a high-visibility navy-and-yellow safety vest, seen from behind/
side, looking out at the site. Background: a large yellow mobile crane lifting 
a shipping container, cables and rigging visible, industrial port/construction 
setting, dramatic sky with scattered clouds. Wide 16:9 composition with open 
space on the left third of the frame for text overlay. Natural lighting, 
slightly desaturated professional color grade, no text or logos baked into 
the image itself.
```

Take a screenshot crop from the approved mockup (Image 1) if you want to match that exact framing more closely — feed that screenshot into the same prompt as a style reference.

### Certification badges (#4–7)

These are official third-party marks (ISO, Saudi government bodies) — best to source the real transparent-PNG versions from the certifying/government bodies rather than AI-generating approximations, since a recreated badge could misrepresent the actual accreditation. If you don't have the official files, let me know and we'll figure out the right source together.

## 6. Project structure

```
lib/
  main.dart                  — app entry point, routes, Firebase init
  firebase_options.dart      — placeholder, replaced by `flutterfire configure`
  theme/                     — brand colors + ThemeData
  models/                    — plain data classes
  services/                  — Firebase Auth + Firestore wrappers
  widgets/                   — shared UI pieces (nav, footer, cards, forms, admin shell)
  screens/                   — one file per page
  screens/admin/             — admin panel screens (login, dashboard, messages, content, media)
assets/
  logos/  images/  certifications/   — see table above
web/                          — Flutter web shell + PWA manifest/icons
```

## 7. What's stubbed / next increments

- **Media manager** (`admin/media`) shows the correct layout but upload-from-dashboard isn't wired yet — needs the `firebase_storage` package added and Storage enabled on your Firebase project. Small, isolated follow-up.
- **SEO**: Flutter Web (CanvasKit) indexes poorly by default. If organic search matters a lot, ask about switching the web renderer or adding prerendered meta tags later.
