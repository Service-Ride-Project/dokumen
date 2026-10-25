#import "@preview/merman:0.5.0": mermaid
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
  below: 1em,
)[
  #text(size: 14pt, weight: "bold")[
    #context counter(heading).display("1.1") #it.body
  ]
]

#show heading.where(level: 3): it => block(
  above: 1em,
  below: 1em,
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

#let paragraf(isi) = block(width: 100%)[
  #set par(
    justify: true,
    leading: 0.5em,
  )
  #isi
]

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

  #v(0.5cm)

  #image("/logo/ServiceRideVertical.png", width: 6cm)

  #v(0.5cm)

  #text(size: 12pt, weight: "bold")[Disusun Oleh:]
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
#show figure.where(kind: table): set block(breakable: true)
= PENDAHULUAN

== Tujuan Penulisan Dokumen
#paragraf[
  Dokumen Spesifikasi Kebutuhan Perangkat Lunak ini menetapkan kebutuhan Service Ride sebagai acuan bersama bagi pemilik produk, perancang, pengembang, dan penguji. Dokumen menjelaskan ruang lingkup, aktor, fungsi, antarmuka, batasan, model, dan kebutuhan kualitas berdasarkan baseline analisis kebutuhan versi 1.0.
]

== Lingkup Masalah
#paragraf[
  Service Ride menghubungkan Customer dengan bengkel mitra untuk pencarian bengkel, pemesanan servis, pemeriksaan kendaraan, penyusunan dan persetujuan estimasi, pembayaran, pickup dan pengantaran, pemantauan pekerjaan, pembelian spare part, ulasan, dan penanganan keluhan. Cakupan servis meliputi booking online dengan pickup, booking online dengan kedatangan langsung, dan layanan full offline yang dicatat oleh Operations Administrator. Marketplace hanya menerima pesanan online yang dikirim melalui ekspedisi pihak ketiga. Persediaan setiap bengkel terpisah, sedangkan servis, penjualan offline, dan marketplace menggunakan stok fisik bengkel yang sama. Invoice final tetap menjadi dokumen terpisah dari estimasi.
]

== Definisi dan Istilah
#paragraf[
  Service Ride adalah platform layanan dan operasional bengkel mitra. Customer adalah pemilik kendaraan atau pembeli spare part. Workshop Owner adalah pemilik satu atau lebih bengkel. Workshop Warehouse Administrator mengelola katalog dan stok. Workshop Operations Administrator mengelola booking, antrean, estimasi, pembayaran tunai, status servis, dan komunikasi operasional. Mechanic melakukan pemeriksaan dan pekerjaan servis. Pickup Service menjalankan penjemputan dan pengantaran. Booking adalah catatan pemesanan layanan servis. Estimate adalah dokumen biaya, komponen, waktu, dan bukti pemeriksaan sebelum persetujuan Customer. ACC berarti persetujuan Customer terhadap estimasi. Stok pending adalah unit spare part yang telah dialokasikan dan tidak boleh ditawarkan sebagai stok tersedia. Pickup PP adalah perjalanan pulang-pergi. Dummy Payment adalah pembayaran sementara dengan QRIS milik Service Ride. Invoice final adalah dokumen tagihan setelah transaksi servis selesai.
]

== Tujuan Penulisan Dokumen
#paragraf[
  Dokumen ini menjadi baseline untuk menilai kelengkapan kebutuhan dan keterlacakan antara proses bisnis, Use Case, Activity Diagram, model kelas, perilaku status booking, dan kebutuhan nonfungsional. Detail struktur data, API, algoritma, serta desain antarmuka dirinci pada dokumen DPPL dan tidak ditetapkan ulang di sini.
]

== Referensi
#paragraf[
  1. International Organization for Standardization. (2018). *ISO/IEC/IEEE 29148:2018: Systems and software engineering - Life cycle processes - Requirements engineering.* #link("https://www.iso.org/standard/72089.html")[https://www.iso.org/standard/72089.html]
  2. Object Management Group. (2017). *OMG unified modeling language (OMG UML), version 2.5.1.* #link("https://www.omg.org/spec/UML/2.5.1")[https://www.omg.org/spec/UML/2.5.1]
]

#pagebreak()

= DESKRIPSI UMUM PERANGKAT LUNAK
== Deskripsi Umum Sistem
#paragraf[
  Service Ride adalah aplikasi web untuk layanan pelanggan dan operasional bengkel mitra. Customer menggunakan aplikasi untuk mengelola kendaraan, memilih bengkel, memesan servis, menyetujui estimasi, membayar, membeli spare part, memantau status, memberi review, dan menyampaikan keluhan. Bengkel menggunakan akses sesuai role untuk mengelola legalitas, karyawan, stok, booking, pemeriksaan, pengerjaan, pickup, pembayaran, dan dokumen transaksi. Satu Owner dapat mengelola beberapa bengkel, tetapi data operasional dan persediaan dibatasi per bengkel.
]

== Fungsi Produk
#paragraf[
  Fungsi Service Ride mencakup registrasi dan autentikasi semua role,  verifikasi bengkel,  pengelolaan kendaraan dan booking online maupun offline,  pemeriksaan dan estimasi dengan foto serta pemeriksaan ketersediaan stok bengkel,  persetujuan atau penolakan estimasi,  alokasi stok pending setelah persetujuan dan pembayaran,  penugasan mekanik dan Pickup Service,  pelacakan dan serah terima,  marketplace spare part,  pembayaran online dan pencatatan tunai oleh Operations Administrator,  penerbitan invoice final,  review,  keluhan,  notifikasi,  laporan,  dan audit.
]

== Karakteristik Pengguna
#paragraf[
  Pengguna Service Ride memiliki akses sesuai role. Ringkasan berikut menampilkan tanggung jawab, cakupan akses, dan kemampuan yang diperlukan untuk menggunakan fungsi utama sistem.
]
#figure(
  table(
    columns: (25%, 25%, 25%, 25%),

    table.header([Kategori Pengguna], [Tugas], [Hak Akses ke aplikasi], [Kemampuan yang harus dimiliki]),
    [Customer],
    [Mencari bengkel, mengelola kendaraan, memesan servis dan spare part, menyetujui estimasi, membayar, memantau status, memberi ulasan, dan menyampaikan keluhan.],
    [Mengakses data akun, kendaraan, booking, pembayaran, marketplace, ulasan, dan keluhan miliknya.],
    [Mampu memakai browser dan memahami informasi kendaraan, jadwal, serta transaksi.],

    [Super Admin],
    [Memverifikasi legalitas bengkel, mengelola data platform, memoderasi konten yang melanggar, dan menengahi sengketa.],
    [Mengakses data tingkat platform dan kasus yang ditugaskan untuk pemeriksaan.],
    [Mampu meninjau dokumen, bukti, dan jejak audit secara cermat.],

    [Workshop Owner],
    [Mendaftarkan bengkel, mengelola cabang dan karyawan, mengatur marketplace per cabang, melihat laporan, dan menanggapi ulasan.],
    [Mengakses bengkel yang dimiliki dan karyawan yang ditugaskan pada bengkel tersebut.],
    [Mampu menggunakan aplikasi web dan memahami operasi serta laporan bengkel.],

    [Workshop Warehouse Administrator],
    [Mengelola katalog spare part, stok fisik, pemenuhan pesanan, dan retur marketplace.],
    [Mengakses katalog, stok, dan pesanan pada bengkel atau cabang yang ditugaskan.],
    [Mampu mengelola data produk, unit stok, dan bukti pengiriman.],

    [Workshop Operations Administrator],
    [Mengelola booking, antrean, estimasi, persetujuan, jadwal, komunikasi, dan pencatatan pembayaran tunai.],
    [Mengakses proses operasional pada bengkel atau cabang yang ditugaskan.],
    [Mampu mencatat transaksi, status servis, bukti persetujuan, dan komunikasi pelanggan.],

    [Mechanic],
    [Memeriksa kendaraan, mencatat diagnosis dan kebutuhan komponen, mengunggah bukti, serta memperbarui pekerjaan servis.],
    [Mengakses booking dan bukti servis yang ditugaskan.],
    [Mampu melakukan pemeriksaan teknis dan mendokumentasikan pekerjaan.],

    [Pickup Service],
    [Menjalankan pickup dan pengantaran serta memperbarui status dan lokasi perjalanan.],
    [Mengakses tugas pickup yang ditugaskan dan data serah terima terkait.],
    [Mampu menggunakan perangkat lokasi dan memperbarui status perjalanan.],
  ),
  caption: [Karakteristik Pengguna],
)

== Batasan
#paragraf[
  Mitra harus menjalani pemeriksaan legalitas dan persetujuan Super Admin sebelum aktif. Owner dapat memiliki beberapa bengkel, tetapi persediaan tiap bengkel tidak otomatis dipenuhi dari bengkel lain. Marketplace hanya melayani pembelian online dan pengiriman melalui ekspedisi pihak ketiga,  pengambilan barang marketplace di bengkel tidak termasuk cakupan. Pembayaran aplikasi pada baseline menggunakan Dummy Payment QRIS Service Ride,  Midtrans belum diaktifkan. Pembayaran tunai dicatat melalui antarmuka mitra oleh Operations Administrator. Tarif pickup, kompensasi keterlambatan, durasi suspend, retensi data, dan beberapa bukti operasional belum ditetapkan secara numerik dalam baseline.
]

=== Lingkungan Operasi
#paragraf[
  Aplikasi dirancang sebagai layanan web yang diakses melalui browser pada perangkat Customer dan karyawan bengkel. Frontend Service Ride menggunakan React, Vite, TypeScript, Tailwind CSS, dan shadcn/ui, serta backend Golang dengan PostgreSQL, pgvector, Redis, dan sqlc. Data lokasi menggunakan PostGIS. Pembaruan lokasi ke antarmuka menggunakan Server-Sent Events (SSE). Persyaratan sistem operasi, penyedia hosting, kapasitas, dan target ketersediaan numerik belum ditetapkan oleh baseline.
]

#pagebreak()

= DESKRIPSI UMUM KEBUTUHAN
== Kebutuhan antarmuka eksternal

=== Antarmuka pengguna
#paragraf[
  Antarmuka menyediakan fungsi sesuai role Customer, Super Admin, Workshop Owner, Workshop Warehouse Administrator, Workshop Operations Administrator, Mechanic, dan Pickup Service. Customer mengakses pencarian bengkel, kendaraan, booking, estimasi, pembayaran, marketplace, status, review, dan keluhan. Antarmuka mitra menyediakan fungsi operasional sesuai kewenangan bengkel dan cabang. Tampilan status pickup hanya menampilkan informasi kepada Customer terkait dan role yang berwenang.
]

=== Antarmuka perangkat keras
#paragraf[
  Penggunaan tidak memerlukan perangkat keras khusus yang ditetapkan dalam baseline. Perangkat pengguna memerlukan browser dan koneksi jaringan. Mechanic memerlukan kemampuan mengambil atau memilih foto untuk bukti pemeriksaan dan pekerjaan. Pickup Service menggunakan perangkat yang dapat menyediakan lokasi saat perjalanan aktif, dengan izin lokasi sesuai kebutuhan operasional.
]

=== Antarmuka perangkat lunak
#paragraf[
  Frontend proyek menggunakan React, Vite, TypeScript, Tailwind CSS, dan shadcn/ui. Backend menggunakan Golang,  penyimpanan utama menggunakan PostgreSQL dan PostGIS, dengan pgvector, Redis, serta sqlc tercatat pada informasi proyek. Pembaruan lokasi disalurkan melalui SSE. Integrasi Midtrans belum aktif dan pembayaran sementara menggunakan Dummy Payment QRIS Service Ride. Data kurir dan nomor resi marketplace dimasukkan secara manual. Email digunakan apabila alamat tersedia.
]

=== Antarmuka komunikasi
#paragraf[
  Aplikasi menyediakan pertukaran data antara browser dan backend serta pembaruan status melalui notifikasi aplikasi. Lokasi Pickup Service diperbarui berkala saat perjalanan aktif dan disajikan melalui SSE. Email dikirim apabila tersedia. Untuk layanan offline, persetujuan estimasi dapat dicatat dari aplikasi, WhatsApp, atau telepon,  bukti WhatsApp disimpan dan nomor pengirim dicocokkan dengan kontak yang tercatat.
]

#pagebreak()

== Deskripsi Fungsional
=== Use Case Diagram
#paragraf[
  The Use Case diagram presents all actors, system functions, and their relationships in one complete view. All seven roles must log in before using protected functions. An authenticated Operations Administrator may record a full offline service for a draft Customer account.
]
#figure(
  image(
    "skpl/hasil/Use Case Diagram.png",
    width: 100%,
    height: 17.5cm,
    fit: "contain",
  ),
  caption: [Service Ride Use Case Diagram],
) <fig:usecase>

=== Skenario Use Case
#paragraf[
  Bagian ini memuat skenario fungsi Service Ride, mulai dari autentikasi, pendaftaran akun dan bengkel, pengelolaan cabang serta stok, booking servis dan marketplace, pemeriksaan dan persetujuan estimasi, pembayaran, pickup, hingga ulasan dan keluhan.
]

==== Skenario: Login
#paragraf[Nomor: SKPL-FR-01]
#paragraf[Nama Use Case: Login]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Super Admin],
  [Customer],
  [Workshop Owner],
  [Workshop Warehouse Administrator],
  [Workshop Operations Administrator],
  [Mechanic],
  [Pickup Service],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Mengautentikasi akun dan membuka akses sesuai role yang terdaftar.]
