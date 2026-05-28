#!/usr/bin/env python3
import fcntl, struct, time, sys

EVIOCGRAB = 0x40044590
DEVICE = "/dev/input/event3"

try:
    fd = open(DEVICE, "rb")
    fcntl.ioctl(fd, EVIOCGRAB, struct.pack("I", 1))
    print("Keyboard disabled. Close this window to re-enable.")
    while True:
        time.sleep(60)
except PermissionError:
    print("Permission denied. Run with sudo.")
    sys.exit(1)
except KeyboardInterrupt:
    print("\nKeyboard re-enabled.")
