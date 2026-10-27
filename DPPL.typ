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
        [#align(center + horizon)[*DPPL - IMPAL-01-02*]],
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

        [#align(center + horizon)[#text(size: 10.5pt)[*DPPL - IMPAL-01-02*]]],
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
    [#align(center + horizon)[#text(size: 10.5pt)[*DPPL - IMPAL-01-02 *]]],
  )

  #text(size: 14pt, weight: "bold")[
    SPESIFIKASI KEBUTUHAN PERANGKAT LUNAK (DPPL)
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
// izin boleh edit
#let paragraf(isi) = block(width: 100%, below: 0.55em)[#isi]

= PENDAHULUAN

== Tujuan Penulisan Dokumen

#paragraf[#text("Dokumen Deskripsi Perancangan Perangkat Lunak ini merinci rancangan Service Ride sebagai acuan pengembang, penguji, dan peninjau desain. Dokumen menghubungkan kebutuhan pada SKPL dengan arsitektur, aliran data, kelas, interaksi use case, proses teknis, dan struktur penyimpanan data.")]

== Lingkup Masalah

#paragraf[#text("Service Ride menghubungkan Customer dengan bengkel mitra untuk booking servis onsite dan pickup, pencatatan servis offline, pemeriksaan kendaraan, estimasi dan persetujuan biaya, pembayaran, pelacakan kendaraan, pembelian spare part, ulasan, serta penanganan keluhan. Bengkel mengelola staf, stok fisik, pesanan, dan pekerjaan dalam cakupan bengkel masing-masing.")]

== Definisi dan Istilah

#table(
  columns: (24%, 76%),
  stroke: 0.45pt,
  inset: 4pt,
  table.header(
    [*#text("Istilah")*],
    [*#text("Pengertian")*],
  ),
  [#text("DPPL")],
  [#text("Dokumen rancangan perangkat lunak yang menjabarkan realisasi kebutuhan SKPL.")],
  [#text("Booking")],
  [#text("Catatan permintaan atau antrean layanan servis.")],
  [#text("Stok held")],
  [#text("Unit spare part yang telah dialokasikan dan tidak dihitung sebagai stok available.")],
  [#text("Estimate")],
  [#text("Rincian biaya dan pekerjaan sebelum persetujuan Customer.")],
  [#text("Invoice final")],
  [#text("Dokumen tagihan setelah pekerjaan servis selesai dan pembayaran tercatat.")],
  [#text("Dummy QRIS")],
  [#text("Mekanisme pembayaran sementara milik Service Ride pada baseline.")],
  [#text("SSE")],
  [#text("Server-Sent Events untuk pembaruan status dan lokasi ke browser.")],
)

== Referensi

#paragraf[#text("Referensi utama adalah SKPL Service Ride, db_schema.sql, query.sql, serta 53 sumber diagram Mermaid dan hasil PNG di folder dppl. Struktur bab mengikuti contoh DPPL.docx yang disediakan. Nama service, repository, dan policy adalah rancangan implementasi; proyek lokal yang tersedia belum mencakup backend yang dapat dipakai untuk memverifikasi kelas aktual.")]

#pagebreak()

= PERANCANGAN GLOBAL

== Rencana Lingkungan Implementasi

#paragraf[#text("Antarmuka web menggunakan React, Vite, TypeScript, Tailwind CSS, dan shadcn/ui. Layanan backend dirancang menggunakan Golang, PostgreSQL dengan PostGIS, Redis untuk data sementara, dan sqlc untuk akses query. Browser berkomunikasi dengan backend melalui permintaan aplikasi; pembaruan lokasi Pickup Service dikirim melalui SSE. Pembayaran pada baseline memakai Dummy QRIS, sementara data ekspedisi dan resi dimasukkan manual oleh petugas gudang.")]

== Deskripsi Arsitektur Perangkat Lunak

#paragraf[#text("Rancangan dipisah menjadi modul akun dan bengkel, booking dan estimasi, inventori dan marketplace, pembayaran dan pickup, serta layanan pendukung. Setiap modul memiliki layanan aplikasi yang menjalankan aturan proses, repository untuk data persisten, dan policy atau adapter untuk aturan lintas modul. Pembatasan akses berlaku menurut role serta id bengkel, sehingga Owner yang memiliki beberapa bengkel tetap melihat dan mengubah data sesuai cakupannya.")]

#table(
  columns: (21%, 47%, 32%),
  stroke: 0.45pt,
  inset: 4pt,
  table.header(
    [*#text("Modul")*],
    [*#text("Tanggung jawab")*],
    [*#text("Data utama")*],
  ),
  [#text("Akun dan bengkel")],
  [#text("Autentikasi, verifikasi, legalitas bengkel, akses staf.")],
  [#text("user, workshop, workshop_document, workshop_user_management")],
  [#text("Booking dan servis")],
  [#text("Jadwal, penugasan, inspeksi, estimasi, persetujuan, progres.")],
  [#text("booking, booking_service, booking_product")],
  [#text("Inventori dan marketplace")],
  [#text("Katalog, unit stok, checkout, pengiriman, retur.")],
  [#text("product, product_stock, marketplace_transaction")],
  [#text("Pembayaran dan pickup")],
  [#text("Dummy QRIS, kas, refund, invoice, lokasi perjalanan.")],
  [#text("payment, booking_pickup, booking_pickup_history")],
  [#text("Layanan pendukung")],
  [#text("Ulasan, laporan, keluhan, notifikasi, audit.")],
  [#text("review; tabel lain masih perlu dirancang")],
)

#pagebreak(weak: true)

== Diagram Aliran Data

#paragraf[#text("Diagram konteks memperlihatkan pertukaran data antara Service Ride dan Customer, petugas bengkel, Super Admin, layanan email, serta ekspedisi pihak ketiga. Nomor resi dimasukkan oleh Warehouse Administrator; tidak ada integrasi API ekspedisi pada baseline.")]

#figure(
  image("dppl/hasil/DFD/00-diagram-konteks.png", width: 100%, height: 13cm, fit: "contain"),
  caption: [#text("Diagram konteks Service Ride")],
)

#pagebreak(weak: true)

#paragraf[#text("Level 0 memecah sistem menjadi enam proses utama dan menunjukkan penyimpanan data yang digunakan. Aliran tagihan dari booking dan marketplace masuk ke pembayaran, sedangkan perubahan status transaksi dapat memicu notifikasi.")]

#figure(
  image("dppl/hasil/DFD/01-level-0.png", width: 100%, height: 13cm, fit: "contain"),
  caption: [#text("DFD level 0 Service Ride")],
)

#pagebreak(weak: true)

#paragraf[#text("Dekomposisi booking menempatkan validasi jadwal, konfirmasi, inspeksi, persetujuan, serta penyelesaian sebagai proses terpisah. Pengecekan stok pada estimasi tidak mengalokasikan unit; alokasi terjadi sesudah persetujuan.")]

#figure(
  image("dppl/hasil/DFD/02-level-1-booking-servis.png", width: 100%, height: 13cm, fit: "contain"),
  caption: [#text("DFD level 1 booking dan servis")],
)

#pagebreak(weak: true)

#paragraf[#text("Dekomposisi inventori menunjukkan satu sumber stok fisik untuk katalog, servis, penjualan offline, dan marketplace. Pembatalan melepas alokasi, sementara retur membutuhkan keputusan sebelum refund.")]

#figure(
  image("dppl/hasil/DFD/03-level-1-inventori-marketplace.png", width: 100%, height: 13cm, fit: "contain"),
  caption: [#text("DFD level 1 inventori dan marketplace")],
)

#pagebreak(weak: true)

#paragraf[#text("Dekomposisi pembayaran membedakan pembuatan tagihan, kanal Dummy QRIS atau kas, konfirmasi, refund, dan penerbitan invoice final. Satu payment terkait tepat satu booking atau pesanan marketplace.")]

#figure(
  image("dppl/hasil/DFD/04-level-1-pembayaran.png", width: 100%, height: 13cm, fit: "contain"),
  caption: [#text("DFD level 1 pembayaran")],
)

#pagebreak(weak: true)

== Rancangan Data Global

#paragraf[#text("ERD berikut diturunkan langsung dari db_schema.sql. Skema fisik saat ini memuat 19 tabel dan 38 foreign key, termasuk relasi akun, bengkel, kendaraan, booking, stok per unit, pesanan marketplace, pembayaran, pickup, dan ulasan. Kolom estimate_document_url dan invoice_url berada pada booking; keduanya bukan tabel tersendiri.")]

#figure(
  image("dppl/hasil/ERD/01-skema-fisik.png", width: 100%, height: 17cm, fit: "contain"),
  caption: [#text("ERD fisik Service Ride")],
)

#paragraf[#text("Constraint komposit pada SQL asli tetap menjadi sumber aturan keunikan dan alokasi. Keluhan, notifikasi, promosi, serta audit telah muncul dalam kebutuhan dan rancangan layanan, tetapi belum memiliki tabel khusus; implementasi penuhnya memerlukan migrasi skema.")]

#pagebreak()

= PERANCANGAN RINCI

== Realisasi Use Case

#paragraf[#text("Bagian ini mengikuti 34 skenario utama pada SKPL. Setiap diagram sekuens menunjukkan aktor, antarmuka browser, layanan aplikasi, repository, dan kolaborator teknis yang relevan. Penjelasan di bawah diagram menyoroti aturan yang menentukan keberhasilan atau jalur alternatif. Rancangan layar rinci tidak ditetapkan karena prototipe antarmuka tidak disediakan sebagai masukan DPPL ini.")]

=== Use Case 1: Login

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-01. AuthService membaca akun berdasarkan email, memeriksa hash kata sandi, status aktif, verifikasi, dan role sebelum membuka sesi. Akses yang gagal dikembalikan dengan alasan yang aman bagi pengguna.")]

#figure(
  image("dppl/hasil/Sequence Diagram/01-login.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 1: Login")],
)

#pagebreak(weak: true)

=== Use Case 2: Registrasi akun Customer

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-01. AuthService memastikan email unik dan data minimum terisi, menyimpan akun belum terverifikasi, lalu mengirim kode sekali pakai. Kode verifikasi memerlukan penyimpanan sementara dengan masa berlaku.")]

#figure(
  image("dppl/hasil/Sequence Diagram/02-registrasi-akun.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 2: Registrasi akun Customer")],
)

#pagebreak(weak: true)

=== Use Case 3: Verifikasi akun

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-01. Kode yang dikirim Customer dicocokkan dengan akun dan masa berlakunya. Setelah valid, status verifikasi akun diperbarui dan kode tidak dapat digunakan ulang.")]

#figure(
  image("dppl/hasil/Sequence Diagram/03-verifikasi-akun.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 3: Verifikasi akun")],
)

#pagebreak(weak: true)

=== Use Case 4: Registrasi bengkel

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-04. WorkshopService menerima profil bengkel dan dokumen legalitas dari Owner, memvalidasi kelengkapan, lalu menyimpan pengajuan berstatus pending untuk ditinjau Super Admin.")]

#figure(
  image("dppl/hasil/Sequence Diagram/04-registrasi-bengkel.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 4: Registrasi bengkel")],
)

#pagebreak(weak: true)

=== Use Case 5: Verifikasi bengkel

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-05. Super Admin meninjau data dan dokumen bengkel. Keputusan, peninjau, alasan penolakan, dan waktu dicatat sebelum status aktivasi dan notifikasi Owner diperbarui.")]

#figure(
  image("dppl/hasil/Sequence Diagram/05-verifikasi-bengkel.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 5: Verifikasi bengkel")],
)

#pagebreak(weak: true)

=== Use Case 6: Pengelolaan akses karyawan dan cabang

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-02, SKPL-FR-06, SKPL-FR-07. WorkshopService membatasi perubahan ke bengkel milik Owner. Keanggotaan staf menyimpan satu role per penugasan dan dapat dinonaktifkan tanpa menghapus riwayat.")]

#figure(
  image("dppl/hasil/Sequence Diagram/06-employee-management.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 6: Pengelolaan akses karyawan dan cabang")],
)

#pagebreak(weak: true)

=== Use Case 7: Pengelolaan katalog spare part

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-26. CatalogService memeriksa cakupan bengkel, kategori, harga, dan keunikan SKU per bengkel sebelum menyimpan atau menonaktifkan produk.")]

#figure(
  image("dppl/hasil/Sequence Diagram/07-product-management.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 7: Pengelolaan katalog spare part")],
)

#pagebreak(weak: true)

=== Use Case 8: Pengelolaan persediaan bengkel

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-26, SKPL-FR-27, SKPL-FR-28. InventoryService mengelola stok pada tingkat unit fisik. Koreksi hanya boleh menyentuh unit pada bengkel terkait dan tidak boleh mengubah unit yang sedang dialokasikan tanpa proses pelepasan.")]

#figure(
  image("dppl/hasil/Sequence Diagram/08-manage-inventory.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 8: Pengelolaan persediaan bengkel")],
)

#pagebreak(weak: true)

=== Use Case 9: Penjualan spare part offline

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-28, SKPL-FR-36. Penjualan tunai mengambil unit dengan status available pada bengkel yang sama, mengubahnya menjadi sold_offline, lalu mencatat penerimaan tunai melalui PaymentService.")]

#figure(
  image("dppl/hasil/Sequence Diagram/09-order-product-onsite.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 9: Penjualan spare part offline")],
)

#pagebreak(weak: true)

=== Use Case 10: Pemesanan spare part marketplace

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-29, SKPL-FR-30, SKPL-FR-34, SKPL-FR-35. MarketplaceService memeriksa listing dan bengkel aktif, menahan unit stok secara atomik, membuat transaksi pending_payment, dan mengubahnya menjadi processing setelah Dummy QRIS berhasil. Jika pembayaran gagal, alokasi dilepas.")]

#figure(
  image("dppl/hasil/Sequence Diagram/10-order-product-on-marketplace.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 10: Pemesanan spare part marketplace")],
)

#pagebreak(weak: true)

=== Use Case 11: Pemenuhan pesanan marketplace

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-31. Warehouse Administrator menyiapkan order yang sudah dibayar. Nomor resi dan ekspedisi dimasukkan manual; unit held baru dinyatakan sold_marketplace saat pemenuhan sesuai status pesanan.")]

#figure(
  image("dppl/hasil/Sequence Diagram/11-confirm-order.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 11: Pemenuhan pesanan marketplace")],
)

#pagebreak(weak: true)

=== Use Case 12: Pembatalan pesanan marketplace

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-32. Pembatalan hanya diterima sebelum paket diserahkan kepada ekspedisi. MarketplaceService membatalkan rincian, melepas unit held, dan memulai refund bila pembayaran telah diterima.")]

#figure(
  image("dppl/hasil/Sequence Diagram/12-cancel-order.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 12: Pembatalan pesanan marketplace")],
)

#pagebreak(weak: true)

=== Use Case 13: Pengelolaan kendaraan Customer

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-08. VehicleService memastikan Customer hanya dapat mengubah kendaraan miliknya serta menjaga keunikan nomor polisi pada akun yang sama.")]

#figure(
  image("dppl/hasil/Sequence Diagram/13-manage-vehicle.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 13: Pengelolaan kendaraan Customer")],
)

#pagebreak(weak: true)

=== Use Case 14: Booking servis onsite

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-08, SKPL-FR-09. BookingService memeriksa kepemilikan kendaraan, status bengkel, layanan, dan kapasitas jadwal sebelum membuat permintaan booking online_visit.")]

#figure(
  image("dppl/hasil/Sequence Diagram/14-booking-service-onsite.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 14: Booking servis onsite")],
)

#pagebreak(weak: true)

=== Use Case 15: Booking servis pickup

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-08, SKPL-FR-09, SKPL-FR-20, SKPL-FR-35. Booking pickup menambahkan pemeriksaan cakupan alamat berbasis PostGIS dan biaya pickup. Permintaan baru diteruskan untuk konfirmasi bengkel setelah pembayaran pickup berhasil.")]

#figure(
  image("dppl/hasil/Sequence Diagram/15-booking-service-pickup.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 15: Booking servis pickup")],
)

#pagebreak(weak: true)

=== Use Case 16: Konfirmasi booking

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-09. Operations Administrator meninjau permintaan dan kapasitas aktual. Booking yang diterima diberi slot serta nomor antrean; penolakan menyimpan alasan dan diberitahukan kepada Customer.")]

#figure(
  image("dppl/hasil/Sequence Diagram/16-confirm-booking.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 16: Konfirmasi booking")],
)

#pagebreak(weak: true)

=== Use Case 17: Pembatalan booking

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-24, SKPL-FR-25. Pembatalan mengunci booking dan membaca status keberangkatan driver. Aturan refund serta tindak lanjut dibedakan menurut pihak pembatal dan tahap perjalanan.")]

#figure(
  image("dppl/hasil/Sequence Diagram/17-cancel-booking.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 17: Pembatalan booking")],
)