#paragraf[Deskripsi: Setiap role memasukkan kredensial. Sistem memeriksa kecocokan akun, role, dan status. Sesi hanya dibuka untuk akun yang valid dan aktif.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Super Admin memasukkan kredensial akun dan mengirim permintaan login.],
    [Memvalidasi kredensial, role, dan status akun. Membuka sesi sesuai hak akses hanya jika akun valid dan aktif. Jika tidak, menampilkan kesalahan tanpa membuka sesi.],

    [Customer memasukkan kredensial akun dan mengirim permintaan login.],
    [Memvalidasi kredensial, role, dan status akun. Membuka sesi sesuai hak akses hanya jika akun valid dan aktif. Jika tidak, menampilkan kesalahan tanpa membuka sesi.],

    [Workshop Owner memasukkan kredensial akun dan mengirim permintaan login.],
    [Memvalidasi kredensial, role, dan status akun. Membuka sesi sesuai hak akses hanya jika akun valid dan aktif. Jika tidak, menampilkan kesalahan tanpa membuka sesi.],

    [Workshop Warehouse Administrator memasukkan kredensial akun dan mengirim permintaan login.],
    [Memvalidasi kredensial, role, dan status akun. Membuka sesi sesuai hak akses hanya jika akun valid dan aktif. Jika tidak, menampilkan kesalahan tanpa membuka sesi.],

    [Workshop Operations Administrator memasukkan kredensial akun dan mengirim permintaan login.],
    [Memvalidasi kredensial, role, dan status akun. Membuka sesi sesuai hak akses hanya jika akun valid dan aktif. Jika tidak, menampilkan kesalahan tanpa membuka sesi.],

    [Mechanic memasukkan kredensial akun dan mengirim permintaan login.],
    [Memvalidasi kredensial, role, dan status akun. Membuka sesi sesuai hak akses hanya jika akun valid dan aktif. Jika tidak, menampilkan kesalahan tanpa membuka sesi.],

    [Pickup Service memasukkan kredensial akun dan mengirim permintaan login.],
    [Memvalidasi kredensial, role, dan status akun. Membuka sesi sesuai hak akses hanya jika akun valid dan aktif. Jika tidak, menampilkan kesalahan tanpa membuka sesi.],
  ),
  caption: [Skenario Login],
)

==== Skenario: Customer Account Registration
#paragraf[Nomor: SKPL-FR-01]
#paragraf[Nama Use Case: Customer Account Registration]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Membuat akun Customer sebelum menggunakan layanan yang memerlukan autentikasi.]
#paragraf[Deskripsi: Customer mengisi data registrasi dan email. Sistem memeriksa kelengkapan serta keunikan email, lalu membuat akun belum terverifikasi dan memulai proses verifikasi.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer mengisi data registrasi dan email.], [Memeriksa kelengkapan data dan keunikan email.],
    [Customer memperbaiki data jika sistem menemukan kesalahan.],
    [Menampilkan kesalahan validasi. Jika data valid, membuat akun belum terverifikasi dan mengirim kode verifikasi.],
  ),
  caption: [Skenario Customer Account Registration],
)

==== Skenario: Account Verification
#paragraf[Nomor: SKPL-FR-01]
#paragraf[Nama Use Case: Account Verification]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Memverifikasi kepemilikan email agar akun dapat digunakan.]
#paragraf[Deskripsi: Customer memasukkan kode verifikasi yang diterima. Sistem memeriksa kecocokan dan masa berlaku kode, lalu mengaktifkan status verifikasi jika valid.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer meminta atau memasukkan kode verifikasi.], [Mengirim kode dan memeriksa kecocokan serta masa berlakunya.],
    [Customer memasukkan kode baru setelah kode ditolak atau kedaluwarsa.],
    [Menampilkan hasil verifikasi. Mengaktifkan akun hanya jika kode valid.],
  ),
  caption: [Skenario Account Verification],
)

==== Skenario: Workshop Registration
#paragraf[Nomor: SKPL-FR-04]
#paragraf[Nama Use Case: Workshop Registration]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Owner],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Mengajukan bengkel beserta dokumen legalitas untuk ditinjau.]
#paragraf[Deskripsi: Workshop Owner mengisi profil bengkel dan dokumen legalitas. Sistem memeriksa kelengkapan, menyimpan pengajuan berstatus menunggu, dan meneruskan pengajuan kepada Super Admin.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Owner mengisi profil bengkel dan mengunggah dokumen legalitas.],
    [Memeriksa kelengkapan informasi dan dokumen.],

    [Workshop Owner memperbaiki pengajuan yang belum lengkap.],
    [Menampilkan data yang perlu diperbaiki. Jika lengkap, menyimpan pengajuan dan memberi tahu Super Admin.],
  ),
  caption: [Skenario Workshop Registration],
)

==== Skenario: Workshop Verification
#paragraf[Nomor: SKPL-FR-05]
#paragraf[Nama Use Case: Workshop Verification]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Super Admin],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Meninjau legalitas dan menetapkan keputusan aktivasi bengkel.]
#paragraf[Deskripsi: Super Admin memeriksa data dan dokumen bengkel yang menunggu. Sistem menyimpan keputusan, alasan penolakan bila ada, status aktivasi, dan pemberitahuan kepada Workshop Owner.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Super Admin meninjau profil bengkel dan dokumen legalitas, termasuk pemeriksaan QR jika tersedia.],
    [Memuat pengajuan yang menunggu untuk ditinjau.],

    [Super Admin menyetujui atau menolak pengajuan dan mencatat alasan bila ditolak.],
    [Mengaktifkan atau menolak bengkel, menyimpan keputusan, dan memberi tahu Workshop Owner.],
  ),
  caption: [Skenario Workshop Verification],
)

==== Skenario: Employee and Branch Access Management
#paragraf[Nomor: SKPL-FR-02, SKPL-FR-06, SKPL-FR-07]
#paragraf[Nama Use Case: Employee and Branch Access Management]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Owner],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Mengelola karyawan dan membatasi akses berdasarkan bengkel serta cabang yang ditugaskan.]
#paragraf[Deskripsi: Workshop Owner memilih bengkel atau cabang yang dikelola, kemudian menambah, memperbarui, atau menonaktifkan akses karyawan. Setiap karyawan ditempatkan pada satu cabang operasional.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Owner memilih bengkel atau cabang dan memilih tindakan karyawan.],
    [Memastikan bengkel berada dalam cakupan Owner.],

    [Workshop Owner memasukkan perubahan data dan role karyawan atau memilih akses untuk dinonaktifkan.],
    [Memvalidasi role serta penugasan satu cabang. Menyimpan perubahan atau menonaktifkan akses dan menampilkan daftar terbaru.],
  ),
  caption: [Skenario Employee and Branch Access Management],
)

==== Skenario: Spare Part Catalog Management
#paragraf[Nomor: SKPL-FR-26]
#paragraf[Nama Use Case: Spare Part Catalog Management]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Warehouse Administrator],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Mengelola daftar spare part milik bengkel yang ditugaskan.]
#paragraf[Deskripsi: Workshop Warehouse Administrator membuat, memperbarui, atau menonaktifkan daftar produk. Sistem memvalidasi data produk lalu memperbarui katalog bengkel.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Warehouse Administrator memilih tindakan dan memasukkan atau memperbarui data produk.],
    [Memvalidasi data produk.],

    [Workshop Warehouse Administrator memperbaiki data yang tidak valid atau menonaktifkan daftar produk.],
    [Menyimpan perubahan yang valid atau menonaktifkan daftar, lalu menampilkan katalog terbaru.],
  ),
  caption: [Skenario Spare Part Catalog Management],
)

==== Skenario: Workshop Inventory Management
#paragraf[Nomor: SKPL-FR-26, SKPL-FR-27, SKPL-FR-28]
#paragraf[Nama Use Case: Workshop Inventory Management]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Warehouse Administrator],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Menjaga catatan unit stok dan ketersediaannya pada bengkel yang dipilih.]
#paragraf[Deskripsi: Sistem membatasi perubahan pada stok bengkel yang dipilih. Workshop Warehouse Administrator dapat mencatat penerimaan atau koreksi stok, memeriksa unit pending, serta melepas alokasi yang transaksinya dibatalkan.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Warehouse Administrator memilih bengkel dan unit spare part, lalu memilih penerimaan, koreksi, pemeriksaan pending, atau pelepasan alokasi.],
    [Memuat stok bengkel yang dipilih dan tidak menawarkan unit pending sebagai stok tersedia.],

    [Workshop Warehouse Administrator memasukkan detail penerimaan atau koreksi.],
    [Memvalidasi identitas unit dan perubahan stok, memperbarui ketersediaan, serta mencatat pergerakan stok dan audit.],
  ),
  caption: [Skenario Workshop Inventory Management],
)

==== Skenario: Offline Spare Part Sale
#paragraf[Nomor: SKPL-FR-28, SKPL-FR-36]
#paragraf[Nama Use Case: Offline Spare Part Sale]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Warehouse Administrator],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Mencatat penjualan spare part secara tunai pada bengkel yang sama dengan stok fisik.]
#paragraf[Deskripsi: Workshop Warehouse Administrator memilih spare part dan jumlah unit. Sistem mengecualikan unit yang telah pending, memeriksa kecukupan stok, lalu mencatat penerimaan tunai dan unit yang terjual.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Warehouse Administrator memilih spare part dan jumlah untuk penjualan offline.],
    [Memuat unit dari bengkel yang sama dan memeriksa stok tersedia tanpa unit pending.],

    [Workshop Warehouse Administrator mengubah pilihan jika stok tidak cukup atau mencatat uang tunai yang diterima.],
    [Menampilkan kekurangan stok atau menandai unit terjual, mencatat pergerakan stok, dan menyimpan transaksi tunai.],
  ),
  caption: [Skenario Offline Spare Part Sale],
)

==== Skenario: Marketplace Spare Part Order
#paragraf[Nomor: SKPL-FR-29, SKPL-FR-30, SKPL-FR-34, SKPL-FR-35]
#paragraf[Nama Use Case: Marketplace Spare Part Order]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Memesan spare part secara online melalui marketplace bengkel yang aktif.]
#paragraf[Deskripsi: Customer memilih produk, jumlah, dan alamat pengiriman. Sistem memeriksa marketplace bengkel serta stok tersedia, mengalokasikan unit sementara, memproses pembayaran Dummy QRIS, dan membuat pesanan hanya setelah pembayaran berhasil.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer melihat produk dan mengisi keranjang serta alamat pengiriman.],
    [Menampilkan produk dari marketplace aktif dan memeriksa stok fisik yang tersedia.],

    [Customer melanjutkan checkout dan membayar dengan Dummy QRIS.],
    [Memvalidasi pesanan, menandai unit sebagai pending selama checkout, lalu membuat pesanan berstatus dibayar jika pembayaran berhasil. Jika gagal, melepas alokasi dan menampilkan kegagalan.],
  ),
  caption: [Skenario Marketplace Spare Part Order],
)

==== Skenario: Marketplace Order Fulfillment
#paragraf[Nomor: SKPL-FR-31]
#paragraf[Nama Use Case: Marketplace Order Fulfillment]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Warehouse Administrator],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Memenuhi pesanan marketplace yang pembayarannya telah berhasil.]
#paragraf[Deskripsi: Workshop Warehouse Administrator memeriksa pesanan dan unit pending, menyiapkan paket, menyerahkannya kepada kurir pihak ketiga, lalu memasukkan nama ekspedisi dan nomor resi secara manual.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Warehouse Administrator memeriksa pesanan dibayar dan mengambil unit yang dipesan.],
    [Memuat rincian pesanan dan memeriksa konsistensi unit pending.],

    [Workshop Warehouse Administrator menyiapkan paket, menyerahkannya kepada kurir, dan memasukkan ekspedisi serta nomor resi.],
    [Memperbarui status pengiriman dan memberi tahu Customer. Jika pesanan tidak dapat dipenuhi, menandainya untuk tindak lanjut.],
  ),
  caption: [Skenario Marketplace Order Fulfillment],
)

==== Skenario: Marketplace Order Cancellation
#paragraf[Nomor: SKPL-FR-32]
#paragraf[Nama Use Case: Marketplace Order Cancellation]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Membatalkan pesanan marketplace sebelum paket diserahkan kepada kurir.]
#paragraf[Deskripsi: Sistem memeriksa status pesanan dan pengiriman. Pembatalan ditolak setelah paket diserahkan kepada kurir. Sebelum pengiriman, sistem membatalkan pesanan, melepas unit pending, dan memulai proses pengembalian dana jika pembayaran telah diterima.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer memilih pesanan marketplace dan mengajukan pembatalan.],
    [Memeriksa status pesanan, pengiriman, pembayaran, dan unit pending.],

    [Customer menerima hasil pembatalan.],
    [Menolak pembatalan jika paket sudah diserahkan kepada kurir. Jika belum, membatalkan pesanan, melepas unit pending, memulai pengembalian dana yang berlaku, dan memberi tahu Customer.],
  ),
  caption: [Skenario Marketplace Order Cancellation],
)

==== Skenario: Customer Vehicle Management
#paragraf[Nomor: SKPL-FR-08]
#paragraf[Nama Use Case: Customer Vehicle Management]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Menyimpan kendaraan yang digunakan saat memilih dan memesan layanan.]
#paragraf[Deskripsi: Customer dapat menambah, memperbarui, atau menghapus kendaraan. Sistem memvalidasi data dan menampilkan daftar kendaraan terbaru.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer memilih tambah, ubah, atau hapus kendaraan dan memasukkan perubahan data.],
    [Memvalidasi informasi kendaraan.],

    [Customer memperbaiki data yang tidak valid.],
    [Menyimpan data valid atau mengarsipkan kendaraan jika penghapusan diizinkan, lalu menampilkan daftar terbaru.],
  ),
  caption: [Skenario Customer Vehicle Management],
)

