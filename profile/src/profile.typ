// GitHub organisation profile banner, in the documents' masthead style.
// Build from this folder with the fonts from company-brain/assets/fonts:
//   TYPST_FONT_PATHS=<company-brain>/assets/fonts typst compile --root . --ignore-system-fonts --ppi 144 profile.typ ../banner.png
#let navy = rgb("#00145B")
#let paper = rgb("#FFFFFF")
#let soft = paper.transparentize(28%)
#let faint = paper.transparentize(55%)
#let hair = paper.transparentize(78%)
#let display = ("Cabinet Grotesk",)
#let body = ("Manrope",)
#let mono = ("JetBrains Mono",)

#set text(font: body, fill: paper, size: 20pt, weight: 400)
#set par(justify: false)

// Terrain fitted to cover a box, shifted by a horizontal focus.
#let terrain(file, w, h, iw, ih, focus) = {
  let s = calc.max(w / iw, h / ih)
  place(top + left, dx: -(iw * s - w) * focus, dy: -(ih * s - h) / 2,
    image(file, width: iw * s, height: ih * s))
}

// 1. Hero banner -------------------------------------------------------------
#let hero = block(width: 1280pt, height: 680pt, clip: true, fill: navy)[
  #terrain("terrain-platform.svg", 1280pt, 680pt, 1480pt, 1000pt, 0.55)
  // Veil on the left so the copy sits on navy, contours stay sharp on the right.
  #place(top + left, rect(width: 100%, height: 100%, stroke: none, fill: gradient.linear(
    (navy, 0%), (navy.transparentize(8%), 38%), (navy.transparentize(100%), 74%), (navy.transparentize(100%), 100%),
  )))
  #place(top + left, dx: 88pt, dy: 80pt, block(width: 900pt, {
    set block(spacing: 0pt)
    set par(spacing: 0pt)
    image("pilae-wordmark-white.svg", height: 100pt)
    block(height: 84pt)
    block({
      set text(font: display, size: 66pt, weight: 500, tracking: -0.03em)
      set par(leading: 0.33em)
      [Open-source apps\ on your infra,\ run by AI agents.]
    })
    block(height: 56pt)
    block({
      set text(size: 24pt, fill: soft)
      set par(leading: 0.62em)
      [We deploy, patch and monitor your apps.\ Agents plan changes for your approval.]
    })
  }))
  #place(bottom + left, dx: 88pt, dy: -60pt, {
    set text(font: mono, size: 18pt, fill: soft)
    [pilae.com]
  })
]

// 2. Three cells, as the site's feature grid ---------------------------------
#let cell(n, title, copy) = block(width: 100%, {
  set block(spacing: 0pt)
  set par(spacing: 0pt)
  line(length: 100%, stroke: 1.5pt + hair)
  block(height: 22pt)
  text(font: mono, size: 15pt, fill: faint, n)
  block(height: 30pt)
  block(text(font: display, size: 32pt, weight: 500, tracking: -0.02em, title))
  block(height: 30pt)
  block({
    set text(size: 19pt, fill: soft)
    set par(leading: 0.62em)
    copy
  })
})

#let cells = block(width: 1280pt, height: 270pt, inset: (x: 88pt, top: 40pt, bottom: 32pt), fill: navy)[
  #grid(columns: (1fr, 1fr, 1fr), column-gutter: 48pt,
    cell("01", [Your infrastructure],
      [Apps run on servers you control, #box[on-prem] or in your own cloud account.]),
    cell("02", [Agents, with approval],
      [Agents plan each deploy and patch. A~person approves it before it runs.]),
    cell("03", [Integrated, then run],
      [Connected to your SSO, data and workflows, then operated day to day.]),
  )
]

// 3. Footer band -------------------------------------------------------------
#let foot = block(width: 1280pt, height: 150pt, clip: true, fill: navy)[
  #terrain("terrain-solutions.svg", 1280pt, 150pt, 2400pt, 760pt, 0.9)
  #place(top + left, rect(width: 100%, height: 100%, stroke: none, fill: gradient.linear(
    (navy, 0%), (navy.transparentize(10%), 30%), (navy.transparentize(100%), 70%), (navy.transparentize(100%), 100%),
  )))
  #place(horizon + left, dx: 88pt, image("pilae-mark-white.svg", height: 44pt))
  #place(horizon + left, dx: 160pt, {
    set text(font: mono, size: 17pt, fill: soft)
    [contact\@pilae.com]
  })
]

#page(width: 1280pt, height: auto, margin: 0pt, fill: navy, {
  set block(spacing: 0pt)
  hero
  cells
  foot
})
