# Android Camera Lifecycle Fix

## Problem

On Android, the `Live Camera Scan` screen worked the first time it opened, but after navigating back and reopening the screen the preview either did not appear or came back as a black view.

This issue was specific to the React Native integration. The Android SDK is already used by native Android apps in production, so the fix needed to preserve the existing native SDK behavior and add React Native specific handling only where necessary.

## Analysis

- The camera implementation is backed by a shared `CDCamera` / CameraX instance, while the React Native screen is mounted and unmounted as the user navigates.
- When the screen was removed, the React Native host view for the preview was destroyed, but the native preview state could still be partially retained.
- Preview ownership was split across multiple layers, which made attach/detach timing fragile during remount.
- On reopen, CameraX could end up trying to reuse an old preview surface hierarchy that no longer matched the current React Native view tree.

The result was a lifecycle mismatch: React Native expected a fresh view attachment on each screen mount, while the native camera layer was still holding onto stale preview state.

## Fix

The fix was split into two parts:

1. React Native SDK changes to make preview attachment and detachment deterministic during screen mount/unmount.
2. Android SDK changes to add a React Native specific way to refresh the CameraX preview surface without changing the existing native Android app flow.

## React Native SDK Changes

### Problem

The React Native bridge was not the single owner of preview lifecycle operations, and preview cleanup could race with the next mount.

### Analysis

- `CustomView` could remove and reattach preview views around the same time that the module and view manager were also updating preview state.
- `CDCameraViewManager` was doing more than hosting the current React Native view.
- Preview work needed to be centralized so React Native navigation events always led to a predictable native sequence.

### Fix

- `CustomView.kt`
  - Tracked the current preview view explicitly.
  - Added immediate preview clearing to avoid async detach races during remount.
- `CDCameraViewManager.kt`
  - Stopped owning camera start/stop behavior.
  - Reduced responsibility to registering the active host view and attaching or clearing the current preview.
- `CDCameraModule.kt`
  - Became the single owner of preview attach/detach.
  - Moved preview work onto the main thread.
  - Cleared the hosted preview before stopping preview/camera.
  - On `startPreview()`, first requested a React Native specific preview refresh from the Android SDK, then attached the returned preview to the current host view.

These changes aligned the React Native screen lifecycle with the Android preview lifecycle.

## Android SDK Changes

### Problem

Even after React Native lifecycle ownership was cleaned up, CameraX could still reuse a stale `PreviewView` / parent hierarchy from the previous mount.

### Analysis

- The Android SDK keeps camera state in shared objects, which is appropriate for native Android usage.
- React Native remounts the preview host view between navigations, so the CameraX preview surface needs to be recreated before reattaching preview on the next mount.
- Changing existing public preview behavior for native Android customers was not desirable.

### Fix

- `CDCamera.java`
  - Added an additive React Native specific entry point: `refreshPreviewViewForReactNative()`.
  - This delegates only when the active wrapper is `CDCameraX`.
- `CDCameraX.java`
  - Added `refreshPreviewViewForReactNative()`.
  - Cleared the old surface provider.
  - Detached the previous `PreviewView` from any parent.
  - Reset the highlight/preview container.
  - Created a fresh `PreviewView` and wrapper layout for the next React Native mount.

This kept the change isolated to the React Native integration path while preserving the existing Android SDK flow for native app customers.
