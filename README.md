# Bradley Brewington — Portfolio Site

Static portfolio site. Pure HTML/CSS, no build step, no dependencies.

## Local preview

Open `index.html` directly in a browser. That's it. No server required.

For best results, use a simple local server (Python has one built in):

```bash
cd portfolio
python3 -m http.server 8000
```

Then visit http://localhost:8000 in your browser.

## File structure

```
portfolio/
├── index.html                  Homepage (list of projects)
├── about.html                  About page (background, what I'm looking for)
├── resume.html                 Resume page (PDF download + embed)
├── contact.html                Contact info
├── css/
│   └── style.css               Shared stylesheet for all pages
├── projects/
│   ├── eis-instrument.html     EIS Instrument deep-dive (TEMPLATE - completed)
│   ├── camera-platform.html    Camera Platform deep-dive (TO BUILD)
│   ├── spirometer.html         Spirometer deep-dive (TO BUILD)
│   ├── rat-hunter.html         Rat Hunter deep-dive (TO BUILD)
│   └── intech.html             InTech defense work (TO BUILD)
├── images/                     Project images (add yours here)
└── files/                      Resume PDF goes here
```

## What still needs to be built

The EIS Instrument page (`projects/eis-instrument.html`) is complete and serves as the
template. The remaining 4 project pages need to be built using the same structure:

1. **camera-platform.html** — pending Brad's photos / block diagram
2. **spirometer.html** — pending capstone documentation pull
3. **rat-hunter.html** — pending coursework documentation pull
4. **intech.html** — text-only, ITAR-aware framing, no photos

## Adding images

Drop images into `/images/` and reference them in HTML:

```html
<figure>
  <img src="../images/eis-board-bench.jpg" alt="Assembled EIS test board on the bench">
  <figcaption>Assembled test-circuit board during the debug effort, with bench setup.</figcaption>
</figure>
```

The `.image-placeholder` divs in the project pages mark exactly where each image should
go. Replace each placeholder with a `<figure>` block once the actual image is available.

## Adding the resume PDF

Place `Brewington_Resume.pdf` in `/files/`. The resume.html page will auto-link to it.

To embed it inline on resume.html, replace the `.image-placeholder` block with:

```html
<embed src="files/Brewington_Resume.pdf" type="application/pdf" width="100%" height="800px">
```

## Deploying to GitHub Pages

1. Create a new GitHub repository named `bradleybrewington.github.io` (or any name)
2. `git init`, `git add .`, `git commit -m "Initial portfolio"`, `git push`
3. Repo settings → Pages → Source: deploy from main branch, root
4. Site goes live at `https://bradleybrewington.github.io` (or `https://<username>.github.io/<reponame>`)

## Adding a custom domain later

1. Buy domain from Cloudflare Registrar or Namecheap (~$12/year)
2. Add CNAME record pointing to `bradleybrewington.github.io`
3. In GitHub repo settings, set the custom domain
4. Enforce HTTPS (auto-provisioned cert)

## Design system

- Dark base (#0a0a0a), muted amber accent (#d4a45a)
- Monospace headers (JetBrains Mono / system fallback) for technical feel
- Sans-serif body for readability
- Tight to no animations — hover states only
- Max content width 880px for comfortable reading

To adjust colors, edit the `:root` variables at the top of `css/style.css`.