==== Skenario: Onsite Service Booking
#paragraf[Nomor: SKPL-FR-08, SKPL-FR-09]
#paragraf[Nama Use Case: Onsite Service Booking]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Memesan servis dengan membawa kendaraan langsung ke bengkel.]
#paragraf[Deskripsi: Customer memilih kendaraan, bengkel, layanan, serta jadwal. Sistem memeriksa ketersediaan layanan dan slot sebelum membuat permintaan booking onsite.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer memilih kendaraan tersimpan, bengkel, layanan, tanggal, dan waktu servis.],
    [Memeriksa cakupan layanan bengkel dan ketersediaan jadwal.],

    [Customer memilih slot lain jika jadwal tidak tersedia.],
    [Menampilkan slot yang tidak tersedia atau membuat permintaan booking dan meneruskannya kepada Workshop Operations Administrator.],
  ),
  caption: [Skenario Onsite Service Booking],
)

==== Skenario: Pickup Service Booking
#paragraf[Nomor: SKPL-FR-08, SKPL-FR-09, SKPL-FR-20, SKPL-FR-35]
#paragraf[Nama Use Case: Pickup Service Booking]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Memesan servis dengan layanan penjemputan dan pengantaran kendaraan.]
#paragraf[Deskripsi: Customer memilih kendaraan, alamat, dan jadwal penjemputan. Sistem memeriksa cakupan serta slot, menghitung biaya pickup pulang-pergi, dan membuat booking setelah biaya pickup dibayar sebelum keberangkatan driver.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer memilih kendaraan, memasukkan alamat, dan memilih jadwal pickup.],
    [Memeriksa cakupan bengkel dan ketersediaan slot.],

    [Customer memeriksa biaya pulang-pergi dan membayar biaya pickup melalui Dummy QRIS.],
    [Menghitung biaya, memproses pembayaran, lalu membuat booking dan catatan pembayaran jika berhasil. Jika gagal atau slot tidak tersedia, menampilkan masalah dan meminta koreksi.],
  ),
  caption: [Skenario Pickup Service Booking],
)

==== Skenario: Booking Confirmation
#paragraf[Nomor: SKPL-FR-09]
#paragraf[Nama Use Case: Booking Confirmation]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Operations Administrator],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Menerima atau menolak permintaan booking berdasarkan kapasitas bengkel.]
#paragraf[Deskripsi: Workshop Operations Administrator meninjau permintaan dan kapasitas. Sistem mengonfirmasi serta mencadangkan slot jika diterima, atau mencatat alasan penolakan dan memberi tahu Customer.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Operations Administrator membuka booking yang menunggu dan meninjau kapasitas.],
    [Memuat rincian booking dan jadwal bengkel.],

    [Workshop Operations Administrator menerima atau menolak permintaan dengan alasan.],
    [Mencadangkan slot jika diterima atau mencatat penolakan, memperbarui status, dan memberi tahu Customer.],
  ),
  caption: [Skenario Booking Confirmation],
)

==== Skenario: Booking Cancellation
#paragraf[Nomor: SKPL-FR-24, SKPL-FR-25]
#paragraf[Nama Use Case: Booking Cancellation]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
  [Workshop Operations Administrator],
  [Super Admin],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Mencatat pembatalan booking dan menerapkan konsekuensi sesuai pihak pembatal serta status keberangkatan driver.]
#paragraf[Deskripsi: Customer atau Workshop Operations Administrator dapat memulai pembatalan. Sistem memeriksa status keberangkatan, mengelola refund dan pembatasan pickup Customer, serta menghitung pembatalan bengkel setelah driver berangkat untuk ditinjau Super Admin.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer mengajukan pembatalan booking.],
    [Memeriksa booking, penugasan pickup, status keberangkatan, dan riwayat pembatalan. Jika driver belum berangkat, mengembalikan biaya pickup ke saldo Service Ride. Jika sudah berangkat, menerapkan pembatasan pickup satu minggu.],

    [Workshop Operations Administrator membatalkan booking atas nama bengkel.],
    [Mencatat pembatalan dan mengembalikan biaya pickup sesuai ketentuan. Jika driver telah berangkat, menghitung pembatalan bengkel dalam periode mingguan.],

    [Super Admin meninjau pembatalan bengkel setelah driver berangkat.],
    [Menerapkan suspend bengkel jika jumlah pembatalan yang memenuhi syarat melebihi 10 dalam satu minggu, lalu memberi tahu pihak terkait dan menyimpan audit.],
  ),
  caption: [Skenario Booking Cancellation],
)

==== Skenario: Order and Booking Status
#paragraf[Nomor: SKPL-FR-19, SKPL-FR-21, SKPL-FR-22, SKPL-FR-23, SKPL-FR-45]
#paragraf[Nama Use Case: Order and Booking Status]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Melihat status dan timeline pesanan, booking, dan perjalanan pickup miliknya.]
#paragraf[Deskripsi: Customer memilih pesanan atau booking. Sistem menampilkan status terbaru dan timeline, termasuk lokasi terakhir yang diketahui jika pembaruan driver terhenti, serta pemberitahuan untuk perubahan terkait.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer memilih pesanan atau booking yang ingin dilihat.],
    [Mengambil status dan timeline transaksi yang dipilih.],

    [Customer melihat perubahan status dan informasi pickup.],
    [Menampilkan lokasi terakhir yang diketahui jika update lokasi terhenti, serta mengirim notifikasi aplikasi dan email jika tersedia.],
  ),
  caption: [Skenario Order and Booking Status],
)

==== Skenario: Technician Assignment
#paragraf[Nomor: SKPL-FR-17]
#paragraf[Nama Use Case: Technician Assignment]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Operations Administrator],
  [Mechanic],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Menugaskan Mechanic yang memiliki keterampilan dan jadwal sesuai booking.]
#paragraf[Deskripsi: Workshop Operations Administrator memilih booking yang telah dikonfirmasi dan Mechanic. Sistem memeriksa keterampilan serta jadwal, lalu menyimpan penugasan dan memberi tahu Mechanic.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Operations Administrator memilih booking dan Mechanic.],
    [Memeriksa kecocokan keterampilan dan jadwal Mechanic.],

    [Workshop Operations Administrator memilih Mechanic lain jika terjadi konflik.],
    [Menampilkan konflik atau menyimpan penugasan dan memberi tahu Mechanic.],
  ),
  caption: [Skenario Technician Assignment],
)

==== Skenario: Vehicle Inspection and Cost Estimation
#paragraf[Nomor: SKPL-FR-11, SKPL-FR-12, SKPL-FR-13, SKPL-FR-18, SKPL-FR-38]
#paragraf[Nama Use Case: Vehicle Inspection and Cost Estimation]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Mechanic],
  [Workshop Operations Administrator],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Mencatat diagnosis serta menyusun estimasi biaya berdasarkan kebutuhan perbaikan dan stok bengkel.]
#paragraf[Deskripsi: Mechanic memeriksa kendaraan, mencatat komponen rusak, mengunggah foto, dan menentukan kebutuhan komponen serta tenaga kerja. Sistem memeriksa stok bengkel yang sama tanpa unit pending dan belum mencadangkan stok. Workshop Operations Administrator menyusun estimasi yang menyebutkan kekurangan stok dengan jelas.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Mechanic memeriksa kendaraan, mencatat diagnosis dan komponen rusak, mengunggah foto, serta menentukan komponen, tenaga kerja, dan waktu perbaikan.],
    [Memuat stok dari bengkel terkait saja, mengecualikan unit pending, dan memeriksa ketersediaan tanpa mencadangkan unit.],

    [Workshop Operations Administrator menyusun atau memperbaiki rincian estimasi berdasarkan diagnosis dan hasil pemeriksaan stok.],
    [Menghitung biaya komponen, tenaga kerja, serta waktu selesai. Menyimpan versi estimasi dan bukti foto, lalu mengirimkannya kepada Customer.],
  ),
  caption: [Skenario Vehicle Inspection and Cost Estimation],
)

==== Skenario: Estimated Cost Approval
#paragraf[Nomor: SKPL-FR-14, SKPL-FR-15, SKPL-FR-16]
#paragraf[Nama Use Case: Estimated Cost Approval]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
  [Workshop Operations Administrator],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Menerima keputusan Customer atas estimasi serta mengunci rincian yang disetujui.]
#paragraf[Deskripsi: Customer meninjau estimasi dan dapat menyetujui melalui aplikasi atau menyampaikan persetujuan melalui WhatsApp atau telepon. Workshop Operations Administrator mencatat bukti persetujuan luar aplikasi. Sistem memeriksa ulang stok sebelum mengalokasikannya sebagai pending dan mengizinkan pekerjaan hanya setelah pembayaran tercatat.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer memeriksa estimasi, ruang lingkup perbaikan, ketersediaan komponen, dan foto, lalu menyetujui atau menolak.],
    [Menampilkan versi estimasi terbaru. Mencatat penolakan tanpa mengizinkan pekerjaan.],

    [Workshop Operations Administrator mencatat persetujuan WhatsApp beserta tangkapan layar dan pemeriksaan nomor pengirim, atau mencatat hasil persetujuan melalui telepon.],
    [Menyimpan bukti, memeriksa ulang stok bengkel, dan meminta revisi estimasi jika unit tidak lagi tersedia. Jika disetujui dan stok tersedia, mengunci estimasi, menandai unit sebagai pending, serta meminta pembayaran.],

    [Customer membayar estimasi yang telah disetujui.],
    [Mengotorisasi pekerjaan hanya setelah pembayaran tercatat. Jika pembayaran gagal atau dibatalkan, melepas unit pending.],
  ),
  caption: [Skenario Estimated Cost Approval],
)

==== Skenario: Service Completion
#paragraf[Nomor: SKPL-FR-17, SKPL-FR-18, SKPL-FR-19]
#paragraf[Nama Use Case: Service Completion]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Mechanic],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Menyelesaikan pekerjaan servis dan mencatat hasil pemeriksaan akhir.]
#paragraf[Deskripsi: Mechanic mendokumentasikan hasil pekerjaan dan melakukan pemeriksaan akhir. Sistem mencatat penyelesaian serta memberi tahu pihak terkait setelah pemeriksaan berhasil.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Mechanic menyelesaikan pekerjaan dan mendokumentasikan hasilnya.],
    [Menyimpan bukti pekerjaan dan menampilkan pemeriksaan akhir.],

    [Mechanic memperbaiki masalah yang ditemukan pada pemeriksaan akhir.],
    [Mengulang pemeriksaan. Setelah lolos, mencatat servis selesai dan memberi tahu Workshop Operations Administrator serta Customer.],
  ),
  caption: [Skenario Service Completion],
)

==== Skenario: Vehicle Pickup
#paragraf[Nomor: SKPL-FR-20, SKPL-FR-21, SKPL-FR-22, SKPL-FR-23]
#paragraf[Nama Use Case: Vehicle Pickup]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Operations Administrator],
  [Pickup Service],
  [Customer],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Mengelola penjemputan kendaraan dan memperbarui status perjalanan menuju bengkel.]
#paragraf[Deskripsi: Setelah biaya pickup dibayar, Workshop Operations Administrator menugaskan Pickup Service. Driver mengirim pembaruan lokasi berkala. Sistem memberi peringatan jika pembaruan terhenti dan mencatat status penjemputan serta kedatangan kendaraan di bengkel.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Operations Administrator menugaskan Pickup Service setelah biaya pickup dibayar.],
    [Mengaktifkan tugas dan pelacakan lokasi.],

    [Pickup Service menerima tugas, menuju Customer, mengonfirmasi serah terima, dan mengirim lokasi setiap 3 sampai 4 menit.],
    [Menampilkan pembaruan yang berwenang. Jika tidak ada update selama 5 sampai 10 menit, memberi peringatan kepada Operations Administrator dan menampilkan lokasi terakhir.],

    [Pickup Service mengantarkan kendaraan ke bengkel atau melaporkan penjemputan yang gagal.],
    [Mencatat kendaraan tiba di bengkel atau meminta penjadwalan tindak lanjut.],
  ),
  caption: [Skenario Vehicle Pickup],
)

==== Skenario: Vehicle Return
#paragraf[Nomor: SKPL-FR-21, SKPL-FR-22, SKPL-FR-23]
#paragraf[Nama Use Case: Vehicle Return]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Operations Administrator],
  [Pickup Service],
  [Customer],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Mengembalikan kendaraan kepada Customer setelah servis selesai.]
#paragraf[Deskripsi: Sistem memastikan servis selesai sebelum pengembalian. Workshop Operations Administrator mengatur jadwal, Pickup Service mengirim pembaruan lokasi dan meminta serah terima, lalu sistem mencatat pengembalian atau tindak lanjut.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Operations Administrator mengatur pengembalian kendaraan setelah servis selesai.],
    [Memastikan kendaraan memenuhi syarat pengembalian dan menahan proses jika belum siap.],

    [Pickup Service mengambil kendaraan dari bengkel, mengantarkan kepada Customer, dan memperbarui lokasi.],
    [Mengirim peringatan jika update terhenti, lalu mencatat serah terima berhasil atau kegagalan yang perlu dijadwalkan ulang.],
  ),
  caption: [Skenario Vehicle Return],
)