#pagebreak(weak: true)

=== Use Case 18: Pemantauan status pesanan dan booking

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-19, SKPL-FR-21, SKPL-FR-22, SKPL-FR-23, SKPL-FR-45. StatusQueryService membatasi hasil pada transaksi milik Customer dan menggabungkan timeline booking, pesanan, serta lokasi terakhir yang diketahui dari tugas pickup.")]

#figure(
  image("dppl/hasil/Sequence Diagram/18-view-order-and-booking-status.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 18: Pemantauan status pesanan dan booking")],
)

#pagebreak(weak: true)

=== Use Case 19: Penugasan mekanik

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-17. Penugasan mekanik memeriksa role, bengkel, keterampilan, dan benturan jadwal sebelum menyimpan id mekanik pada pekerjaan servis.")]

#figure(
  image("dppl/hasil/Sequence Diagram/19-assign-technician.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 19: Penugasan mekanik")],
)

#pagebreak(weak: true)

=== Use Case 20: Pemeriksaan kendaraan dan estimasi biaya

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-11, SKPL-FR-12, SKPL-FR-13, SKPL-FR-18, SKPL-FR-38. Mechanic mencatat diagnosis, kebutuhan komponen, harga tenaga kerja, dan foto. EstimateService memeriksa stok available pada bengkel yang sama tanpa mengalokasikannya pada tahap estimasi.")]

