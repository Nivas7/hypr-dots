#!/usr/bin/env python

import os
import sys
import subprocess

def change_gtk_settings(settings_path, theme, size):
    lines = []
    with open(settings_path, 'r') as file:
        lines = file.readlines()

    with open(settings_path, 'w') as file:
        for line in lines:
            if line.startswith('gtk-cursor-theme-name'):
                file.write(f'gtk-cursor-theme-name={theme}\n')
            elif line.startswith('gtk-cursor-theme-size'):
                file.write(f'gtk-cursor-theme-size={size}\n')
            else:
                file.write(line)

def change_hyprland_settings(settings_path, theme, size):
    lines = []
    with open(settings_path, 'r') as file:
        lines = file.readlines()

    # Hardcoded (doesn't respect hyprlang, needs uncommented lines)
    hypr_strings = ['env = XCURSOR_THEME', 'env = HYPRCURSOR_THEME',
                    'env = XCURSOR_SIZE', 'env = HYPRCURSOR_SIZE']
    with open(settings_path, 'w') as file:
        for line in lines:
            if line.startswith(hypr_strings[0]):
                file.write(f'{hypr_strings[0]}, {theme}\n')
            elif line.startswith(hypr_strings[1]):
                file.write(f'{hypr_strings[1]}, {theme}\n')
            elif line.startswith(hypr_strings[2]):
                file.write(f'{hypr_strings[2]}, {size}\n')
            elif line.startswith(hypr_strings[3]):
                file.write(f'{hypr_strings[3]}, {size}\n')
            else:
                file.write(line)

def set_cursor(cursor_theme, cursor_size):
    print(f'Trying to set the "{cursor_theme}" ({cursor_size} px) theme')

    # GTK 2, 3 and 4 config files (assumes standard locations)
    gtk2_rc_path = os.path.expanduser('~/.gtkrc-2.0')
    gtk3_ini_path = os.path.expanduser('~/.config/gtk-3.0/settings.ini')
    gtk4_ini_path = os.path.expanduser('~/.config/gtk-4.0/settings.ini')

    change_gtk_settings(gtk2_rc_path, f'"{cursor_theme}"', cursor_size)
    change_gtk_settings(gtk3_ini_path, cursor_theme, cursor_size)
    change_gtk_settings(gtk4_ini_path, cursor_theme, cursor_size)

    # Update dconf with gsettings (needs existing dconf database)
    subprocess.run(['gsettings', 'set', 'org.gnome.desktop.interface',
                    'cursor-theme', cursor_theme])
    subprocess.run(['gsettings', 'set', 'org.gnome.desktop.interface',
                    'cursor-size', cursor_size])

    # Check if gsettings changed
    print('From Gsettings (theme and size):')
    subprocess.run(['gsettings', 'get', 'org.gnome.desktop.interface', 'cursor-theme'])
    subprocess.run(['gsettings', 'get', 'org.gnome.desktop.interface', 'cursor-size'])

    # hyprland.conf
    hyprland_config_path = os.path.expanduser('~/.config/hypr/hyprland.conf')
    change_hyprland_settings(hyprland_config_path, cursor_theme, cursor_size)

    # Hyprctl (also updates dconf)
    print('From Hyprctl (ok or not):')
    subprocess.run(['hyprctl', 'setcursor', f'{cursor_theme}', f'{cursor_size}'])

def main():
    cur_theme = sys.argv[1]
    cur_size = sys.argv[2]
    set_cursor(cur_theme, cur_size)

if __name__ == '__main__':
    main()