==== Skenario: Payment
#paragraf[Nomor: SKPL-FR-34, SKPL-FR-35, SKPL-FR-36, SKPL-FR-37]
#paragraf[Nama Use Case: Payment]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
  [Workshop Operations Administrator],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Mencatat pembayaran pickup, servis, dan marketplace melalui kanal yang diizinkan.]
#paragraf[Deskripsi: Customer membayar transaksi online melalui Dummy QRIS. Untuk layanan offline, Workshop Operations Administrator mencatat uang tunai pada antarmuka mitra. Sistem menghubungkan pembayaran dengan transaksi dan mengelola proses refund sesuai ketentuan.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer memilih biaya pickup, estimasi servis yang disetujui, atau pesanan marketplace lalu mengirim pembayaran online.],
    [Menghitung jumlah yang harus dibayar dan memvalidasi hasil Dummy QRIS.],

    [Workshop Operations Administrator mencatat uang tunai yang diterima untuk servis offline.],
    [Menyimpan pembayaran tunai dan menghubungkannya dengan transaksi terkait. Menampilkan kegagalan pembayaran online dan menyediakan percobaan ulang jika diperlukan.],
  ),
  caption: [Skenario Payment],
)

==== Skenario: Payment Confirmation
#paragraf[Nomor: SKPL-FR-34, SKPL-FR-47]
#paragraf[Nama Use Case: Payment Confirmation]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Super Admin],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Meninjau dan mengonfirmasi hasil pembayaran yang memerlukan pemeriksaan manual.]
#paragraf[Deskripsi: Super Admin meninjau catatan, bukti, atau hasil Dummy QRIS saat tindak lanjut manual diperlukan. Sistem mengonfirmasi pembayaran yang valid dan menyimpan jejak audit, atau menandai transaksi untuk tindak lanjut.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Super Admin meninjau catatan pembayaran dan bukti saat pemeriksaan manual diperlukan.],
    [Memuat catatan pembayaran, bukti, dan hasil Dummy QRIS.],

    [Super Admin menyatakan bukti valid atau meminta tindak lanjut.],
    [Mengonfirmasi status pembayaran dan menyimpan audit jika valid. Jika tidak valid, menandai transaksi untuk pemeriksaan dan memberi tahu pihak terkait.],
  ),
  caption: [Skenario Payment Confirmation],
)

==== Skenario: Final Invoice Generation
#paragraf[Nomor: SKPL-FR-38]
#paragraf[Nama Use Case: Final Invoice Generation]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Operations Administrator],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Menerbitkan invoice final setelah servis selesai dan pembayaran tercatat.]
#paragraf[Deskripsi: Workshop Operations Administrator meminta invoice final. Sistem memeriksa status servis, estimasi yang disetujui, dan pembayaran. Invoice final disimpan sebagai dokumen terpisah dari estimasi dan disediakan kepada Customer.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Operations Administrator meminta invoice setelah servis selesai.],
    [Memeriksa penyelesaian servis, estimasi yang disetujui, dan catatan pembayaran.],

    [Workshop Operations Administrator memperbaiki catatan yang tidak lengkap jika diminta.],
    [Menampilkan kekurangan atau menghasilkan nomor invoice final, menyimpannya terpisah dari dokumen estimasi, dan menyediakan dokumen kepada Customer.],
  ),
  caption: [Skenario Final Invoice Generation],
)

==== Skenario: Full Offline Service Registration
#paragraf[Nomor: SKPL-FR-03, SKPL-FR-10, SKPL-FR-15, SKPL-FR-36]
#paragraf[Nama Use Case: Full Offline Service Registration]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Operations Administrator],
  [Customer],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Mencatat antrean dan layanan bengkel yang berlangsung secara offline.]
#paragraf[Deskripsi: Workshop Operations Administrator mencatat kontak Customer, kendaraan, dan permintaan servis. Sistem dapat membuat atau menghubungkan akun draft tanpa mewajibkan NIK, menyimpan riwayat, dan melanjutkan pemeriksaan, estimasi, persetujuan, serta pembayaran.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Operations Administrator mencatat kontak, kendaraan, dan permintaan layanan offline. Dokumen identitas dapat dicatat jika digunakan, tetapi NIK tidak diwajibkan.],
    [Membuat atau menghubungkan akun draft, mempertahankan status belum terverifikasi, menyimpan riwayat, dan memasukkan kendaraan ke antrean.],

    [Workshop Operations Administrator meneruskan permintaan untuk pemeriksaan dan estimasi, lalu mencatat persetujuan melalui aplikasi, WhatsApp, atau telepon.],
    [Menyimpan bukti WhatsApp dan mencocokkan nomor pengirim atau mencatat hasil telepon.],

    [Workshop Operations Administrator mencatat pembayaran tunai atau mengarahkan Customer ke pembayaran online.],
    [Mengizinkan pekerjaan hanya setelah persetujuan dan pembayaran tercatat.],
  ),
  caption: [Skenario Full Offline Service Registration],
)

==== Skenario: Marketplace Return
#paragraf[Nomor: SKPL-FR-33]
#paragraf[Nama Use Case: Marketplace Return]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
  [Workshop Warehouse Administrator],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Meninjau retur marketplace yang diajukan dalam batas waktu dan berdasarkan bukti.]
#paragraf[Deskripsi: Customer mengajukan retur paling lama satu hari setelah menandai pesanan diterima dan menyertakan bukti. Workshop Warehouse Administrator meninjau permintaan. Sistem memproses refund hanya setelah keputusan dan tidak melakukannya otomatis.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer mengajukan retur dan mengunggah bukti pembukaan paket atau bukti lain.],
    [Memeriksa tanggal penerimaan, batas waktu satu hari, dan status pesanan.],

    [Workshop Warehouse Administrator meninjau permintaan dan bukti, lalu menetapkan keputusan.],
    [Menyimpan keputusan dan audit. Memproses refund setelah retur disetujui, tidak melakukan refund otomatis, dan memberi tahu Customer.],
  ),
  caption: [Skenario Marketplace Return],
)

==== Skenario: Completed Transaction Review
#paragraf[Nomor: SKPL-FR-40, SKPL-FR-41]
#paragraf[Nama Use Case: Completed Transaction Review]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
  [Workshop Owner],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Menyediakan ulasan transaksi selesai dan tanggapan terbuka dari Workshop Owner.]
#paragraf[Deskripsi: Customer menulis ulasan untuk servis atau pesanan marketplace yang selesai dan dapat mengubahnya selama 24 jam. Sistem menyamarkan identitas Customer pada tampilan Owner. Workshop Owner dapat membalas ulasan secara terbuka.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer menulis atau mengubah ulasan untuk transaksi yang selesai.],
    [Memeriksa status transaksi dan batas waktu 24 jam.],

    [Workshop Owner membalas ulasan menggunakan identitas Owner.],
    [Menyimpan ulasan, membatasi perubahan setelah tenggat, dan menampilkan identitas Customer secara anonim kepada Owner.],
  ),
  caption: [Skenario Completed Transaction Review],
)

==== Skenario: Complaint and Reported Content Handling
#paragraf[Nomor: SKPL-FR-42, SKPL-FR-43, SKPL-FR-44, SKPL-FR-47]
#paragraf[Nama Use Case: Complaint and Reported Content Handling]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Customer],
  [Workshop Owner],
  [Workshop Operations Administrator],
  [Super Admin],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Menangani keluhan dan sengketa berdasarkan bukti serta jejak proses.]
#paragraf[Deskripsi: Customer menyampaikan keluhan dengan bukti. Workshop Owner dan Workshop Operations Administrator meninjau sesuai kewenangannya. Super Admin menengahi sengketa yang belum selesai dan meninjau laporan konten, dengan alasan serta tindakan yang tercatat.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Customer menyampaikan keluhan dan melampirkan bukti yang tersedia.],
    [Menyimpan keluhan dan menghubungkannya dengan catatan audit terkait.],

    [Workshop Owner meninjau keluhan dan mengusulkan penyelesaian.],
    [Mencatat hasil penyelesaian atau meneruskan kasus yang belum selesai.],

    [Workshop Operations Administrator meninjau timeline operasional, foto, dan catatan transaksi.],
    [Mencatat hasil pemeriksaan dan meneruskan sengketa yang belum selesai.],

    [Super Admin meninjau bukti, memediasi sengketa, atau memoderasi konten yang dilaporkan.],
    [Mencatat keputusan, alasan, pelaku, dan waktu tindakan, lalu memberi tahu Customer.],
  ),
  caption: [Skenario Complaint and Reported Content Handling],
)

==== Skenario: Workshop Revenue Report
#paragraf[Nomor: SKPL-FR-39]
#paragraf[Nama Use Case: Workshop Revenue Report]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Workshop Owner],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Menampilkan pendapatan bengkel dengan pemisahan kanal tunai dan online.]
#paragraf[Deskripsi: Workshop Owner memilih periode dan bengkel yang dimiliki. Sistem menyusun laporan dari transaksi yang berada dalam cakupan bengkel serta membedakan kanal pembayaran tunai dan online.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Workshop Owner memilih periode dan bengkel atau cabang yang akan ditinjau.],
    [Memeriksa cakupan akses Owner dan mengambil transaksi yang sesuai.],

    [Workshop Owner membuka laporan pendapatan.],
    [Menghitung dan menampilkan pendapatan dengan pemisahan kanal tunai dan online.],
  ),
  caption: [Skenario Workshop Revenue Report],
)

==== Skenario: Platform Data and Promotion Management
#paragraf[Nomor: SKPL-FR-46]
#paragraf[Nama Use Case: Platform Data and Promotion Management]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Super Admin],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Mengelola data induk dan promosi pada tingkat platform.]
#paragraf[Deskripsi: Super Admin membuat, memperbarui, atau menonaktifkan data induk dan promosi. Sistem memvalidasi perubahan, menyimpan jejak tindakan, dan menerapkan data yang telah disetujui.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Super Admin memilih data induk atau promosi dan memasukkan perubahan.],
    [Memvalidasi kelengkapan, keunikan, dan ketentuan yang tersedia.],

    [Super Admin menyimpan atau menonaktifkan data.],
    [Menerapkan perubahan yang valid dan menyimpan pelaku, waktu, serta tindakan untuk audit.],
  ),
  caption: [Skenario Platform Data and Promotion Management],
)

==== Skenario: Status Notifications
#paragraf[Nomor: SKPL-FR-45]
#paragraf[Nama Use Case: Status Notifications]
#paragraf[Aktor:]
#enum(
  numbering: "a)",
  [Super Admin],
  [Customer],
  [Workshop Owner],
  [Workshop Warehouse Administrator],
  [Workshop Operations Administrator],
  [Mechanic],
  [Pickup Service],
)
#paragraf[Tipe: Primary]
#paragraf[Tujuan: Memberi tahu setiap role tentang perubahan proses yang relevan.]
#paragraf[Deskripsi: Sistem mengirim notifikasi aplikasi sesuai proses yang diikuti Customer, Super Admin, Workshop Owner, Workshop Warehouse Administrator, Workshop Operations Administrator, Mechanic, atau Pickup Service. Email digunakan jika alamat tersedia.]
#figure(
  table(
    columns: (50%, 50%),

    [Actor], [System],
    [Super Admin menerima pemberitahuan untuk proses yang diikuti.],
    [Mengirim notifikasi aplikasi yang sesuai. Mengirim email jika alamat tersedia.],

    [Customer menerima pemberitahuan untuk proses yang diikuti.],
    [Mengirim notifikasi aplikasi yang sesuai. Mengirim email jika alamat tersedia.],

    [Workshop Owner menerima pemberitahuan untuk proses yang diikuti.],
    [Mengirim notifikasi aplikasi yang sesuai. Mengirim email jika alamat tersedia.],

    [Workshop Warehouse Administrator menerima pemberitahuan untuk proses yang diikuti.],
    [Mengirim notifikasi aplikasi yang sesuai. Mengirim email jika alamat tersedia.],

    [Workshop Operations Administrator menerima pemberitahuan untuk proses yang diikuti.],
    [Mengirim notifikasi aplikasi yang sesuai. Mengirim email jika alamat tersedia.],

    [Mechanic menerima pemberitahuan untuk proses yang diikuti.],
    [Mengirim notifikasi aplikasi yang sesuai. Mengirim email jika alamat tersedia.],

    [Pickup Service menerima pemberitahuan untuk proses yang diikuti.],
    [Mengirim notifikasi aplikasi yang sesuai. Mengirim email jika alamat tersedia.],
  ),
  caption: [Skenario Status Notifications],
)

#pagebreak()
#paragraf[
  Kumpulan Activity Diagram berikut menjelaskan alur, keputusan, dan role untuk fungsi-fungsi utama. Setiap diagram menggunakan satu titik mulai dan satu titik akhir. Semua aktivitas yang dilindungi mengasumsikan aktor telah login dan memiliki sesi aktif dengan role serta cakupan bengkel yang sesuai. Registrasi dan verifikasi akun merupakan pengecualian karena dilakukan sebelum login pertama,  pencatatan layanan full offline dilakukan oleh Operations Administrator yang telah login untuk Customer draft.
]

==== Diagram Aktivitas: Login
#figure(
  image(
    "skpl/hasil/Activity Diagram/01-login.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Login],
) <fig:activity-01-login>

==== Diagram Aktivitas: Customer Account Registration
#figure(
  image(
    "skpl/hasil/Activity Diagram/02-account-registration.png",
    width: 100%,
    height: 20cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Account Registration],
) <fig:activity-02-account-registration>