#figure(
  image("dppl/hasil/Sequence Diagram/20-vehicle-inspection-and-cost-estimation.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 20: Pemeriksaan kendaraan dan estimasi biaya")],
)

#pagebreak(weak: true)

=== Use Case 21: Persetujuan estimasi biaya

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-14, SKPL-FR-15, SKPL-FR-16. Keputusan Customer atau bukti persetujuan luar aplikasi dicatat bersama kanalnya. Stok diperiksa ulang dan unit ditahan secara atomik; pekerjaan tetap terblokir sampai pembayaran servis tercatat.")]

#figure(
  image("dppl/hasil/Sequence Diagram/21-confirm-estimated-cost.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 21: Persetujuan estimasi biaya")],
)

#pagebreak(weak: true)

=== Use Case 22: Penyelesaian servis

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-17, SKPL-FR-18, SKPL-FR-19. Mechanic melengkapi hasil dan pemeriksaan akhir. ServiceWorkService menandai pekerjaan selesai serta mengubah unit komponen yang digunakan dari held menjadi used_service.")]

#figure(
  image("dppl/hasil/Sequence Diagram/22-confirm-service-completion.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 22: Penyelesaian servis")],
)

#pagebreak(weak: true)

=== Use Case 23: Penjemputan kendaraan

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-20, SKPL-FR-21, SKPL-FR-22, SKPL-FR-23. PickupService memeriksa penugasan driver dan pembayaran biaya pickup, menyimpan titik lokasi serta perubahan status, lalu menyiarkannya melalui SSE.")]

