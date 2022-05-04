# flutter_bug_editabletext_loses_cursor_position
This sample code provides the minimum code necessary to demonstrate on iOS mobile web browsers (Safari and Chrome) will reset the cursor's position to zero when inserting text into a EditableText widget using a custom keyboard. The widget only loses the cursor position when readOnly is set to true and all new text will be inserted at cursor position 0. You can see the behavior by toggling the read-only switch in the code and pressing one of the three buttons.

## Expected behavior
Entering 'ABAB' using the custom keyboard results in the EditableText displaying 'ABAB'

## Observed behavior on affected platforms (iOS mobile web)
### TextField's readOnly = true
Entering 'ABAB' using the custom keyboard results in the EditableText displaying 'BABA'

### TextField's readOnly = false
Entering 'ABAB' using the custom keyboard results in the EditableText displaying 'ABAB'

## Affected platforms
iOS web browsers (observed in Safari and Chrome) on both real devices (iPhone and iPad) and in the iOS Simulator (iPhone and iPad)

## Unaffected platforms
iOS native app
Android mobile web
Desktop browsers on Windows and OSX (Safari and Chrome)
