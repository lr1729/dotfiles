import re
from xkeysnail.transform import *

define_keymap(re.compile("konsole"), {
    K("Shift-Space"): K("C-M-A"),
    K("C-Space"): K("C-M-B"),
}, "Vim mapping")

define_keymap(re.compile("Firefox|Google-chrome"), {
    # Ctrl+Alt+j/k to switch next/previous tab
    K("capslock"): K("backspace"),
}, "Firefox and Chrome")
