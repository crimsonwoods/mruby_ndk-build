mruby build environment for Android NDK
=======================================

'Android.mk' and some files for building the mruby via 'ndk-build'.

# Ready to build
    $ git clone https://github.com/mruby/mruby.git
    $ cd mruby
    $ make
    $ git clone https://github.com/crimsonwoods/mruby_ndk-build.git android

# Run build
    $ cd android/jni
    $ ndk-build
