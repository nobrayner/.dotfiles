1. Perform required system updates
```
sudo dnf update
```
2. Install required graphics drivers (e.g. NVidia `akmod-nvidida`)
```
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install akmod-nvidia
sudo reboot now
```
3. Setup Flatpak
```
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update
```
4. Setup Snap
```
sudo dnf install -y snapd
sudo ln -s /var/lib/snapd/snap /snap # for classic snap support
sudo reboot now
sudo snap refresh
```
6. Setup GNOME Tweaks/extensions
```
sudo dnf install -y gnome-extensions-app gnome-tweaks
sudo dnf install -y gnome-shell-extension-appindicator
```
7. Setup theme
```
# Copy theme
sudo cp -r ~/.dotfiles/themes/Sweet-dark /usr/share/themes
# Copy icon themes
sudo cp -r ~/.dotfiles/themes/Sweet-Rainbow /usr/share/icons
sudo cp -r ~/.dotfiles/themes/candy-icons /usr/share/icons
# Use new theme
gsettings set org.gnome.desktop.interface gtk-theme Sweet-dark
gsettings set org.gnome.desktop.wm.preferences theme Sweet-dark
gsettings set org.gnome.desktop.interface icon-theme Sweet-Rainbow
```
8. Install fonts
```
sudo ~/.dotfiles/fonts/install_linux
```
9. Setup Starship prompt
10. Setup Apps