#figure(
  image("dppl/hasil/Sequence Diagram/23-pickup-vehicle-for-service.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 23: Penjemputan kendaraan")],
)

#pagebreak(weak: true)

=== Use Case 24: Pengantaran kendaraan

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-21, SKPL-FR-22, SKPL-FR-23. Pengantaran hanya dapat dimulai setelah servis selesai. Bukti serah terima dan waktu penyelesaian dicatat pada tugas delivery dan riwayat pickup.")]

#figure(
  image("dppl/hasil/Sequence Diagram/24-return-vehicle-after-service.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 24: Pengantaran kendaraan")],
)

#pagebreak(weak: true)

=== Use Case 25: Pembayaran

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-34, SKPL-FR-35, SKPL-FR-36, SKPL-FR-37. PaymentService menghubungkan pembayaran dengan tepat satu sumber transaksi. Dummy QRIS menghasilkan status pending atau paid, sedangkan uang tunai dicatat oleh Operations Administrator.")]

#figure(
  image("dppl/hasil/Sequence Diagram/25-payment.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 25: Pembayaran")],
)

#pagebreak(weak: true)

=== Use Case 26: Konfirmasi pembayaran

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-34, SKPL-FR-47. Super Admin meninjau pembayaran yang memerlukan pemeriksaan manual. Keputusan dan referensi dicatat melalui PaymentService serta jejak audit sebelum status diperbarui.")]

