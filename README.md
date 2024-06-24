## Google Navigation Issue

We are currently using the Google Navigation SDK in our production application but since using Hybrid map type we have noticed a flashing glitch when starting navigation.

Steps to Reproduce:

1. Launch the POC
2. Tap on Start Navigation
3. Watch for the map "flashing white".

On closer inspection it looks like the map is repainting every time. This doesn't happen in other map types but more noticeable using the .hybrid map type.

Expected result:

1. Launch the POC
2. Tap on Start Navigation
3. Navigation starts without flashing or repainting the map.