==== Diagram Aktivitas: Account Verification
#figure(
  image(
    "skpl/hasil/Activity Diagram/03-account-verification.png",
    width: 100%,
    height: 20cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Account Verification],
) <fig:activity-03-account-verification>

==== Diagram Aktivitas: Workshop Registration
#figure(
  image(
    "skpl/hasil/Activity Diagram/04-register-workshop.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Register Workshop],
) <fig:activity-04-register-workshop>

==== Diagram Aktivitas: Workshop Verification
#figure(
  image(
    "skpl/hasil/Activity Diagram/05-verify-workshop.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Verify Workshop],
) <fig:activity-05-verify-workshop>

==== Diagram Aktivitas: Employee and Branch Access Management
#figure(
  image(
    "skpl/hasil/Activity Diagram/06-employee-management.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Employee Management],
) <fig:activity-06-employee-management>

==== Diagram Aktivitas: Spare Part Catalog Management
#figure(
  image(
    "skpl/hasil/Activity Diagram/07-product-management.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Product Management],
) <fig:activity-07-product-management>

==== Diagram Aktivitas: Workshop Inventory Management
#figure(
  image(
    "skpl/hasil/Activity Diagram/08-manage-inventory.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Manage Inventory],
) <fig:activity-08-manage-inventory>

==== Diagram Aktivitas: Offline Spare Part Sale
#figure(
  image(
    "skpl/hasil/Activity Diagram/09-order-product-onsite.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Order Product Onsite],
) <fig:activity-09-order-product-onsite>

==== Diagram Aktivitas: Marketplace Spare Part Order
#figure(
  image(
    "skpl/hasil/Activity Diagram/10-order-product-on-marketplace.png",
    width: 100%,
    height: 20cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Order Product On Marketplace],
) <fig:activity-10-order-product-on-marketplace>

==== Diagram Aktivitas: Marketplace Order Fulfillment
#figure(
  image(
    "skpl/hasil/Activity Diagram/11-confirm-order.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Confirm Order],
) <fig:activity-11-confirm-order>

==== Diagram Aktivitas: Marketplace Order Cancellation
#figure(
  image(
    "skpl/hasil/Activity Diagram/12-cancel-order.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Cancel Order],
) <fig:activity-12-cancel-order>

==== Diagram Aktivitas: Customer Vehicle Management
#figure(
  image(
    "skpl/hasil/Activity Diagram/13-manage-vehicle.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Manage Vehicle],
) <fig:activity-13-manage-vehicle>

==== Diagram Aktivitas: Onsite Service Booking
#figure(
  image(
    "skpl/hasil/Activity Diagram/14-booking-service-onsite.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Booking Service Onsite],
) <fig:activity-14-booking-service-onsite>

==== Diagram Aktivitas: Pickup Service Booking
#figure(
  image(
    "skpl/hasil/Activity Diagram/15-booking-service-pickup.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Booking Service Pickup],
) <fig:activity-15-booking-service-pickup>

==== Diagram Aktivitas: Booking Confirmation
#figure(
  image(
    "skpl/hasil/Activity Diagram/16-confirm-booking.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Confirm Booking],
) <fig:activity-16-confirm-booking>

==== Diagram Aktivitas: Booking Cancellation
#figure(
  image(
    "skpl/hasil/Activity Diagram/17-cancel-booking.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Cancel Booking],
) <fig:activity-17-cancel-booking>

==== Diagram Aktivitas: Order and Booking Status
#figure(
  image(
    "skpl/hasil/Activity Diagram/18-view-order-and-booking-status.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - View Order And Booking Status],
) <fig:activity-18-view-order-and-booking-status>

==== Diagram Aktivitas: Technician Assignment
#figure(
  image(
    "skpl/hasil/Activity Diagram/19-assign-technician.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Assign Technician],
) <fig:activity-19-assign-technician>

==== Diagram Aktivitas: Vehicle Inspection and Cost Estimation
#figure(
  image(
    "skpl/hasil/Activity Diagram/20-vehicle-inspection-and-cost-estimation.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Vehicle Inspection And Cost Estimation],
) <fig:activity-20-vehicle-inspection-and-cost-estimation>

==== Diagram Aktivitas: Estimated Cost Approval
#figure(
  image(
    "skpl/hasil/Activity Diagram/21-confirm-estimated-cost.png",
    width: 100%,
    height: 20cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Confirm Estimated Cost],
) <fig:activity-21-confirm-estimated-cost>

==== Diagram Aktivitas: Service Completion
#figure(
  image(
    "skpl/hasil/Activity Diagram/22-confirm-service-completion.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Confirm Service Completion],
) <fig:activity-22-confirm-service-completion>

==== Diagram Aktivitas: Vehicle Pickup
#figure(
  image(
    "skpl/hasil/Activity Diagram/23-pickup-vehicle-for-service.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Pickup Vehicle For Service],
) <fig:activity-23-pickup-vehicle-for-service>

==== Diagram Aktivitas: Vehicle Return
#figure(
  image(
    "skpl/hasil/Activity Diagram/24-return-vehicle-after-service.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Return Vehicle After Service],
) <fig:activity-24-return-vehicle-after-service>

==== Diagram Aktivitas: Payment
#figure(
  image(
    "skpl/hasil/Activity Diagram/25-payment.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Payment],
) <fig:activity-25-payment>

==== Diagram Aktivitas: Payment Confirmation
#figure(
  image(
    "skpl/hasil/Activity Diagram/26-confirm-payment.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Confirm Payment],
) <fig:activity-26-confirm-payment>

==== Diagram Aktivitas: Final Invoice Generation
#figure(
  image(
    "skpl/hasil/Activity Diagram/27-generate-invoice.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Generate Invoice],
) <fig:activity-27-generate-invoice>

==== Diagram Aktivitas: Full Offline Service Registration
#figure(
  image(
    "skpl/hasil/Activity Diagram/28-register-full-offline-service.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Register Full Offline Service],
) <fig:activity-28-register-full-offline-service>

==== Diagram Aktivitas: Marketplace Return
#figure(
  image(
    "skpl/hasil/Activity Diagram/29-marketplace-return.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Marketplace Return],
) <fig:activity-29-marketplace-return>

==== Diagram Aktivitas: Completed Transaction Review
#figure(
  image(
    "skpl/hasil/Activity Diagram/30-review-completed-transaction.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Review Completed Transaction],
) <fig:activity-30-review-completed-transaction>

==== Diagram Aktivitas: Complaint and Reported Content Handling
#figure(
  image(
    "skpl/hasil/Activity Diagram/31-handle-complaint.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Handle Complaint],
) <fig:activity-31-handle-complaint>

==== Diagram Aktivitas: Workshop Revenue Report
#figure(
  image("skpl/hasil/Activity Diagram/32-workshop-revenue-report.png", width: 100%, height: 19cm, fit: "contain"),
  caption: [Activity Diagram - Workshop Revenue Report],
) <fig:activity-32-workshop-revenue-report>

==== Diagram Aktivitas: Platform Data and Promotion Management
#figure(
  image(
    "skpl/hasil/Activity Diagram/33-platform-data-and-promotion-management.png",
    width: 100%,
    height: 19cm,
    fit: "contain",
  ),
  caption: [Activity Diagram - Platform Data and Promotion Management],
) <fig:activity-33-platform-data-and-promotion-management>

==== Diagram Aktivitas: Status Notifications
#figure(
  image("skpl/hasil/Activity Diagram/34-status-notifications.png", width: 100%),
  caption: [Activity Diagram - Status Notifications],
) <fig:activity-34-status-notifications>

==== Diagram Sekuens: Login
#figure(
  image(
    "skpl/hasil/Sequence Diagram Login.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Login Sequence Diagram],
) <fig:sequence-login>

==== Diagram Sekuens: Customer Account Registration
#figure(
  image("skpl/hasil/Sequence Diagram/02-account-registration.png", width: 100%),
  caption: [Sequence Diagram - Customer Account Registration],
) <fig:sequence-02-account-registration>

==== Diagram Sekuens: Account Verification
#figure(
  image("skpl/hasil/Sequence Diagram/03-account-verification.png", width: 100%),
  caption: [Sequence Diagram - Account Verification],
) <fig:sequence-03-account-verification>

==== Diagram Sekuens: Workshop Registration
#figure(
  image("skpl/hasil/Sequence Diagram/04-register-workshop.png", width: 100%),
  caption: [Sequence Diagram - Workshop Registration],
) <fig:sequence-04-register-workshop>

==== Diagram Sekuens: Workshop Verification
#figure(
  image("skpl/hasil/Sequence Diagram/05-verify-workshop.png", width: 100%),
  caption: [Sequence Diagram - Workshop Verification],
) <fig:sequence-05-verify-workshop>

==== Diagram Sekuens: Employee and Branch Access Management
#figure(
  image("skpl/hasil/Sequence Diagram/06-employee-management.png", width: 100%),
  caption: [Sequence Diagram - Employee and Branch Access Management],
) <fig:sequence-06-employee-management>

==== Diagram Sekuens: Spare Part Catalog Management
#figure(
  image("skpl/hasil/Sequence Diagram/07-product-management.png", width: 100%),
  caption: [Sequence Diagram - Spare Part Catalog Management],
) <fig:sequence-07-product-management>

==== Diagram Sekuens: Workshop Inventory Management
#figure(
  image("skpl/hasil/Sequence Diagram/08-manage-inventory.png", width: 100%),
  caption: [Sequence Diagram - Workshop Inventory Management],
) <fig:sequence-08-manage-inventory>

==== Diagram Sekuens: Offline Spare Part Sale
#figure(
  image("skpl/hasil/Sequence Diagram/09-order-product-onsite.png", width: 100%),
  caption: [Sequence Diagram - Offline Spare Part Sale],
) <fig:sequence-09-order-product-onsite>

==== Diagram Sekuens: Marketplace Spare Part Order
#figure(
  image("skpl/hasil/Sequence Diagram/10-order-product-on-marketplace.png", width: 100%),
  caption: [Sequence Diagram - Marketplace Spare Part Order],
) <fig:sequence-10-order-product-on-marketplace>

==== Diagram Sekuens: Marketplace Order Fulfillment
#figure(
  image("skpl/hasil/Sequence Diagram/11-confirm-order.png", width: 100%),
  caption: [Sequence Diagram - Marketplace Order Fulfillment],
) <fig:sequence-11-confirm-order>

==== Diagram Sekuens: Marketplace Order Cancellation
#figure(
  image("skpl/hasil/Sequence Diagram/12-cancel-order.png", width: 100%),
  caption: [Sequence Diagram - Marketplace Order Cancellation],
) <fig:sequence-12-cancel-order>

==== Diagram Sekuens: Customer Vehicle Management
#figure(
  image("skpl/hasil/Sequence Diagram/13-manage-vehicle.png", width: 100%),
  caption: [Sequence Diagram - Customer Vehicle Management],
) <fig:sequence-13-manage-vehicle>

==== Diagram Sekuens: Onsite Service Booking
#figure(
  image("skpl/hasil/Sequence Diagram/14-booking-service-onsite.png", width: 100%),
  caption: [Sequence Diagram - Onsite Service Booking],
) <fig:sequence-14-booking-service-onsite>

==== Diagram Sekuens: Pickup Service Booking
#figure(
  image("skpl/hasil/Sequence Diagram/15-booking-service-pickup.png", width: 100%),
  caption: [Sequence Diagram - Pickup Service Booking],
) <fig:sequence-15-booking-service-pickup>

==== Diagram Sekuens: Booking Confirmation
#figure(
  image("skpl/hasil/Sequence Diagram/16-confirm-booking.png", width: 100%),
  caption: [Sequence Diagram - Booking Confirmation],
) <fig:sequence-16-confirm-booking>

==== Diagram Sekuens: Booking Cancellation
#figure(
  image("skpl/hasil/Sequence Diagram/17-cancel-booking.png", width: 100%),
  caption: [Sequence Diagram - Booking Cancellation],
) <fig:sequence-17-cancel-booking>

==== Diagram Sekuens: Order and Booking Status
#figure(
  image("skpl/hasil/Sequence Diagram/18-view-order-and-booking-status.png", width: 100%),
  caption: [Sequence Diagram - Order and Booking Status],
) <fig:sequence-18-view-order-and-booking-status>

==== Diagram Sekuens: Technician Assignment
#figure(
  image("skpl/hasil/Sequence Diagram/19-assign-technician.png", width: 100%),
  caption: [Sequence Diagram - Technician Assignment],
) <fig:sequence-19-assign-technician>

==== Diagram Sekuens: Vehicle Inspection and Cost Estimation
#figure(
  image("skpl/hasil/Sequence Diagram/20-vehicle-inspection-and-cost-estimation.png", width: 100%),
  caption: [Sequence Diagram - Vehicle Inspection and Cost Estimation],
) <fig:sequence-20-vehicle-inspection-and-cost-estimation>

==== Diagram Sekuens: Estimated Cost Approval
#figure(
  image("skpl/hasil/Sequence Diagram/21-confirm-estimated-cost.png", width: 100%),
  caption: [Sequence Diagram - Estimated Cost Approval],
) <fig:sequence-21-confirm-estimated-cost>

==== Diagram Sekuens: Service Completion
#figure(
  image("skpl/hasil/Sequence Diagram/22-confirm-service-completion.png", width: 100%),
  caption: [Sequence Diagram - Service Completion],
) <fig:sequence-22-confirm-service-completion>

