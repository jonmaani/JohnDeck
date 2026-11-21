![John Deck monogram](assets/jd-mark.png)

# John Deck

John Deck turns a phone into a companion clock and control deck for a Windows laptop. I built it for my own desk, then refined the phone layout, tray controls and JD monogram through everyday use. For the public edition, each person should be able to choose the apps they actually use.

## App picker preview

Open Windows PowerShell in this folder and run `& .\launcher\picker.ps1`. Choose up to six apps from the Windows Start list and click **Save applications**. Run the picker again to change the selection. Closing the window without saving discards edits.

The picker starts with an empty selection. Windows supplies the application names and identifiers. Selections stay on the PC in `%LOCALAPPDATA%\JohnDeck\launcher-apps.json`. This preview is a standalone component. The packaged 1.2.6 phone launcher does not read this file.

## Desktop and phone setup in the existing personal edition

Start the Windows dashboard, connect the phone to the same local network and use **Copy phone link**. The 1.2.6 server uses HTTPS with a local certificate. Export the certificate with **Save phone certificate** and install the certificate from your own PC on the phone. On iPhone, enable full trust for that profile. Open the complete phone link, including the port, and follow the pairing prompt. iPhone connectivity after trusting the certificate remains under investigation.

Closing the dashboard hides it in the tray. **Quit John Deck** closes the app and server. Use the device-limit control to manage the number of paired connections.

## Release status

The public installer is pending. The existing Windows installer includes Sonar and personal app shortcuts. To finish the public build, wire the picker into the Windows dashboard, load its saved app IDs in the authenticated phone launcher, resolve launches against the saved selection, remove personal presets and Sonar integration, and test on Windows and a paired phone before tagging a release.
