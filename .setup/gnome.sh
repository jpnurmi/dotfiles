#!/bin/bassh

echo "Setting up Gnome..."

BGDIR="$HOME/.local/share/backgrounds"
BGURI="file://$BGDIR/earth-timed/earth-timed.xml"

if [ ! -d "$BGDIR/earth-timed" ]; then
    mkdir -p $BGDIR
    git -C $BGDIR clone git://github.com/jpnurmi/earth-timed.git
fi

gsettings set org.gnome.desktop.background picture-uri "$BGURI"
gsettings set org.gnome.desktop.screensaver picture-uri "$BGURI"

if [ ! -d ~/.local/share/themes/Materia ]; then
    git -C /tmp clone --depth 1 https://github.com/nana-4/materia-theme
    /tmp/materia-theme/install.sh --dest ~/.local/share/themes
    rm -rf /tmp/materia-theme
fi

gnome-shell-extension-tool -e user-theme

gsettings set org.gnome.desktop.interface gtk-theme 'Materia-light-compact'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita-Blue-Folders'
gsettings set org.gnome.shell.extensions.user-theme name 'Materia-dark-compact'
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface show-battery-percentage true

gsettings set org.gnome.shell disable-user-extensions false
gsettings set org.gnome.shell favorite-apps "['org.gnome.Evolution.desktop', 'chromium.desktop', 'communi.desktop', 'assistant.desktop', 'org.qt-project.qtcreator.desktop', 'code.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop']"

gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'

EXTENSIONS="\
    appfolders-manager@maestroschan.fr \
    apt-update-indicator@franglais125.gmail.com \
    auto-move-windows@gnome-shell-extensions.gcampax.github.com \
    clipboard-indicator@tudmotu.com \
    cpupower@mko-sl.de \
    drive-menu@gnome-shell-extensions.gcampax.github.com \
    horizontal-workspaces@gnome-shell-extensions.gcampax.github.com \
    openweather-extension@jenslody.de \
    remove-dropdown-arrows@mpdeimos.com \
    ShellTile@emasab.it \
"
for ext in $EXTENSIONS; do
    gnome-extensions install $ext
done