==== Diagram Sekuens: Vehicle Pickup
#figure(
  image("skpl/hasil/Sequence Diagram/23-pickup-vehicle-for-service.png", width: 100%),
  caption: [Sequence Diagram - Vehicle Pickup],
) <fig:sequence-23-pickup-vehicle-for-service>

==== Diagram Sekuens: Vehicle Return
#figure(
  image("skpl/hasil/Sequence Diagram/24-return-vehicle-after-service.png", width: 100%),
  caption: [Sequence Diagram - Vehicle Return],
) <fig:sequence-24-return-vehicle-after-service>

==== Diagram Sekuens: Payment
#figure(
  image("skpl/hasil/Sequence Diagram/25-payment.png", width: 100%),
  caption: [Sequence Diagram - Payment],
) <fig:sequence-25-payment>

==== Diagram Sekuens: Payment Confirmation
#figure(
  image("skpl/hasil/Sequence Diagram/26-confirm-payment.png", width: 100%),
  caption: [Sequence Diagram - Payment Confirmation],
) <fig:sequence-26-confirm-payment>

==== Diagram Sekuens: Final Invoice Generation
#figure(
  image("skpl/hasil/Sequence Diagram/27-generate-invoice.png", width: 100%),
  caption: [Sequence Diagram - Final Invoice Generation],
) <fig:sequence-27-generate-invoice>

==== Diagram Sekuens: Full Offline Service Registration
#figure(
  image("skpl/hasil/Sequence Diagram/28-register-full-offline-service.png", width: 100%),
  caption: [Sequence Diagram - Full Offline Service Registration],
) <fig:sequence-28-register-full-offline-service>

==== Diagram Sekuens: Marketplace Return
#figure(
  image("skpl/hasil/Sequence Diagram/29-marketplace-return.png", width: 100%),
  caption: [Sequence Diagram - Marketplace Return],
) <fig:sequence-29-marketplace-return>

==== Diagram Sekuens: Completed Transaction Review
#figure(
  image("skpl/hasil/Sequence Diagram/30-review-completed-transaction.png", width: 100%),
  caption: [Sequence Diagram - Completed Transaction Review],
) <fig:sequence-30-review-completed-transaction>

==== Diagram Sekuens: Complaint and Reported Content Handling
#figure(
  image("skpl/hasil/Sequence Diagram/31-handle-complaint.png", width: 100%),
  caption: [Sequence Diagram - Complaint and Reported Content Handling],
) <fig:sequence-31-handle-complaint>

==== Diagram Sekuens: Workshop Revenue Report
#figure(
  image("skpl/hasil/Sequence Diagram/32-workshop-revenue-report.png", width: 100%),
  caption: [Sequence Diagram - Workshop Revenue Report],
) <fig:sequence-32-workshop-revenue-report>

==== Diagram Sekuens: Platform Data and Promotion Management
#figure(
  image("skpl/hasil/Sequence Diagram/33-platform-data-and-promotion-management.png", width: 100%),
  caption: [Sequence Diagram - Platform Data and Promotion Management],
) <fig:sequence-33-platform-data-and-promotion-management>

==== Diagram Sekuens: Status Notifications
#figure(
  image("skpl/hasil/Sequence Diagram/34-status-notifications.png", width: 100%),
  caption: [Sequence Diagram - Status Notifications],
) <fig:sequence-34-status-notifications>

==== Diagram Kolaborasi Objek: Login
#paragraf[
  Diagram kolaborasi menggunakan relasi objek dan pesan bernomor untuk menunjukkan pertukaran pesan saat autentikasi login.
]
#figure(
  image(
    "skpl/hasil/Collaboration Diagram Login.png",
    width: 100%,
    height: 17cm,
    fit: "contain",
  ),
  caption: [Login Object Collaboration Diagram],
) <fig:collaboration-login>

==== Diagram Kolaborasi Objek: Customer Account Registration
#figure(
  image("skpl/hasil/Collaboration Diagram/02-account-registration.png", width: 100%),
  caption: [Object Collaboration Diagram - Customer Account Registration],
) <fig:collaboration-02-account-registration>

==== Diagram Kolaborasi Objek: Account Verification
#figure(
  image("skpl/hasil/Collaboration Diagram/03-account-verification.png", width: 100%),
  caption: [Object Collaboration Diagram - Account Verification],
) <fig:collaboration-03-account-verification>

==== Diagram Kolaborasi Objek: Workshop Registration
#figure(
  image("skpl/hasil/Collaboration Diagram/04-register-workshop.png", width: 100%),
  caption: [Object Collaboration Diagram - Workshop Registration],
) <fig:collaboration-04-register-workshop>

==== Diagram Kolaborasi Objek: Workshop Verification
#figure(
  image("skpl/hasil/Collaboration Diagram/05-verify-workshop.png", width: 100%),
  caption: [Object Collaboration Diagram - Workshop Verification],
) <fig:collaboration-05-verify-workshop>

==== Diagram Kolaborasi Objek: Employee and Branch Access Management
#figure(
  image("skpl/hasil/Collaboration Diagram/06-employee-management.png", width: 100%),
  caption: [Object Collaboration Diagram - Employee and Branch Access Management],
) <fig:collaboration-06-employee-management>

==== Diagram Kolaborasi Objek: Spare Part Catalog Management
#figure(
  image("skpl/hasil/Collaboration Diagram/07-product-management.png", width: 100%),
  caption: [Object Collaboration Diagram - Spare Part Catalog Management],
) <fig:collaboration-07-product-management>

==== Diagram Kolaborasi Objek: Workshop Inventory Management
#figure(
  image("skpl/hasil/Collaboration Diagram/08-manage-inventory.png", width: 100%),
  caption: [Object Collaboration Diagram - Workshop Inventory Management],
) <fig:collaboration-08-manage-inventory>

==== Diagram Kolaborasi Objek: Offline Spare Part Sale
#figure(
  image("skpl/hasil/Collaboration Diagram/09-order-product-onsite.png", width: 100%),
  caption: [Object Collaboration Diagram - Offline Spare Part Sale],
) <fig:collaboration-09-order-product-onsite>

==== Diagram Kolaborasi Objek: Marketplace Spare Part Order
#figure(
  image("skpl/hasil/Collaboration Diagram/10-order-product-on-marketplace.png", width: 100%),
  caption: [Object Collaboration Diagram - Marketplace Spare Part Order],
) <fig:collaboration-10-order-product-on-marketplace>

==== Diagram Kolaborasi Objek: Marketplace Order Fulfillment
#figure(
  image("skpl/hasil/Collaboration Diagram/11-confirm-order.png", width: 100%),
  caption: [Object Collaboration Diagram - Marketplace Order Fulfillment],
) <fig:collaboration-11-confirm-order>

==== Diagram Kolaborasi Objek: Marketplace Order Cancellation
#figure(
  image("skpl/hasil/Collaboration Diagram/12-cancel-order.png", width: 100%),
  caption: [Object Collaboration Diagram - Marketplace Order Cancellation],
) <fig:collaboration-12-cancel-order>

==== Diagram Kolaborasi Objek: Customer Vehicle Management
#figure(
  image("skpl/hasil/Collaboration Diagram/13-manage-vehicle.png", width: 100%),
  caption: [Object Collaboration Diagram - Customer Vehicle Management],
) <fig:collaboration-13-manage-vehicle>

==== Diagram Kolaborasi Objek: Onsite Service Booking
#figure(
  image("skpl/hasil/Collaboration Diagram/14-booking-service-onsite.png", width: 100%),
  caption: [Object Collaboration Diagram - Onsite Service Booking],
) <fig:collaboration-14-booking-service-onsite>

==== Diagram Kolaborasi Objek: Pickup Service Booking
#figure(
  image("skpl/hasil/Collaboration Diagram/15-booking-service-pickup.png", width: 100%),
  caption: [Object Collaboration Diagram - Pickup Service Booking],
) <fig:collaboration-15-booking-service-pickup>

==== Diagram Kolaborasi Objek: Booking Confirmation
#figure(
  image("skpl/hasil/Collaboration Diagram/16-confirm-booking.png", width: 100%),
  caption: [Object Collaboration Diagram - Booking Confirmation],
) <fig:collaboration-16-confirm-booking>

==== Diagram Kolaborasi Objek: Booking Cancellation
#figure(
  image("skpl/hasil/Collaboration Diagram/17-cancel-booking.png", width: 100%),
  caption: [Object Collaboration Diagram - Booking Cancellation],
) <fig:collaboration-17-cancel-booking>

==== Diagram Kolaborasi Objek: Order and Booking Status
#figure(
  image("skpl/hasil/Collaboration Diagram/18-view-order-and-booking-status.png", width: 100%),
  caption: [Object Collaboration Diagram - Order and Booking Status],
) <fig:collaboration-18-view-order-and-booking-status>

==== Diagram Kolaborasi Objek: Technician Assignment
#figure(
  image("skpl/hasil/Collaboration Diagram/19-assign-technician.png", width: 100%),
  caption: [Object Collaboration Diagram - Technician Assignment],
) <fig:collaboration-19-assign-technician>

==== Diagram Kolaborasi Objek: Vehicle Inspection and Cost Estimation
#figure(
  image("skpl/hasil/Collaboration Diagram/20-vehicle-inspection-and-cost-estimation.png", width: 100%),
  caption: [Object Collaboration Diagram - Vehicle Inspection and Cost Estimation],
) <fig:collaboration-20-vehicle-inspection-and-cost-estimation>

==== Diagram Kolaborasi Objek: Estimated Cost Approval
#figure(
  image("skpl/hasil/Collaboration Diagram/21-confirm-estimated-cost.png", width: 100%),
  caption: [Object Collaboration Diagram - Estimated Cost Approval],
) <fig:collaboration-21-confirm-estimated-cost>

==== Diagram Kolaborasi Objek: Service Completion
#figure(
  image("skpl/hasil/Collaboration Diagram/22-confirm-service-completion.png", width: 100%),
  caption: [Object Collaboration Diagram - Service Completion],
) <fig:collaboration-22-confirm-service-completion>

==== Diagram Kolaborasi Objek: Vehicle Pickup
#figure(
  image("skpl/hasil/Collaboration Diagram/23-pickup-vehicle-for-service.png", width: 100%),
  caption: [Object Collaboration Diagram - Vehicle Pickup],
) <fig:collaboration-23-pickup-vehicle-for-service>

==== Diagram Kolaborasi Objek: Vehicle Return
#figure(
  image("skpl/hasil/Collaboration Diagram/24-return-vehicle-after-service.png", width: 100%),
  caption: [Object Collaboration Diagram - Vehicle Return],
) <fig:collaboration-24-return-vehicle-after-service>

==== Diagram Kolaborasi Objek: Payment
#figure(
  image("skpl/hasil/Collaboration Diagram/25-payment.png", width: 100%),
  caption: [Object Collaboration Diagram - Payment],
) <fig:collaboration-25-payment>

==== Diagram Kolaborasi Objek: Payment Confirmation
#figure(
  image("skpl/hasil/Collaboration Diagram/26-confirm-payment.png", width: 100%),
  caption: [Object Collaboration Diagram - Payment Confirmation],
) <fig:collaboration-26-confirm-payment>

==== Diagram Kolaborasi Objek: Final Invoice Generation
#figure(
  image("skpl/hasil/Collaboration Diagram/27-generate-invoice.png", width: 100%),
  caption: [Object Collaboration Diagram - Final Invoice Generation],
) <fig:collaboration-27-generate-invoice>

==== Diagram Kolaborasi Objek: Full Offline Service Registration
#figure(
  image("skpl/hasil/Collaboration Diagram/28-register-full-offline-service.png", width: 100%),
  caption: [Object Collaboration Diagram - Full Offline Service Registration],
) <fig:collaboration-28-register-full-offline-service>

==== Diagram Kolaborasi Objek: Marketplace Return
#figure(
  image("skpl/hasil/Collaboration Diagram/29-marketplace-return.png", width: 100%),
  caption: [Object Collaboration Diagram - Marketplace Return],
) <fig:collaboration-29-marketplace-return>

==== Diagram Kolaborasi Objek: Completed Transaction Review
#figure(
  image("skpl/hasil/Collaboration Diagram/30-review-completed-transaction.png", width: 100%),
  caption: [Object Collaboration Diagram - Completed Transaction Review],
) <fig:collaboration-30-review-completed-transaction>

==== Diagram Kolaborasi Objek: Complaint and Reported Content Handling
#figure(
  image("skpl/hasil/Collaboration Diagram/31-handle-complaint.png", width: 100%),
  caption: [Object Collaboration Diagram - Complaint and Reported Content Handling],
) <fig:collaboration-31-handle-complaint>

==== Diagram Kolaborasi Objek: Workshop Revenue Report
#figure(
  image("skpl/hasil/Collaboration Diagram/32-workshop-revenue-report.png", width: 100%),
  caption: [Object Collaboration Diagram - Workshop Revenue Report],
) <fig:collaboration-32-workshop-revenue-report>

==== Diagram Kolaborasi Objek: Platform Data and Promotion Management
#figure(
  image("skpl/hasil/Collaboration Diagram/33-platform-data-and-promotion-management.png", width: 100%),
  caption: [Object Collaboration Diagram - Platform Data and Promotion Management],
) <fig:collaboration-33-platform-data-and-promotion-management>

==== Diagram Kolaborasi Objek: Status Notifications
#figure(
  image("skpl/hasil/Collaboration Diagram/34-status-notifications.png", width: 100%),
  caption: [Object Collaboration Diagram - Status Notifications],
) <fig:collaboration-34-status-notifications>

