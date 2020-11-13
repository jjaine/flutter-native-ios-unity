# Add Unity as a subview to Flutter app

The repository contains a Flutter app that has a Unity view embedded as a subview.
The app includes a button to start the Unity app and unload it. 

On the iOS side the Unity window is forced inside an UIView to make it possible
to show it as a subview. The UIView is the view that the Flutter project adds
with the native communication. 

Implemented with Swift on the iOS side.

The Unity project is a very simple project with a sphere in the center of the
scene that can be dragged with the mouse. The Unity project is built for the
simulator, but should also work on the device.

Using Unity 2020.1.12f1 and Xcode 12.1.

The following official example from Unity on how to include Unity as a library
for an iOS app was helpful putting together this example:
https://github.com/Unity-Technologies/uaal-example

