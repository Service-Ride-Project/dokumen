#set page(
  paper: "a4",
  margin: (
    top: 2.5cm,
    bottom: 5.5cm,
    left: 2.5cm,
    right: 2.5cm,
  ),
  footer: context {
    let nomor = counter(page).get().first()

    let halaman = counter(page).get().first() - 1
    let total = counter(page).final().first() - 1

    if nomor > 1 {
      set text(size: 9pt)

      table(
        columns: (40%, 35%, 25%),
        rows: (6mm, 15mm),
        stroke: 0.5pt,
        inset: 5pt,
        align: center,

        [#align(center + horizon)[*Prodi S1 Informatika - Universitas Telkom*]],
        [#align(center + horizon)[*SKPL - IMPAL-01-02*]],
        [#align(center + horizon)[*Halaman #str(halaman) dari #str(total)*]],
        table.cell(colspan: 3, align: horizon + center)[
          Dokumen ini dan informasi yang ada di dalamnya adalah milik Prodi S1 Informatika-Universitas Telkom dan bersifat rahasia. Dilarang untuk mereproduksi dokumen ini tanpa diketahui oleh Program Studi S1 Informatika, Universitas Telkom
        ],
      )
    } else {
      set text(size: 9pt)

      table(
        columns: (15%, 30%, 34%, 21%),
        rows: (12mm, 9mm, 8mm),
        stroke: 0.5pt,
        inset: 3pt,
        align: center,

        // Kolom logo digabung 3 baris
        table.cell(rowspan: 3, align: horizon + center)[
          #image("logo/Tel-U.Vertical.png", width: 18mm)
        ],

        // Kolom prodi digabung 3 baris
        table.cell(rowspan: 3, align: horizon + center)[
          #text(size: 12pt, weight: "bold")[
            Prodi S1 Informatika
            Universitas Telkom
          ]
        ],

        [#align(center + horizon)[#text(size: 10.5pt)[*Nomor Dokumen*]]],
        [#align(center + horizon)[#text(size: 10.5pt)[*Halaman*]]],

        [#align(center + horizon)[#text(size: 10.5pt)[*SKPL - IMPAL-01-02*]]],
        [#align(center + horizon)[#text(size: 10.5pt)[Total #str(total)]]],

        [#align(center + horizon)[#text(size: 10.5pt)[*Revisi:* 01]]],
        [#align(center + horizon)[#text(size: 10.5pt)[*Tgl:* 25/10/2026]]],
      )
    }
  },
)

#set heading(
  numbering: (..nums) => {
    let n = nums.pos()

    if n.len() == 1 {
      numbering("I", n.first())
    } else {
      numbering("1.1.1", ..n)
    }
  },
)

#show heading.where(level: 1): it => {
  block(width: 100%, above: 1em, below: 1em)[
    #align(center)[
      #text(size: 16pt, weight: "bold")[
        #if it.numbering == none {
          it.body
        } else {
          [BAB #context counter(heading).display("I") \ ]
          it.body
        }
      ]
    ]
  ]

  if it.numbering != none {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
  }
}

#show heading.where(level: 2): it => block(
  above: 1em,
  below: 0.5em,
)[
  #text(size: 14pt, weight: "bold")[
    #context counter(heading).display("1.1") #it.body
  ]
]

#show heading.where(level: 3): it => block(
  above: 1em,
  below: 0.5em,
)[
  #text(size: 12pt, weight: "bold")[
    #context counter(heading).display("1.1.1") #it.body
  ]
]

#show outline.entry: it => {
  let el = it.element

  let prefix = if el.func() == figure {
    context {
      let loc = el.location()

      numbering(
        "1.1",
        counter(heading).at(loc).first(),
        counter(figure.where(kind: el.kind)).at(loc).first(),
      )
    }
  } else if it.level == 1 and el.numbering != none {
    [BAB #it.prefix()]
  } else {
    it.prefix()
  }

  link(
    el.location(),
    it.indented(prefix, it.inner()),
  )
}

#set figure(
  numbering: n => numbering(
    "1.1",
    counter(heading).get().first(),
    n,
  ),
)

#show figure.where(kind: image): set figure(
  supplement: [Gambar],
)

#show figure.where(kind: table): set figure(
  supplement: [Tabel],
)

#show figure.where(kind: table): set figure.caption(
  position: bottom,
)

#set figure.caption(separator: [. ])
#show figure.caption: set text(size: 10pt)

#set text(font: "Times New Roman", size: 12pt)

