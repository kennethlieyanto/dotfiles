#!/usr/bin/env python3
import i3ipc
import sys

def focus_tab(tab_number):
    i3 = i3ipc.Connection()
    focused = i3.get_tree().find_focused()
    
    # Check if we're in a tabbed container
    if focused.parent.layout == 'tabbed':
        tabs = focused.parent.nodes
        if 0 < tab_number <= len(tabs):
            tabs[tab_number - 1].command('focus')

if __name__ == '__main__':
    if len(sys.argv) > 1:
        focus_tab(int(sys.argv[1]))
