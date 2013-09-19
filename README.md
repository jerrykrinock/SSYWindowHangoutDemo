SSYWindowHangoutDemo
====================

Demonstrates the SSYWindowHangout class, which provides a global place
for window controllers that control transient windows to "hang out" without being
deallocced.  The idea is to avoid junking up your app delegate with
repeated boilerplate code and instance variables.

A transient window might be, for example, a Preferences window.

The demo shows that you can create a window either in code, using
-initWithWindow, or from a nib, using -initWithWindowNibName:.  When the demo
first launches, you see two windows (one may be hidden, I'm not sure why),
one made each way.  Click in the Window menu to create more windows of either
type.  Now, close any window and watch in the console to see 1 window and 1
window controller deallocced.