// COVER
#align(center)[

  #table(
    columns: 100%,
    rows: 5mm,
    stroke: 0.5pt,
    [#align(center + horizon)[#text(size: 10.5pt)[*SKPL - IMPAL-01-02 *]]],
  )

  #text(size: 14pt, weight: "bold")[
    SPESIFIKASI KEBUTUHAN PERANGKAT LUNAK (SKPL)
  ]

  #text(size: 16pt, weight: "bold")[
    SERVICE RIDE
  ]

  #text(size: 14pt, weight: "bold")[
    Integrated Automotive Service & Maintenance Platform
  ]

  #v(1cm)

  #image("/logo/ServiceRideVertical.png", width: 6cm)

  #v(1cm)

  #table(
    columns: (auto, auto),
    align: center + horizon,
    inset: 8pt,
    stroke: none,

    [Rovino Ramadhani], [103072400031],
    [Nama Anggota 2], [NIM Anggota 2],
    [Nama Anggota 3], [NIM Anggota 3],
    [Nama Anggota 3], [NIM Anggota 3],
    [Nama Anggota 3], [NIM Anggota 3],
  )

  #v(1.5cm)

  #text(size: 14pt, weight: "bold")[PROGRAM STUDI INFORMATIKA]

  #text(size: 14pt, weight: "bold")[FAKULTAS DIREKTORAT KAMPUS SURABAYA]

  #text(size: 14pt, weight: "bold")[TELKOM UNIVERSITY]

  #text(size: 14pt, weight: "bold")[2026]
]

#pagebreak()

#heading(level: 1, numbering: none)[DAFTAR PERUBAHAN]

#table(
  columns: (24%, 76%),
  rows: (9mm, 18mm, 18mm, 18mm, 18mm, 18mm, 18mm, 18mm),
  stroke: 0.6pt,
  inset: 4pt,
  align: center + top,

  table.cell(align: center + horizon)[*Revisi*],
  table.cell(align: center + horizon)[*Deskripsi*],

  [#text(size: 16pt, weight: "bold")[A]], [],
  [#text(size: 16pt, weight: "bold")[B]], [],
  [#text(size: 16pt, weight: "bold")[C]], [],
  [#text(size: 16pt, weight: "bold")[D]], [],
  [#text(size: 16pt, weight: "bold")[E]], [],
  [#text(size: 16pt, weight: "bold")[F]], [],
  [#text(size: 16pt, weight: "bold")[G]], [],
),

caption: [Daftar Anggota Kelompok],

#table(
  columns: (20%, 16%, 16%, 16%, 16%, 16%),
  rows: (10mm, 10mm, 10mm, 10mm),
  stroke: 0.6pt,
  inset: 3pt,
  align: center + horizon,

  [INDEX / TGL], [A], [B], [C], [D], [E],

  [Ditulis oleh], [], [], [], [], [],

  [Diperiksa oleh], [], [], [], [], [],

  [Disetujui oleh], [], [], [], [], [],
)


#pagebreak()

#heading(level: 1, numbering: none)[DAFTAR ISI]
#outline(title: none, depth: 3)

#pagebreak()

#heading(level: 1, numbering: none)[DAFTAR GAMBAR]
#outline(
  title: none,
  target: figure.where(kind: image),
)

#pagebreak()

#heading(level: 1, numbering: none)[DAFTAR TABEL]
#outline(
  title: none,
  target: figure.where(kind: table),
)

#pagebreak()

#counter(heading).update(0)

// BAB I
= PENDAHULUAN

== Tujuan Penulisan Dokumen
== Lingkup Masalah
== Definisi dan Istilah
== Tujuan Penulisan Dokumen
== Referensi


#pagebreak()

= DESKRIPSI UMUM PERANGKAT LUNAK
== Deskripsi Umum Sistem
== Fungsi Produk
== Karakteristik Pengguna

Karakteristik pengguna dijabarkan dalam tabel berikut ini.
#figure(
  table(
    columns: (25%, 25%, 25%, 25%),

    [Kategori Pengguna], [Tugas], [Hak Akses ke aplikasi], [Kemampuan yang harus dimiliki],
    [-], [-], [-], [-],
  ),
  caption: [Karakteristik Pengguna],
)
== Batasan
=== Lingkungan Operasi


#pagebreak()

= DESKRIPSI UMUM KEBUTUHAN
== Kebutuhan antarmuka eksternal

=== Antarmuka pengguna
=== Antarmuka perangkat keras
=== Antarmuka perangkat lunak
=== Antarmuka komunikasi


#pagebreak()

== Deskripsi Fungsional
=== Use Case Diagram
=== Fungsi : nama use case
==== Skenario: Login
Nomor :

Nama Use Case	: Login

Actor		:
- Admin
- Karyawan Gudang
- Kasir

Type		: Primary

Tujuan		: Melakukan proses login

Deskripsi	: Dengan melakukan proses ini admin, karyawan gudang dan kasir dapat masuk dan 			mengakses pilihan menu dalam aplikasi

#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [-], [-],
    [-], [-],
  ),
  caption: [Skenario Login],
)

==== Diagram Aktivitas: nama use case
==== Diagram Sekuens: nama use case
==== Diagram Kolaborasi Objek: nama use case


#pagebreak()
== Deskripsi Kelas-kelas