#figure(
  image("dppl/hasil/Sequence Diagram/26-confirm-payment.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 26: Konfirmasi pembayaran")],
)

#pagebreak(weak: true)

=== Use Case 27: Penerbitan invoice final

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-38. InvoiceService memeriksa servis selesai, estimasi disetujui, dan pembayaran tercatat. Dokumen final diterbitkan secara terpisah dari berkas estimasi.")]

#figure(
  image("dppl/hasil/Sequence Diagram/27-generate-invoice.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 27: Penerbitan invoice final")],
)

#pagebreak(weak: true)

=== Use Case 28: Pencatatan servis full offline

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-03, SKPL-FR-10, SKPL-FR-15, SKPL-FR-36. Operations Administrator mencatat kontak, kendaraan, keluhan, dan antrean. Akun draft dapat dibuat atau dihubungkan tanpa mewajibkan NIK.")]

#figure(
  image("dppl/hasil/Sequence Diagram/28-register-full-offline-service.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 28: Pencatatan servis full offline")],
)

#pagebreak(weak: true)

=== Use Case 29: Retur marketplace

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-33. Permintaan retur diperiksa terhadap waktu penerimaan paling lama satu hari dan bukti. Warehouse Administrator memutuskan permintaan; refund hanya diproses sesudah retur disetujui.")]

#figure(
  image("dppl/hasil/Sequence Diagram/29-marketplace-return.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 29: Retur marketplace")],
)

#pagebreak(weak: true)

=== Use Case 30: Ulasan transaksi selesai

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-40, SKPL-FR-41. ReviewService menerima ulasan hanya dari transaksi selesai, membatasi perubahan selama 24 jam, dan menampilkan identitas Customer secara anonim kepada Owner.")]

#figure(
  image("dppl/hasil/Sequence Diagram/30-review-completed-transaction.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 30: Ulasan transaksi selesai")],
)

#pagebreak(weak: true)

=== Use Case 31: Penanganan keluhan dan laporan konten

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-42, SKPL-FR-43, SKPL-FR-44, SKPL-FR-47. ComplaintService menghubungkan bukti dan riwayat transaksi, mencatat tindakan bengkel atau Super Admin beserta alasan, dan mengirim hasil kepada pihak terkait. Penyimpanan kasus serta audit masih perlu migrasi skema.")]

#figure(
  image("dppl/hasil/Sequence Diagram/31-handle-complaint.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 31: Penanganan keluhan dan laporan konten")],
)

#pagebreak(weak: true)

=== Use Case 32: Laporan pendapatan bengkel

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-39. RevenueReportService menghitung transaksi paid dalam cakupan bengkel milik Owner dan memisahkan penerimaan tunai dari kanal online untuk periode yang dipilih.")]

#figure(
  image("dppl/hasil/Sequence Diagram/32-workshop-revenue-report.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 32: Laporan pendapatan bengkel")],
)

#pagebreak(weak: true)

=== Use Case 33: Pengelolaan data platform dan promosi

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-46. Super Admin mengubah data induk atau promosi setelah validasi dan pencatatan audit. Penyimpanan promosi khusus belum terdapat dalam skema fisik saat ini.")]

#figure(
  image("dppl/hasil/Sequence Diagram/33-platform-data-and-promotion-management.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 33: Pengelolaan data platform dan promosi")],
)

#pagebreak(weak: true)

=== Use Case 34: Notifikasi perubahan status

#paragraf[#text("Keterkaitan kebutuhan: SKPL-FR-45. NotificationService menentukan penerima menurut role, kepemilikan transaksi, dan cakupan bengkel. Notifikasi aplikasi dibuat untuk penerima berwenang; email dikirim bila alamat tersedia.")]

#figure(
  image("dppl/hasil/Sequence Diagram/34-status-notifications.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Diagram sekuens 34: Notifikasi perubahan status")],
)

#pagebreak(weak: true)

== Diagram Kelas Keseluruhan

#paragraf[#text("Lima diagram kelas berikut memecah rancangan menurut modul agar atribut, operasi, relasi, dan tanggung jawab tetap terbaca. Kelas entity dipetakan ke tabel fisik bila tersedia, sedangkan service, repository, policy, dan adapter mewakili komponen implementasi yang direncanakan.")]

#paragraf[#text("User, Address, Vehicle, Workshop, WorkshopDocument, dan WorkshopMembership menyimpan identitas serta cakupan akses. AuthService menangani registrasi dan login; WorkshopService menangani pengajuan legalitas serta keanggotaan staf.")]

