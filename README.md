# flutter_bug_editabletext_delete_loses_cursor_position
This sample code provides the minimum code necessary to demonstrate on iOS mobile web browsers (Safari and Chrome) will reset the cursor's position to zero when deleting text entered in a EditableText widget using a custom keyboard. The widget only loses the cursor position when readOnly is set to TRUE and after the first delete, the cursor position resets to 0. You can see the behavior by toggling the read-only switch in the code, entering some text, and pressing the backspace button.

## Expected behavior
1. Entering 'ABAB' using the custom keyboard results in the EditableText displaying 'ABAB'
2. Press Backspace to delete the last character, resulting in EditableText displaying 'ABA'
3. Press Backspace to delete the last character, resulting in EditableText displaying 'AB'

## Observed behavior on affected platforms (iOS mobile web)
### TextField's readOnly = true
1. Enter 'ABAB' using the custom keyboard results in the EditableText displaying 'ABAB'
2. Press Backspace to delete the last character, resulting in EditableText displaying 'ABA'
3. The cursor jumps to position 0 in the EditableText field.
4. Pressing Backspace again will not delete anything since the cursor is already at position 0.


### TextField's readOnly = false
1. Enter 'ABAB' using the custom keyboard results in the EditableText displaying 'ABAB'
2. Press Backspace to delete the last character, resulting in EditableText displaying 'ABA'
3. Press Backspace again to delete the last character, resulting in EditableText displaying 'AB'
4. Continue pressing Backspace until all of the characters are deleted

## Affected platforms
iOS web browsers (observed in Safari and Chrome) on both real devices (iPhone and iPad) and in the iOS Simulator (iPhone and iPad)

## Unaffected platforms
iOS native app
Android mobile web
Desktop browsers on Windows and OSX (Safari and Chrome)
Not tested: Android native app