#pagebreak()
== Deskripsi Kelas-kelas
=== Diagram Kelas
#paragraf[
  Diagram kelas merangkum entitas persisten yang terlihat pada skema awal serta EstimateDocument dan Invoice sebagai konsep bisnis yang disebutkan pada baseline kebutuhan. Kelas konseptual tersebut tidak dinyatakan sebagai tabel fisik yang sudah tersedia,  pemetaan akhirnya ditetapkan pada DPPL.
]
#figure(
  image(
    "skpl/hasil/Class Diagram.png",
    width: 100%,
    height: 15cm,
    fit: "contain",
  ),
  caption: [Service Ride Class Diagram],
) <fig:class-diagram>

=== Deskripsi Domain Persoalan
#paragraf[
  Tabel ini merangkum kelompok domain utama. Nama operasi merupakan tanggung jawab konseptual sistem,  rincian metode dan tipe data ditetapkan pada DPPL.
]
#figure(
  table(
    columns: (10%, 22.5%, 22.5%, 22.5%, 22.5%),

    table.header([No.], [Nama], [Metode], [Atribute], [Tugas]),
    [1],
    [User],
    [register, authenticate, assign role],
    [account ID, contact, role, status],
    [Menyimpan identitas akun dan status akses.],

    [2],
    [Workshop],
    [register, verify, manage branches],
    [owner, legal status, branch, settings],
    [Menyimpan bengkel, cabang, legalitas, dan pengaturan.],

    [3],
    [Workshop#linebreak()Document],
    [upload, review, approve],
    [workshop ID, document type, status, reviewer],
    [Menyimpan bukti legalitas dan hasil verifikasi.],

    [4],
    [Workshop#linebreak()User#linebreak()Management],
    [assign, activate, deactivate],
    [user ID, workshop ID, role, active status],
    [Menyimpan penugasan role karyawan pada bengkel.],

    [5],
    [Vehicle],
    [register, update, select],
    [owner ID, plate number, brand, model, type],
    [Menyimpan kendaraan yang dipakai pada booking.],

    [6],
    [Address],
    [create, update, select],
    [user ID, address, coordinates, default status],
    [Menyimpan alamat pelanggan untuk layanan terkait.],

    [7],
    [Booking],
    [create, schedule, cancel, update status],
    [customer ID, workshop ID, vehicle ID, type, status],
    [Menyimpan booking online dan antrean layanan offline.],

    [8],
    [Booking#linebreak()Service],
    [inspect, diagnose, update progress],
    [booking ID, mechanic ID, diagnosis, price, photos],
    [Menyimpan pemeriksaan dan pekerjaan servis.],

    [9],
    [Booking#linebreak()Pickup],
    [assign, depart, hand over, cancel],
    [booking ID, pickup role, fee, schedule, status],
    [Menyimpan tugas pickup dan pengantaran kendaraan.],

    [10],
    [Booking#linebreak()Pickup#linebreak()History],
    [record location, record status],
    [pickup ID, coordinates, status, timestamp],
    [Menyimpan riwayat lokasi dan serah terima.],

    [11],
    [Product],
    [create, update, publish],
    [workshop ID, category, SKU, name, price],
    [Menyimpan katalog spare part bengkel.],

    [12],
    [Product#linebreak()Stock],
    [check, reserve, consume, release],
    [product ID, serial number, status, reservation],
    [Menyimpan unit stok dan status ketersediaannya.],

    [13], [Category], [create, update, list], [category ID, name, timestamps], [Mengelompokkan produk spare part.],
    [14],
    [Category#linebreak()Brand],
    [create, update, list],
    [brand ID, name, logo, timestamps],
    [Menyimpan merek produk.],

    [15],
    [Booking#linebreak()Product],
    [add, reserve, consume],
    [booking ID, product ID, quantity, price],
    [Menghubungkan spare part dengan layanan booking.],

    [16],
    [Marketplace#linebreak()Transaction],
    [checkout, cancel, complete, return],
    [customer ID, code, status, totals, address],
    [Menyimpan transaksi pembelian spare part.],

    [17],
    [Marketplace#linebreak()Transaction#linebreak()Detail],
    [create, fulfill, update item status],
    [transaction ID, workshop ID, product ID, quantity],
    [Menyimpan rincian item pesanan marketplace.],

    [18],
    [Payment],
    [initialize, confirm, record, refund],
    [transaction ID, method, type, amount, status],
    [Menyimpan pembayaran dan status pengembaliannya.],

    [19],
    [Review],
    [create, edit, reply, moderate],
    [customer ID, transaction ID, rating, content],
    [Menyimpan review dan tanggapan yang terkait transaksi.],

    [20],
    [Estimate#linebreak()Document],
    [prepare, revise, approve],
    [version, item costs, completion time, evidence],
    [Mewakili konsep dokumen estimasi sebelum persetujuan.],

    [21],
    [Invoice],
    [issue, number, provide],
    [transaction ID, final amount, issue status],
    [Mewakili konsep invoice final yang terpisah dari estimasi.],
  ),
  caption: [Deskripsi Kelas Domain Persoalan],
)

=== Deskripsi Kelas Pengendali
#paragraf[
  Kelas pengendali menerima permintaan dari antarmuka, memeriksa hak akses, menjalankan aturan proses, lalu mengoordinasikan penyimpanan dan notifikasi. Kelompok berikut adalah rancangan konseptual, bukan nama kelas implementasi yang telah ditetapkan.
]
#figure(
  table(
    columns: (10%, 22.5%, 22.5%, 22.5%, 22.5%),

    table.header([No.], [Nama], [Metode], [Atribute], [Tugas]),
    [1],
    [Account#linebreak()Controller],
    [authenticate, authorize],
    [account ID, role, status],
    [Memvalidasi kredensial dan hak akses.],

    [2],
    [Workshop#linebreak()Controller],
    [register, verify, manage branch],
    [owner ID, workshop scope, document state],
    [Mengelola bengkel, cabang, dan proses legalitas.],

    [3],
    [Booking#linebreak()Controller],
    [create, schedule, update, cancel],
    [customer scope, workshop scope, booking state],
    [Mengelola booking online dan antrean offline.],

    [4],
    [Estimate#linebreak()Controller],
    [calculate, revise, request approval],
    [inspection, estimate version, approval evidence],
    [Mengelola estimasi dan persetujuan Customer.],

    [5],
    [Inventory#linebreak()Controller],
    [check, reserve, consume, release],
    [workshop scope, stock unit, movement state],
    [Menjaga ketersediaan dan alokasi unit stok.],

    [6],
    [Marketplace#linebreak()Controller],
    [checkout, fulfill, return],
    [customer, listing, order, shipment context],
    [Mengelola transaksi marketplace dan retur.],

    [7],
    [Payment#linebreak()Controller],
    [initialize, confirm, record, refund],
    [amount, channel, transaction, payment state],
    [Mengelola pembayaran online, tunai, saldo, dan refund.],

    [8],
    [Pickup#linebreak()Controller],
    [assign, update location, hand over],
    [pickup task, driver, route, status],
    [Mengelola tugas dan status pickup.],

    [9],
    [ReviewComplaint#linebreak()Controller],
    [review, reply, report, moderate],
    [transaction, evidence, case status],
    [Mengelola review, keluhan, dan tindakan moderasi.],
  ),
  caption: [Deskripsi Kelas Pengendali],
)

=== Deskripsi Kelas Entity (Persisten)
#paragraf[
  Entitas persisten berikut mengacu pada tabel yang telah didefinisikan pada skema awal proyek. Estimasi dan invoice dicatat sebagai kebutuhan dokumen pada baseline, tetapi belum diperlakukan sebagai tabel fisik dalam skema tersebut.
]
#figure(
  table(
    columns: (10%, 22.5%, 22.5%, 22.5%, 22.5%),

    table.header([No.], [Nama], [Atribute], [Metode], [Tugas]),
    [1],
    [User],
    [id, name, email, password_hash, phone_number, profile, role, account_status, is_verified],
    [authenticate, update profile, change status],
    [Menyimpan akun, kontak, role, dan status pengguna.],

    [2],
    [Address],
    [id, id_user, full_address, geog, is_default],
    [create, update, select],
    [Menyimpan alamat dan koordinat pengguna.],

    [3],
    [Vehicle],
    [id, id_user, plate_number, brand, model, production_year, type],
    [create, update, select],
    [Menyimpan kendaraan milik Customer.],

    [4],
    [Workshop],
    [id, id_user, name, phone_number, verified, marketplace_enabled],
    [register, update, activate],
    [Menyimpan bengkel, pemilik, dan status layanan.],

    [5],
    [Workshop#linebreak()Document],
    [id, id_workshop, nib, npwp, business_incorporation_certificate, business_incorporation_declaration, status, approved_by],
    [upload, review, approve],
    [Menyimpan dokumen legalitas dan keputusan verifikasi.],

    [6],
    [Workshop#linebreak()User#linebreak()Management],
    [id, id_user, id_workshop, role, is_active],
    [assign, activate, deactivate],
    [Menyimpan role dan penugasan karyawan bengkel.],

    [7], [Category], [id, name, timestamps, deleted_at], [create, update, archive], [Menyimpan kategori produk.],
    [8],
    [Category#linebreak()Brand],
    [id, name, logo, timestamps, deleted_at],
    [create, update, archive],
    [Menyimpan merek produk.],

    [9],
    [Product],
    [id, id_workshop, id_category, sku, name, price],
    [create, update, publish],
    [Menyimpan katalog produk pada bengkel.],

    [10],
    [Marketplace#linebreak()Transaction],
    [id, id_user, transaction_code, status, total_amount],
    [create, cancel, complete],
    [Menyimpan transaksi marketplace.],

    [11],
    [Marketplace#linebreak()Transaction#linebreak()Detail],
    [id, id_marketplace_transaction, id_workshop, id_product, quantity, price],
    [create, fulfill, update status],
    [Menyimpan rincian item marketplace.],

    [12],
    [Booking],
    [id, id_user, id_workshop, id_vehicle, booking_type, status],
    [create, schedule, cancel, update status],
    [Menyimpan booking servis.],

    [13],
    [Booking#linebreak()Product],
    [id, id_booking, id_product, quantity, unit_price],
    [add, reserve, consume],
    [Menyimpan spare part yang terkait booking.],

    [14],
    [Product#linebreak()Stock],
    [id, id_product, serial_number, status, reserved_at],
    [reserve, consume, release, record movement],
    [Menyimpan unit stok fisik dan status alokasinya.],

    [15],
    [Booking#linebreak()Service],
    [id, id_booking, id_mechanic, diagnosis, labor_price, inspection_photos],
    [inspect, update progress, complete],
    [Menyimpan diagnosis, pekerjaan, harga jasa, dan bukti.],

    [16],
    [Booking#linebreak()Pickup],
    [id, id_booking, pickup_type, pickup_fee, scheduled_at, status],
    [assign, depart, arrive, hand over],
    [Menyimpan penjadwalan pickup dan pengantaran.],

    [17],
    [Booking#linebreak()Pickup#linebreak()History],
    [id, id_booking_pickup, geog, status, recorded_at],
    [record location, append status],
    [Menyimpan riwayat lokasi dan status pickup.],

    [18],
    [Payment],
    [id, id_user, transaction links, payment_code, payment_type, method, status],
    [initialize, confirm, record, refund],
    [Menyimpan kanal, nilai, dan status pembayaran.],

    [19],
    [Review],
    [id, id_user, id_workshop, transaction links, rating, comment, owner_reply],
    [create, edit, reply, moderate],
    [Menyimpan review dan balasan Owner.],
  ),
  caption: [Deskripsi Kelas Entity],
)

=== Deskripsi Kelas Boundary
#paragraf[
  Kelas boundary merepresentasikan layar dan formulir yang menjadi batas interaksi pengguna dengan sistem. Rincian tampilan mengikuti hak akses tiap role dan rancangan antarmuka proyek.
]
#figure(
  table(
    columns: (10%, 22.5%, 22.5%, 22.5%, 22.5%),

    table.header([No.], [Nama], [Atribute], [Metode], [Tugas]),
    [1],
    [Customer#linebreak()Portal],
    [account, vehicle, booking, estimate, transaction],
    [search, book, approve, pay, review],
    [Menyajikan layanan Customer dan data transaksinya.],

    [2],
    [SuperAdmin#linebreak()Portal],
    [verification, moderation, platform data],
    [verify, moderate, configure],
    [Menyajikan fungsi platform untuk Super Admin.],

    [3],
    [WorkshopOwner#linebreak()Portal],
    [workshop, branch, employee, reports],
    [register, assign, configure, view],
    [Menyajikan fungsi Owner untuk bengkel miliknya.],

    [4],
    [Warehouse#linebreak()Portal],
    [product, stock unit, marketplace order],
    [manage catalog, reserve, fulfill, review return],
    [Menyajikan fungsi gudang untuk bengkel yang ditugaskan.],

    [5],
    [Operations#linebreak()Portal],
    [booking, queue, estimate, payment, service state],
    [confirm, schedule, record, communicate],
    [Menyajikan fungsi operasional bengkel.],

    [6],
    [Mechanic#linebreak()Portal],
    [inspection, diagnosis, task, evidence],
    [inspect, upload evidence, update progress],
    [Menyajikan pekerjaan servis yang ditugaskan.],

    [7],
    [PickupService#linebreak()Portal],
    [pickup task, location, handover],
    [update location, record status, confirm handover],
    [Menyajikan tugas pickup dan serah terima.],
  ),
  caption: [Deskripsi Kelas Boundary],
)

== Deskripsi Perilaku Sistem
#paragraf[
  Statechart berikut menggambarkan siklus utama booking servis. Booking bergerak dari pending ke konfirmasi, pemeriksaan, persetujuan estimasi, pengerjaan, dan selesai,  penolakan estimasi atau pembatalan mengakhiri proses tanpa memulai servis. Perubahan tagihan setelah estimasi disetujui tidak diperbolehkan.
]
#figure(
  image(
    "skpl/hasil/Statechart Diagram Booking.png",
    width: 100%,
    height: 15cm,
    fit: "contain",
  ),
  caption: [Booking and Service Lifecycle Statechart],
) <fig:booking-statechart>

== Kebutuhan Non Fungsional
#paragraf[
  Kebutuhan kualitas menekankan pemisahan akses menurut role dan bengkel, konsistensi stok unit yang digunakan lintas servis dan penjualan, rekam jejak persetujuan serta pembayaran, perlindungan data pelanggan, keterlacakan foto dan status pekerjaan, penanganan keterlambatan lokasi, dan penggunaan antarmuka pada ukuran perangkat berbeda. Baseline belum menetapkan target angka untuk ketersediaan, waktu respons, kapasitas, atau masa retensi.
]
#figure(
  table(
    columns: (20%, 20%, 60%),

    table.header([SKPL-Id], [Parameter], [Kebutuhan]),
    [SKPL-NFR-01],
    [Access Control],
    [Hak akses harus diuji agar karyawan suatu bengkel tidak dapat membaca atau mengubah data bengkel lain.],

    [SKPL-NFR-02],
    [Inventory Consistency],
    [Perubahan stok unit dan status pending harus tetap konsisten saat transaksi servis dan marketplace berjalan secara bersamaan.],

    [SKPL-NFR-03],
    [Estimate Integrity],
    [Estimasi yang telah disetujui harus memiliki rekam jejak dan tidak dapat mengalami perubahan tagihan secara sepihak.],

    [SKPL-NFR-04],
    [Auditability],
    [Keputusan ACC, pembayaran, refund, pembatalan, suspend, dan moderasi harus dapat diaudit berdasarkan pelaku, waktu, dan tindakan.],

    [SKPL-NFR-05],
    [Data Privacy],
    [Dokumen identitas, nomor kontak, foto, dan riwayat kendaraan hanya ditampilkan kepada role yang mempunyai kebutuhan kerja.],

    [SKPL-NFR-06],
    [Location Updates],
    [Pembaruan lokasi GPS ditampilkan secara berkala dengan penanganan kondisi tanpa update. Sistem tidak menyatakan pelacakan setiap detik.],

    [SKPL-NFR-07],
    [Financial Reconciliation],
    [Data pembayaran dan saldo internal harus dapat direkonsiliasi dari riwayat transaksi, bukan hanya dari angka saldo akhir.],

    [SKPL-NFR-08],
    [Evidence Traceability],
    [Sistem harus mempertahankan bukti pemeriksaan dan perbaikan yang diperlukan untuk penyelesaian komplain dan pengujian sengketa.],

    [SKPL-NFR-09],
    [Responsive Interface],
    [Antarmuka Customer dan karyawan mitra harus tetap dapat digunakan pada ukuran layar yang berbeda.],

    [SKPL-NFR-10],
    [Failure Handling],
    [Pengujian harus mencakup QRIS yang belum tervalidasi, stok menjadi pending, lokasi driver tidak terkirim, estimasi ditolak, pickup dibatalkan, dan bukti retur yang tidak memenuhi syarat.],
  ),
  caption: [Deskripsi Kebutuhan Nonfungsional],
)

== Batasan Perancangan
#paragraf[
  Perancangan harus mempertahankan persediaan terpisah per bengkel dan mencegah satu unit pending dipakai untuk dua transaksi. Estimasi dapat diubah hanya sebelum persetujuan Customer,  setelah ACC, tidak ada biaya tambahan yang dibebankan secara sepihak. Pembayaran servis dilakukan berdasarkan estimasi yang disetujui tanpa DP. Marketplace memakai stok bengkel yang sama, pembayaran online, dan pengiriman kurir pihak ketiga dengan resi manual. Pembayaran tunai hanya dicatat dari sisi mitra. Tarif, kompensasi, durasi suspend, dan sejumlah kebijakan teknis yang belum diputuskan tidak boleh diasumsikan sebagai nilai tetap.
]

== Ringkasan Kebutuhan
#paragraf[
  Ringkasan berikut merujuk pada baseline fungsional dan nonfungsional yang telah disetujui untuk Service Ride. Kebutuhan rinci, kondisi gagal, dan skenario penerimaan dijabarkan lebih lanjut pada dokumen analisis proyek dan DPPL.
]
=== Ringkasan Kebutuhan Fungsional
#figure(
  table(
    columns: (40%, 60%),

    table.header([SKPL-Id], [Keterangan]),
    [SKPL-FR-01], [Menyediakan registrasi, login, dan kontrol akses sesuai tujuh role.],
    [SKPL-FR-02], [Menerapkan pembatasan data mitra berdasarkan identitas bengkel atau cabang dan penugasan karyawan.],
    [SKPL-FR-03],
    [Mendukung data pelanggan offline sebagai akun draft yang dapat dikaitkan dengan registrasi berdasarkan email serta menyimpan status verifikasinya.],

    [SKPL-FR-04], [Menerima data bengkel dan unggahan legalitas NIB serta dokumen pendirian yang relevan.],
    [SKPL-FR-05], [Menyediakan pemeriksaan QR dokumen, pencatatan hasil pemeriksaan, dan persetujuan aktivasi bengkel.],
    [SKPL-FR-06], [Mendukung beberapa bengkel dalam satu Owner dengan izin cabang yang disimpan terpisah.],
    [SKPL-FR-07],
    [Mengelola karyawan mitra, penugasan satu cabang operasional per karyawan, dan pengaturan marketplace per cabang.],

    [SKPL-FR-08],
    [Memungkinkan Customer mencari bengkel berdasarkan rating, memilih layanan, kendaraan, jadwal, dan metode penyerahan kendaraan.],

    [SKPL-FR-09], [Menyediakan pembuatan, penjadwalan, dan pembaruan booking untuk pickup dan datang langsung.],
    [SKPL-FR-10], [Menyediakan pendaftaran antrean full offline dan pencatatan kendaraan pelanggan.],
    [SKPL-FR-11], [Menyimpan diagnosis teknis, komponen rusak, kebutuhan spare part, dan foto bukti kerusakan.],
    [SKPL-FR-12], [Menghasilkan dokumen estimasi dengan rincian biaya, komponen, waktu selesai, dan bukti foto.],
    [SKPL-FR-13], [Memungkinkan pembaruan dan penambahan estimasi hanya sebelum Customer memberikan persetujuan.],
    [SKPL-FR-14], [Menerima persetujuan atau penolakan Customer melalui aplikasi.],
    [SKPL-FR-15],
    [Mendukung pencatatan ACC melalui WhatsApp oleh Operations Administrator beserta screenshot dan pemeriksaan nomor kontak.],

    [SKPL-FR-16], [Mengunci komponen tagihan setelah ACC dan merekam jejak persetujuan.],
    [SKPL-FR-17],
    [Menyediakan pembagian pekerjaan kepada Mechanic, informasi tahap pengerjaan, dan riwayat perubahan status.],

    [SKPL-FR-18], [Menyediakan unggahan foto pada pemeriksaan, proses perbaikan, dan hasil pekerjaan.],
    [SKPL-FR-19],
    [Menampilkan timeline kepada Customer serta pemberitahuan keterlambatan beserta pembaruan informasinya.],

    [SKPL-FR-20], [Menghitung dan menampilkan biaya pickup PP sebelum Customer mengonfirmasi pembayaran.],
    [SKPL-FR-21], [Mendukung penugasan driver dan pemantauan status penjemputan serta pengantaran kendaraan.],
    [SKPL-FR-22], [Menerima posisi driver secara berkala dan menampilkan pembaruan lokasi kepada aktor yang berwenang.],
    [SKPL-FR-23],
    [Mendeteksi ketiadaan pembaruan lokasi selama ambang 5 sampai 10 menit, memberi notifikasi kepada admin, dan menampilkan lokasi terakhir tanpa peta aktif.],

    [SKPL-FR-24],
    [Mencatat pembatalan, status keberangkatan driver, refund saldo yang berlaku, dan sanksi pembatasan pickup Customer.],

    [SKPL-FR-25],
    [Menghitung pembatalan cabang setelah driver berangkat dan mendukung suspend jika jumlahnya lebih dari 10 dalam satu minggu.],

    [SKPL-FR-26], [Mengelola katalog spare part dan catatan unit fisik pada masing-masing bengkel.],
    [SKPL-FR-27], [Mengelola status tersedia dan pending serta mencegah penggunaan ulang unit yang telah dialokasikan.],
    [SKPL-FR-28],
    [Mencatat penggunaan spare part untuk servis yang disetujui, marketplace, dan penjualan offline pada persediaan bengkel yang sama.],

    [SKPL-FR-29], [Menampilkan produk dari bengkel yang marketplace-nya aktif dan memiliki stok tersedia.],
    [SKPL-FR-30], [Mendukung keranjang, checkout, pembuatan pesanan, dan pembayaran spare part.],
    [SKPL-FR-31], [Menyediakan pemenuhan pesanan dan input ekspedisi serta nomor resi secara manual.],
    [SKPL-FR-32], [Mendukung pembatalan sebelum paket dikirim beserta pengembalian dana sesuai kebijakan.],
    [SKPL-FR-33],
    [Menerima pengajuan retur paling lama satu hari setelah barang dikonfirmasi diterima, menyimpan bukti, dan menyediakan penilaian retur sebelum refund.],

    [SKPL-FR-34],
    [Menyediakan Dummy Payment berbasis QRIS Service Ride sebagai metode sementara sebelum integrasi Midtrans.],

    [SKPL-FR-35],
    [Menyimpan transaksi pickup sebelum keberangkatan dan transaksi servis berdasarkan estimasi yang telah di-ACC.],

    [SKPL-FR-36],
    [Menyediakan pencatatan transaksi tunai dari sisi mitra tanpa menampilkan opsi tersebut pada antarmuka Customer.],

    [SKPL-FR-37],
    [Mengelola saldo internal Customer untuk refund pickup dan mencatat transaksi pengembalian lain sesuai mekanismenya.],

    [SKPL-FR-38], [Menghasilkan dokumen estimasi sebelum ACC dan invoice final sebagai dokumen terpisah.],
    [SKPL-FR-39], [Menampilkan pendapatan mitra yang dibedakan menurut kanal tunai dan online.],
    [SKPL-FR-40],
    [Membuka review servis dan marketplace setelah transaksi selesai serta mengizinkan edit selama 24 jam.],

    [SKPL-FR-41],
    [Menyamarkan identitas Customer pada tampilan Owner dan mengizinkan Owner membalas review secara terbuka.],

    [SKPL-FR-42],
    [Menyediakan audit dan tindakan moderasi terhadap konten yang melanggar ketentuan beserta alasan dan jejak tindakan.],

    [SKPL-FR-43],
    [Menyediakan laporan keluhan terkait bengkel atau servis dengan bukti proses yang dapat ditinjau pihak berwenang.],

    [SKPL-FR-44], [Menyediakan akses Super Admin untuk memediasi sengketa berdasarkan data dan dokumentasi pekerjaan.],
    [SKPL-FR-45], [Menyediakan notifikasi aplikasi untuk status proses dan email ke alamat yang tersedia.],
    [SKPL-FR-46], [Mengelola master data dan promo tingkat platform.],
    [SKPL-FR-47],
    [Menyimpan jejak perubahan penting, termasuk verifikasi legalitas, status booking, ACC, pembayaran, pergerakan stok, pembatalan, review, dan tindakan moderasi.],
  ),
  caption: [Deskripsi Kebutuhan Fungsional],
)

=== Ringkasan Kebutuhan Fungsional
#figure(
  table(
    columns: (40%, 60%),

    table.header([SKPL-Id], [Keterangan]),
    [SKPL-NFR-01], [Karyawan hanya dapat membaca dan mengubah data bengkel yang sesuai dengan penugasannya.],
    [SKPL-NFR-02], [Transaksi paralel tidak boleh mengalokasikan unit stok yang sama lebih dari satu kali.],
    [SKPL-NFR-03], [Estimasi yang telah disetujui tidak boleh diubah tanpa jejak persetujuan baru.],
    [SKPL-NFR-04], [Perubahan penting harus menyimpan pelaku, waktu, dan tindakan untuk audit.],
    [SKPL-NFR-05], [Data identitas dan bukti hanya dapat dilihat oleh role yang berwenang.],
    [SKPL-NFR-06], [Tracking harus menggunakan pembaruan berkala dan menampilkan lokasi terakhir saat update terhenti.],
    [SKPL-NFR-07], [Pembayaran dan saldo harus dapat direkonsiliasi menggunakan riwayat transaksi.],
    [SKPL-NFR-08], [Bukti pemeriksaan dan pekerjaan harus tersedia untuk penelusuran komplain.],
    [SKPL-NFR-09], [Antarmuka harus dapat digunakan pada ukuran layar yang berbeda.],
    [SKPL-NFR-10], [Pengujian harus mencakup kondisi gagal pada pembayaran, estimasi, lokasi, stok, pickup, dan retur.],
  ),
  caption: [Deskripsi Kebutuhan Nonfungsional],
)

