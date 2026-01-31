public Enable, Disable, Inquire, Control, DeviceMode
public BitBlt, PatBlt, Pixel, LineTo, ScanLR
public SetCursor, MoveCursor, CheckCursor

Enable      proc far  ; signature varies; stub only
    xor ax, ax
    xor dx, dx
    retf
Enable endp

; ...repeat similarly for other exports...
