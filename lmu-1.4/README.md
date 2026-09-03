# Le Mans Ultimate 1.4 overlay for GE-Proton11-6

This directory contains the Wine source overlay and patches used to build the
custom LMU compatibility tool.

Base revisions:

- GE-Proton tag: `GE-Proton11-6`
- proton-ge-custom commit: `7e88cefffc122ea1584c2156b8d7bae6cf69b2a7`
- Valve Wine commit: `9358696fe9a2261329f4a83aa6a65fd436106154`

## Changes

- bcrypt `KDF_SECRET_PREPEND` and `KDF_SECRET_APPEND` support required for LMU
  1.4 online communication.
- Direct2D Tint registration, bitmap fallback and colour handling.
- Bitmap-target SpriteBatch execution, including colour and alpha.
- Bitmap-target layers, per-target clip state and corrected compositor bounds.
- Samuel Rounce's CUR/ICO in-memory texture-loading workaround, forward-ported
  to the GE-Proton11-6 Wine source. The original commit was
  `1e2c9c29611850c1887430ad7b65a1a3287dc7fc`.

## Test status

- Offline and RaceControl sessions work in non-VR LMU.
- Audio, the general HUD and MFD, Simagic input and FFB, Simsonn pedals and the
  external telemetry application have been tested.
- The race-start and pit-release countdown colours render correctly.
- Circular rev, brake and throttle rings are composited through their
  geometric and bitmap opacity masks.
- Both 32-bit and 64-bit `d3dx9_36.dll` targets build successfully with warnings
  treated as errors.
- The cursor workaround is included, but VR has not been tested locally because
  no suitable headset is available.

## Layout

- `dlls/d2d1/` contains the Direct2D overlay source.
- `patches/lmu-bcrypt-secret-append.patch` contains the bcrypt changes.
- `patches/lmu-vr-cursor.patch` contains the GE-Proton11-6 cursor forward port.
- `patches/lmu-vr-cursor-original.patch` retains the original patch and
  authorship metadata.

The older HID, DirectInput GUID and `IDirectInput7::FindDevice` changes are not
included. Proton 11 already supplies the required HID behaviour on the tested
non-VR setup.