#figure(
  image("dppl/hasil/Class Diagram/01-akun-dan-bengkel.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Kelas akun dan bengkel")],
)

#pagebreak(weak: true)

#paragraf[#text("Booking menjadi pusat status layanan dan memiliki rincian pekerjaan serta komponen. BookingService mengatur jadwal, sedangkan EstimateService menyusun estimasi, mencatat keputusan, memeriksa ulang stok, dan menunggu pembayaran sebelum pekerjaan dimulai.")]

#figure(
  image("dppl/hasil/Class Diagram/02-booking-dan-estimasi.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Kelas booking dan estimasi")],
)

#pagebreak(weak: true)

#paragraf[#text("ProductStock merepresentasikan unit fisik dengan status available, held, dan hasil pemakaian atau penjualan. InventoryService melakukan penguncian dan alokasi; MarketplaceService mengoordinasikan order, pembayaran, pengiriman, pembatalan, serta retur.")]

#figure(
  image("dppl/hasil/Class Diagram/03-inventori-dan-marketplace.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Kelas inventori dan marketplace")],
)

#pagebreak(weak: true)

#paragraf[#text("PaymentService membatasi satu sumber transaksi dan mengelola QRIS, kas, serta refund. PickupService menyimpan tugas dan riwayat lokasi; LocationStream menyiarkan pembaruan ke browser. InvoiceService menerbitkan dokumen final.")]

#figure(
  image("dppl/hasil/Class Diagram/04-pembayaran-dan-pickup.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Kelas pembayaran dan pickup")],
)

#pagebreak(weak: true)

#paragraf[#text("ReviewService mengatur ulasan dan balasan, sedangkan ComplaintService, NotificationService, PlatformAdminService, dan RevenueReportService melayani proses pendukung. Persistensi keluhan, notifikasi, promosi, dan audit masih berupa rancangan karena tabelnya belum ada.")]

#figure(
  image("dppl/hasil/Class Diagram/05-ulasan-dan-layanan-pendukung.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Kelas ulasan dan layanan pendukung")],
)

#pagebreak(weak: true)

== Perancangan Detil Kelas

#paragraf[#text("Atribut pada entity mengikuti kolom penting skema fisik, dengan UUID sebagai pengenal dan enumerasi untuk status. Operasi pada service memisahkan orkestrasi proses dari akses data. Repository dibatasi sebagai antarmuka agar transaksi dan penguncian unit dapat diuji. AccessPolicy serta policy jadwal dan cakupan menangani validasi yang dipakai beberapa layanan.")]

