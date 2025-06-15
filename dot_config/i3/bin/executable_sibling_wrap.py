#!/usr/bin/env python3

import i3ipc
import sys

def focus_sibling_with_wrap(direction):
    """
    Focus next/prev sibling with wrapping behavior
    direction: 'next' or 'prev'
    """
    i3 = i3ipc.Connection()
    
    # Get the current focused window
    focused = i3.get_tree().find_focused()
    if not focused:
        return
    
    # Get parent container
    parent = focused.parent
    if not parent:
        return
    
    # Get all focusable siblings
    siblings = [node for node in parent.nodes if node.type in ['con', 'floating_con']]
    
    if len(siblings) <= 1:
        return
    
    # Find current window index
    try:
        current_index = siblings.index(focused)
    except ValueError:
        return
    
    # Calculate next index with wrapping
    if direction == 'next':
        next_index = (current_index + 1) % len(siblings)
    else:  # prev
        next_index = (current_index - 1) % len(siblings)
    
    # Focus the target sibling
    target_id = siblings[next_index].id
    i3.command(f'[con_id={target_id}] focus')

if __name__ == '__main__':
    if len(sys.argv) != 2 or sys.argv[1] not in ['next', 'prev']:
        print("Usage: i3_sibling_wrap.py [next|prev]")
        sys.exit(1)
    
    focus_sibling_with_wrap(sys.argv[1])
