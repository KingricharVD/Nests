
Debian
====================
This directory contains files used to package nesteggd/nestegg-qt
for Debian-based Linux systems. If you compile nesteggd/nestegg-qt yourself, there are some useful files here.

## nestegg: URI support ##


nestegg-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install nestegg-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your nestegg-qt binary to `/usr/bin`
and the `../../share/pixmaps/pivx128.png` to `/usr/share/pixmaps`

pivx-qt.protocol (KDE)

