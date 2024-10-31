## Google Navigation Issue

We are currently using the Google Navigation SDK in our production application but we have noticed inconsistent behaviour between iOS and Android.

When starting navigation the speed widget is only displayed when moving and isn't displayed at all when the vehicle is stationary. Although this makes sense for the current speed we're seeing the same behaviour with speed limit.

Steps to Reproduce:

1. Launch the POC
2. Tap on Start Navigation
3. Watch that the speed information is hidden until moving.
4. If become stationary again the speed information is hidden again until moving.