#table(
  columns: (27%, 38%, 35%),
  stroke: 0.45pt,
  inset: 4pt,
  table.header(
    [*#text("Kelas atau kelompok")*],
    [*#text("Operasi kunci")*],
    [*#text("Aturan dan tanggung jawab")*],
  ),
  [#text("AuthService dan WorkshopService")],
  [#text("registerCustomer, login, reviewDocuments, assignStaff")],
  [#text("Validasi akun, legalitas, role, dan cakupan bengkel.")],
  [#text("BookingService dan EstimateService")],
  [#text("createOnsite, createPickup, confirm, prepare, approve")],
  [#text("Transisi booking, kapasitas, estimasi, bukti approval, dan alokasi setelah pemeriksaan ulang.")],
  [#text("InventoryService dan MarketplaceService")],
  [#text("holdUnits, releaseUnits, checkout, fulfill, requestReturn")],
  [#text("Konsistensi unit stok, order, pengiriman, pembatalan, dan retur.")],
  [#text("PaymentService, PickupService, InvoiceService")],
  [#text("confirm, refund, updateLocation, issueFinalInvoice")],
  [#text("Pembayaran terkait satu sumber, lokasi pickup, serta invoice final terpisah.")],
  [#text("ReviewService dan layanan pendukung")],
  [#text("create, edit, openCase, publish, summarize")],
  [#text("Ulasan, keluhan, notifikasi, audit, dan laporan sesuai role.")],
)

#pagebreak(weak: true)

== Perancangan Algoritma dan Query

#paragraf[#text("Activity diagram berikut merinci proses yang mempunyai keputusan, transaksi data, atau serah terima antarperan. Bentuk swimlane menunjukkan pemilik tiap langkah; implementasi harus menjaga validasi status dan cakupan bengkel sebelum perubahan data.")]

#paragraf[#text("InventoryService mengunci unit available dalam transaksi dan menahan tepat sejumlah unit yang diperlukan. Jika jumlah kurang, transaksi dibatalkan sehingga servis dan marketplace tidak mengalokasikan unit yang sama.")]

#figure(
  image("dppl/hasil/Activity Diagram/01-alokasi-stok-bersama.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Alokasi stok bersama")],
)

#pagebreak(weak: true)

#paragraf[#text("Persetujuan harus terkait versi estimasi dan bukti yang sah. Setelah stok diperiksa ulang, unit menjadi held; pekerjaan hanya boleh berjalan setelah pembayaran servis tercatat.")]

#figure(
  image("dppl/hasil/Activity Diagram/02-persetujuan-estimasi.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Persetujuan estimasi")],
)

#pagebreak(weak: true)

#paragraf[#text("Produk, bengkel, dan jumlah diperiksa sebelum order pending_payment dibuat. Pembayaran berhasil mengubah status menjadi processing; kegagalan atau kedaluwarsa melepas unit held.")]

#figure(
  image("dppl/hasil/Activity Diagram/03-checkout-marketplace.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Checkout marketplace")],
)

#pagebreak(weak: true)

#paragraf[#text("Cakupan geografis, biaya pickup, dan kapasitas jadwal dihitung sebelum booking diteruskan ke petugas bengkel. Konfirmasi dilakukan setelah biaya pickup berhasil dibayar.")]

#figure(
  image("dppl/hasil/Activity Diagram/04-booking-pickup-dan-pembatalan.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Pembuatan booking pickup")],
)

#pagebreak(weak: true)

#paragraf[#text("Booking dikunci sebelum status dan keberangkatan driver dibaca. Konsekuensi refund serta eskalasi ke Super Admin mengikuti pihak yang membatalkan dan tahap perjalanan.")]

#figure(
  image("dppl/hasil/Activity Diagram/05-validasi-pembatalan-booking.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Validasi pembatalan booking")],
)

#pagebreak(weak: true)

#paragraf[#text("Titik lokasi dari driver yang ditugaskan disimpan pada riwayat PostGIS dan dikirim melalui SSE. Ketika pembaruan terhenti, antarmuka tetap menampilkan lokasi terakhir beserta peringatan.")]

#figure(
  image("dppl/hasil/Activity Diagram/06-pelacakan-pickup.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Pelacakan pickup")],
)

#pagebreak(weak: true)

#paragraf[#text("Sistem memeriksa tenggat satu hari, bukti, dan status item. Warehouse Administrator mengambil keputusan; refund baru dimulai bila retur disetujui.")]

#figure(
  image("dppl/hasil/Activity Diagram/07-retur-marketplace.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Retur marketplace")],
)

#pagebreak(weak: true)

#paragraf[#text("InvoiceService mengambil rincian servis, estimasi yang disetujui, dan pembayaran. Invoice final diterbitkan hanya setelah servis selesai dan disimpan terpisah dari dokumen estimasi.")]

#figure(
  image("dppl/hasil/Activity Diagram/08-invoice-final.png", width: 100%, height: 14cm, fit: "contain"),
  caption: [#text("Penerbitan invoice final")],
)

#pagebreak()

= MATRIKS KERUNUTAN

#paragraf[#text("Matriks berikut menghubungkan nomor kebutuhan SKPL dengan skenario yang direalisasikan dan diagram sekuensnya. Diagram kelas, DFD, ERD, dan aktivitas pada bab sebelumnya menjelaskan struktur dan proses yang digunakan oleh skenario tersebut.")]

== Use Case 1 sampai 9

#table(
  columns: (7%, 33%, 26%, 34%),
  stroke: 0.45pt,
  inset: 4pt,
  table.header(
    [*#text("No.")*],
    [*#text("Use Case")*],
    [*#text("Kebutuhan SKPL")*],
    [*#text("Diagram sekuens")*],
  ),
  [#text("1")],
  [#text("Login")],
  [#text("SKPL-FR-01")],
  [#text("01-login")],
  [#text("2")],
  [#text("Registrasi akun Customer")],
  [#text("SKPL-FR-01")],
  [#text("02-registrasi-akun")],
  [#text("3")],
  [#text("Verifikasi akun")],
  [#text("SKPL-FR-01")],
  [#text("03-verifikasi-akun")],
  [#text("4")],
  [#text("Registrasi bengkel")],
  [#text("SKPL-FR-04")],
  [#text("04-registrasi-bengkel")],
  [#text("5")],
  [#text("Verifikasi bengkel")],
  [#text("SKPL-FR-05")],
  [#text("05-verifikasi-bengkel")],
  [#text("6")],
  [#text("Pengelolaan akses karyawan dan cabang")],
  [#text("SKPL-FR-02, SKPL-FR-06, SKPL-FR-07")],
  [#text("06-employee-management")],
  [#text("7")],
  [#text("Pengelolaan katalog spare part")],
  [#text("SKPL-FR-26")],
  [#text("07-product-management")],
  [#text("8")],
  [#text("Pengelolaan persediaan bengkel")],
  [#text("SKPL-FR-26, SKPL-FR-27, SKPL-FR-28")],
  [#text("08-manage-inventory")],
  [#text("9")],
  [#text("Penjualan spare part offline")],
  [#text("SKPL-FR-28, SKPL-FR-36")],
  [#text("09-order-product-onsite")],
)

== Use Case 10 sampai 18

#table(
  columns: (7%, 33%, 26%, 34%),
  stroke: 0.45pt,
  inset: 4pt,
  table.header(
    [*#text("No.")*],
    [*#text("Use Case")*],
    [*#text("Kebutuhan SKPL")*],
    [*#text("Diagram sekuens")*],
  ),
  [#text("10")],
  [#text("Pemesanan spare part marketplace")],
  [#text("SKPL-FR-29, SKPL-FR-30, SKPL-FR-34, SKPL-FR-35")],
  [#text("10-order-product-on-marketplace")],
  [#text("11")],
  [#text("Pemenuhan pesanan marketplace")],
  [#text("SKPL-FR-31")],
  [#text("11-confirm-order")],
  [#text("12")],
  [#text("Pembatalan pesanan marketplace")],
  [#text("SKPL-FR-32")],
  [#text("12-cancel-order")],
  [#text("13")],
  [#text("Pengelolaan kendaraan Customer")],
  [#text("SKPL-FR-08")],
  [#text("13-manage-vehicle")],
  [#text("14")],
  [#text("Booking servis onsite")],
  [#text("SKPL-FR-08, SKPL-FR-09")],
  [#text("14-booking-service-onsite")],
  [#text("15")],
  [#text("Booking servis pickup")],
  [#text("SKPL-FR-08, SKPL-FR-09, SKPL-FR-20, SKPL-FR-35")],
  [#text("15-booking-service-pickup")],
  [#text("16")],
  [#text("Konfirmasi booking")],
  [#text("SKPL-FR-09")],
  [#text("16-confirm-booking")],
  [#text("17")],
  [#text("Pembatalan booking")],
  [#text("SKPL-FR-24, SKPL-FR-25")],
  [#text("17-cancel-booking")],
  [#text("18")],
  [#text("Pemantauan status pesanan dan booking")],
  [#text("SKPL-FR-19, SKPL-FR-21, SKPL-FR-22, SKPL-FR-23, SKPL-FR-45")],
  [#text("18-view-order-and-booking-status")],
)

== Use Case 19 sampai 26

#table(
  columns: (7%, 33%, 26%, 34%),
  stroke: 0.45pt,
  inset: 4pt,
  table.header(
    [*#text("No.")*],
    [*#text("Use Case")*],
    [*#text("Kebutuhan SKPL")*],
    [*#text("Diagram sekuens")*],
  ),
  [#text("19")],
  [#text("Penugasan mekanik")],
  [#text("SKPL-FR-17")],
  [#text("19-assign-technician")],
  [#text("20")],
  [#text("Pemeriksaan kendaraan dan estimasi biaya")],
  [#text("SKPL-FR-11, SKPL-FR-12, SKPL-FR-13, SKPL-FR-18, SKPL-FR-38")],
  [#text("20-vehicle-inspection-and-cost-estimation")],
  [#text("21")],
  [#text("Persetujuan estimasi biaya")],
  [#text("SKPL-FR-14, SKPL-FR-15, SKPL-FR-16")],
  [#text("21-confirm-estimated-cost")],
  [#text("22")],
  [#text("Penyelesaian servis")],
  [#text("SKPL-FR-17, SKPL-FR-18, SKPL-FR-19")],
  [#text("22-confirm-service-completion")],
  [#text("23")],
  [#text("Penjemputan kendaraan")],
  [#text("SKPL-FR-20, SKPL-FR-21, SKPL-FR-22, SKPL-FR-23")],
  [#text("23-pickup-vehicle-for-service")],
  [#text("24")],
  [#text("Pengantaran kendaraan")],
  [#text("SKPL-FR-21, SKPL-FR-22, SKPL-FR-23")],
  [#text("24-return-vehicle-after-service")],
  [#text("25")],
  [#text("Pembayaran")],
  [#text("SKPL-FR-34, SKPL-FR-35, SKPL-FR-36, SKPL-FR-37")],
  [#text("25-payment")],
  [#text("26")],
  [#text("Konfirmasi pembayaran")],
  [#text("SKPL-FR-34, SKPL-FR-47")],
  [#text("26-confirm-payment")],
)

== Use Case 27 sampai 34

#table(
  columns: (7%, 33%, 26%, 34%),
  stroke: 0.45pt,
  inset: 4pt,
  table.header(
    [*#text("No.")*],
    [*#text("Use Case")*],
    [*#text("Kebutuhan SKPL")*],
    [*#text("Diagram sekuens")*],
  ),
  [#text("27")],
  [#text("Penerbitan invoice final")],
  [#text("SKPL-FR-38")],
  [#text("27-generate-invoice")],
  [#text("28")],
  [#text("Pencatatan servis full offline")],
  [#text("SKPL-FR-03, SKPL-FR-10, SKPL-FR-15, SKPL-FR-36")],
  [#text("28-register-full-offline-service")],
  [#text("29")],
  [#text("Retur marketplace")],
  [#text("SKPL-FR-33")],
  [#text("29-marketplace-return")],
  [#text("30")],
  [#text("Ulasan transaksi selesai")],
  [#text("SKPL-FR-40, SKPL-FR-41")],
  [#text("30-review-completed-transaction")],
  [#text("31")],
  [#text("Penanganan keluhan dan laporan konten")],
  [#text("SKPL-FR-42, SKPL-FR-43, SKPL-FR-44, SKPL-FR-47")],
  [#text("31-handle-complaint")],
  [#text("32")],
  [#text("Laporan pendapatan bengkel")],
  [#text("SKPL-FR-39")],
  [#text("32-workshop-revenue-report")],
  [#text("33")],
  [#text("Pengelolaan data platform dan promosi")],
  [#text("SKPL-FR-46")],
  [#text("33-platform-data-and-promotion-management")],
  [#text("34")],
  [#text("Notifikasi perubahan status")],
  [#text("SKPL-FR-45")],
  [#text("34-status-notifications")],
)

