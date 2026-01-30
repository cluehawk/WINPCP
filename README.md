# WINPCP
Windows 3.0/3.1 drivers for Plantronics Color Plus CGA video Cards. 640x200x4 colors.

# WINPCP  
**Windows 3.0/3.1 Display Driver for Plantronics Color Plus and other supported clone CGA video Cards at 640x200x4 colors.**

WINPCP is a custom **Windows 3.0/3.1 display driver** targeting **Plantronics Color Plus–compatible graphics hardware**, providing **640×200 resolution with 4 colors (2 bpp)** using the classic CGA-style interleaved video memory layout.

**WIN** = Windows  
**PCP** = Plantronics Color Plus  

---

## Project Goals

- Implement a **fully functional Windows 3.0/3.1 display drivers** for:
  - Plantronics Color Plus
  - Twinhead CT-6190G
  - VTECH CGA/MDA cards with VTCL 27-0739-01 chip
  - ATI Small Wonder
- Support:
  - 640×200 resolution
  - 4-color (2 bpp) graphics using **two 1-bpp planes**
  - Correct CGA even/odd scanline interleave
- Behave compatibly with stock Windows 3.0 GDI expectations
- Run on **real vintage hardware**, not just emulators

---

## Hardware Target

Known / expected compatible hardware includes:

- Plantronics Color Plus
- Twinhead CT-6190G series
- Yamaha V6355-based CGA/Plantronics-compatible cards
- VTECH CGA/MDA cards with VTCL 27-0739-01 chip
- ATI Small Wonder
- Other CGA-derived cards supporting Plantronics memory banking

Video memory model (per plane):

```

B800:0000  plane 0, even scanlines
B800:2000  plane 0, odd  scanlines
B800:4000  plane 1, even scanlines
B800:6000  plane 1, odd  scanlines

```

Scanline stepping follows the classic CGA pattern:

- even → odd:  +2000h  
- odd  → even: +2000h + wrap correction (+80A0h)

---

## Technical Approach

This driver is being developed using a **hybrid reference strategy**:

- **Behavioral contract**  
  - Windows 3.0 `CGA.DRV`
  - Windows 3.0 `TANDYDSP.DRV`
- **Hardware truth**  
  - GEM Plantronics driver (`pla_drv1.a86`)
  - Plantronics Color Plus hardware documentation
  - Empirical testing on real hardware

Text rendering, BitBlt, and fills are implemented by expanding pixels into **two 1-bpp planes**, using masked replace operations:

```

dst = (dst & ~mask) | (mask & fill)

```

Foreground and background colors are mapped per plane using `00h` / `FFh` fill bytes derived from GDI draw modes.

---

## Current Status

🟡 **In development**

High-level progress:
- [x] Hardware memory layout confirmed
- [x] CGA interleave stepping verified
- [x] Text glyph expansion logic reverse-engineered from TANDYDSP
- [ ] Driver `Enable` / `Disable` skeleton
- [ ] Core VRAM primitives
- [ ] BitBlt / PatBlt
- [ ] ExtTextOut (text rendering)
- [ ] Cursor support
- [ ] Final integration and testing

This repository is being built incrementally, with correctness prioritized over speed.

---

## Repository Layout

```

WINPCP/
docs/
notes/          Development notes and reverse-engineering findings
references/     Public or user-provided reference material
src/
drv/            Driver source code
inc/            Headers, constants, and shared definitions
build/          Build scripts and toolchain notes
tests/
dos/            DOS-side hardware and VRAM tests
win3/           Windows 3.0 test applications

```

Licensed or proprietary materials (e.g., full Windows DDK distributions) are **not** committed to this repository.

---

## Build Environment

Planned build environment:
- MS-DOS
- Windows 3.0 DDK
- MASM + LINK (period-correct toolchain)

Exact build steps will be documented once the driver skeleton is in place.

---

## Why This Exists

Windows 3.0 never shipped with native support for Plantronics Color Plus graphics and video card Manufactures did not provide drivers for their compatible cards.

WINPCP exists to:
- Preserve and document this hardware
- Enable historically accurate Windows environments
- Provide a clean, well-documented example of a non-VGA Windows display driver

---

## Status Disclaimer

This is a **retro-computing research project**.

Expect:
- incomplete features
- temporary hacks
- verbose documentation
- a strong preference for clarity over cleverness

---

## License

To be determined.  
Likely a permissive license covering original source code only.

---

## Acknowledgements

- Microsoft Windows 3.0 DDK
- GEM / Digital Research Plantronics drivers
- The vintage PC and retro-computing community
- Real hardware testing (the only truth that matters)



