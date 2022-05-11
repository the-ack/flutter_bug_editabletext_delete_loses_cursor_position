# flutter_bug_editabletext_delete_loses_cursor_position
This sample code provides the minimum code necessary to demonstrate on iOS mobile web browsers (Safari and Chrome) will reset the cursor's position to zero when deleting text entered in a EditableText widget using a custom keyboard. The widget only loses the cursor position when readOnly is set to TRUE and after the first delete, the cursor position resets to 0. You can see the behavior by toggling the read-only switch in the code, entering some text, and pressing the backspace button.

## Expected behavior
1. Entering 'A B A B A' using the custom keyboard results in the EditableText displaying 'A B A B A'
2. Click in the EditableText field to set the cursor to be after the second A (cursor position 5) 
3. Press Backspace to delete the second 'A', resulting in EditableText displaying 'A B  B A ' (two spaces between the B's). The cursor should be at position 4.
4. Press Backspace again to delete the first space after the first 'B', resulting in EditableText displaying 'A B B A' and the cursor position will now be a position 3.
5. Continuing to press Backspace to remove the character until the cursor reaches position 0. Final result would be ' B A'.

## Observed behavior on affected platforms (iOS mobile web)
### EditableText's readOnly = true
1. Enter 'A B A B A' using the custom keyboard results in the EditableText displaying 'A B A B A'
2. Click in the EditableText field to set the cursor to be after the second A (cursor position 5) 
3. Cursor moves to position 6 (right before the second 'B') not position 5.
4. Pressing Backspace deletes the space resulting in 'A B AB A'.
5. The cursor jumps to position 0 instead of staying at position 5.
6. Click to move the cursor at position 5 will result in the cursor being placed at position 4.
7. Any further click in the EditableText field will lock the cursor at position 0. Attempting to move the cursor from position 0 to any other position will result in it snapping back to position 0.

### EditableText's readOnly = false
1. Enter 'A B A B A' using the custom keyboard results in the EditableText displaying 'A B A B A'
2. Click in the EditableText field to set the cursor to be after the second A (cursor position 5) 
3. Cursor moves to position 6 (right before the second 'B') not position 5.
4. Pressing Backspace deletes the space resulting in 'A B AB A'.
5. The cursor remains at position 5.
6. Pressing Backspace deletes the second 'A' resulting in 'A B B A'.
7. Continuing to press Backspace will delete the character in front of the cursor until the cursor position reaches 0, leaving the field to read 'B A'.

Note: If you attempt to move the cursor to a different position in the EditableText field by clicking anywhere in the field, the cursor will snap to position 0 and cannot be moved from position 0 by clicking anywhere else in the field.

## Affected platforms
iOS web browsers (observed in Safari and Chrome) on both real devices (iPhone and iPad) and in the iOS Simulator (iPhone and iPad)

## Unaffected platforms
iOS native app
Android mobile web
Desktop browsers on Windows and OSX (Safari and Chrome)
Not tested: Android native app