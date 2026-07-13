# Bradley Brewington — Portfolio Site

Static portfolio site. Pure HTML/CSS, no build step, no dependencies.
Live at https://bradleybrewington.github.io.

## Local preview

Open `index.html` directly in a browser — no server required. For relative paths to
resolve exactly as they do in production, run a simple local server instead:

```bash
python3 -m http.server 8000
```

Then visit http://localhost:8000.

## Structure

```
index.html                            Homepage — intro + selected work list
resume.html                           Resume (PDF download + embed)
random.html                           Personal / for-fun builds
contact.html                          Contact info
css/style.css                         Shared stylesheet for every page
projects/
  eis-instrument.html                 4-channel EIS instrument
  camera-platform.html                4-axis motorized camera platform
  spirometer.html                     Portable BLE spirometer (capstone)
  rat-hunter.html                     Autonomous mobile robot platform
  msp432-home-security.html           Embedded home security system
images/                               Project photos, schematics, CAD renders
files/                               Resume PDF + linked source/docs
```

## Editing

- Nav lives at the top of every page and must stay identical across all pages
  (`work / resume / random / contact`), with the current page marked `class="active"`.
- Add images to `images/` and reference them with a `<figure>` block:

  ```html
  <figure>
    <img src="../images/eis-board-bench.jpg" alt="Descriptive alt text">
    <figcaption>Caption.</figcaption>
  </figure>
  ```

- Replace the resume at `files/Brewington_Resume.pdf`; `resume.html` links and embeds it.

## Deploying

GitHub Pages serves the `main` branch root automatically. Push to `main` and the live
site updates within a minute or two.

## Design system

- Dark base (`#0a0a0a`), muted amber accent (`#d4a45a`)
- Monospace headers (JetBrains Mono / system fallback), sans-serif body
- Hover-only interaction, max content width 880px

Colors are the `:root` variables at the top of `css/style.css`.
