This simple program is a demo of how to do a sharpening zoom.

A sharpening zoom is one that does not become aliased (jagged lines/text) when zooming out or in.

The apple documentation describes this briefly but does not offer an iOS demo program on how to implement a sharpening zoom, only a code snippet.

Also, the apple documentation highlights the limits of text layers which have no SPAA support (no sub-pixel anti-alias support).

This program shows how to do a sharpening zoom, for both geometry and text, whilst avoiding SPAA problems.

The program also shows how to do a frame size calculation so you can get from a NSString to the frame size of the string, so that the text layer can be framed precisely.
