# Le Mans Ultimate 1.4 overlay for GE-Proton11-6

This directory contains the Wine source overlay and patches used for the
experimental `GE-Proton11-6-LMU-1.4` compatibility tool.

Base revisions:

- GE-Proton tag: `GE-Proton11-6`
- proton-ge-custom commit: `7e88cefffc122ea1584c2156b8d7bae6cf69b2a7`
- Valve Wine commit: `9358696fe9a2261329f4a83aa6a65fd436106154`

## Included work

- bcrypt `KDF_SECRET_PREPEND` / `KDF_SECRET_APPEND` support required for LMU
  1.4 online communication.
- Direct2D Tint registration and LMU bitmap fallback.
- Direct2D Tint colour application for status artwork.
- Bitmap-target SpriteBatch execution, including colour and alpha.
- Bitmap-target SpriteBatch fixes: preserve the device-context transform and
  apply each sprite's RGBA colour exactly once.
- Bitmap-target layers.
- Clip state owned by each bitmap target.
- Layer compositor bounds correction.
- The CUR-file workaround from JacKeTUs Wine commit
  `1e2c9c29611850c1887430ad7b65a1a3287dc7fc`, forward-ported to the
  GE-Proton11-6 Wine source as `patches/lmu-vr-cursor.patch`. The original
  upstream patch and authorship metadata are retained separately as
  `patches/lmu-vr-cursor-original.patch`.

## Validation status

- Offline driving and RaceControl online sessions are validated in non-VR LMU.
- The HUD and MFD render correctly, including the animated colour fill in the
  race-start and pit-release progress bars.
- The CUR/VR workaround is included at the user's request but is **untested
  locally** because no VR headset is available. No claim of working VR support
  is made.
- Both 64-bit and 32-bit `d3dx9_36.dll` targets compile successfully with
  warnings treated as errors. Runtime cursor/VR behaviour remains untested.
- The assembled compatibility tool passes non-VR Tint and HUD regression
  testing.

## Layout

- `dlls/d2d1/`: exact replacement source files for the prepared GE-Proton11-6
  Wine tree.
- `patches/lmu-bcrypt-secret-append.patch`: bcrypt patch.
- `patches/lmu-vr-cursor.patch`: GE-Proton11-6 forward-port of the CUR/VR
  workaround.
- `patches/lmu-vr-cursor-original.patch`: unmodified original workaround.

This branch deliberately excludes the older HID, DirectInput GUID and
`IDirectInput7::FindDevice` changes because Proton 11 already supplies the
needed HID functionality and the tested non-VR input stack works without them.
