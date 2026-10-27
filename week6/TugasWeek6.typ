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
        [#align(center + horizon)[*Tugas Week 6 - IMPAL-01-02*]],
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
          #image("../logo/Tel-U.Vertical.png", width: 18mm)
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

        [#align(center + horizon)[#text(size: 10.5pt)[*Tugas Week 6 - IMPAL-01-02*]]],
        [#align(center + horizon)[#text(size: 10.5pt)[Total #str(total)]]],

        [#align(center + horizon)[#text(size: 10.5pt)[*Revisi:* 01]]],
        [#align(center + horizon)[#text(size: 10.5pt)[*Tgl:* 27 Oktober 2026]]],
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

#show figure.where(kind: table): set block(breakable: true)

// COVER
#align(center)[

  #table(
    columns: 100%,
    rows: 5mm,
    stroke: 0.5pt,
    [#align(center + horizon)[#text(size: 10.5pt)[* Tugas Week 6  - IMPAL-01-02 *]]],
  )

  #text(size: 14pt, weight: "bold")[
    TUGAS WEEK 6 - Convert Class Diagram ke Code
  ]

  #text(size: 16pt, weight: "bold")[
    SERVICE RIDE
  ]

  #text(size: 14pt, weight: "bold")[
    Integrated Automotive Service & Maintenance Platform
  ]

  #v(1cm)

  #image("../logo/ServiceRideVertical.png", width: 6cm)

  #v(1cm)

  #table(
    columns: (auto, auto),
    align: left + horizon,
    inset: 8pt,
    stroke: none,

    [Rovino Ramadhani], [103072400031],
    [Galang Herjuno Mulya], [103072430006],
    [Amirah Esssary Yunsarah Sujuthi], [103072400077],
    [Erastus Liubeta Septian], [103072400020],
    [Assyifa Dwi Safitri], [103072400064],
  )

  #v(1.5cm)

  #text(size: 14pt, weight: "bold")[PROGRAM STUDI INFORMATIKA]

  #text(size: 14pt, weight: "bold")[FAKULTAS DIREKTORAT KAMPUS SURABAYA]

  #text(size: 14pt, weight: "bold")[TELKOM UNIVERSITY]

  #text(size: 14pt, weight: "bold")[2026]
]

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

= EVALUASI CLASS DIAGRAM

== Identifikasi Class Diagram Service Ride

#paragraf[Evaluasi menggunakan lima diagram kelas asli pada `dppl/Class Diagram/` sebagai baseline. Diagram 01 memodelkan akun, alamat, kendaraan, bengkel, legalitas, dan keanggotaan staf. Diagram 02 memodelkan booking, pekerjaan servis, komponen, estimasi, jadwal, dan pemeriksaan stok. Diagram 03 memodelkan katalog, unit stok, pesanan marketplace, penjualan offline, serta retur. Diagram 04 memodelkan pembayaran, perjalanan pickup dan pengantaran, riwayat lokasi, dan invoice. Diagram 05 memodelkan ulasan, keluhan, notifikasi, administrasi platform, audit, dan laporan pendapatan. Pembagian ini mengikuti arsitektur modul pada DPPL, bagian “Deskripsi Arsitektur Perangkat Lunak” dan “Diagram Kelas Keseluruhan”.]

#paragraf[Landasan kebutuhan adalah `SKPL.typ`, khususnya ringkasan SKPL-FR-01 sampai SKPL-FR-47 dan SKPL-NFR-01 sampai SKPL-NFR-10. Pemeriksaan data menggunakan `db_schema.sql` dan ERD fisik pada `dppl/ERD/01-skema-fisik.mmd`. Urutan proses dibandingkan dengan diagram sekuens DPPL, terutama login, pengelolaan staf, persetujuan estimasi, retur, pembayaran, invoice, pickup, dan keluhan. Model kelas tidak dituntut menyalin seluruh kolom tabel: ia harus memperlihatkan identitas, keadaan, perilaku, dan batas tanggung jawab yang diperlukan untuk menerjemahkan rancangan.]

== Kriteria Evaluasi Class Diagram

#paragraf[Kelengkapan dinilai dari keterlacakan class ke kebutuhan. ketepatan tanggung jawab dinilai dari pemisahan entity, layanan aplikasi, policy, repository, adapter, dan tampilan dokumen. Atribut dinilai menurut nama, tipe, sifat opsional, konsistensi dengan PostgreSQL, dan kemampuan menjaga aturan domain. Method dinilai menurut visibilitas, parameter bertipe, return type, serta kewenangan class. Relasi dinilai menurut jenis, arah, multiplicity, kepemilikan, dan kecocokan foreign key. Kenormalan OOP dinilai melalui enkapsulasi, kohesi, Single Responsibility Principle, coupling, dan redundansi. Normalisasi basis data hanya dipakai untuk memeriksa keselarasan data, bukan sebagai ukuran tunggal kualitas class diagram.]

#paragraf[Dalam tabel berikut, “awal” menyatakan isi diagram asli. “revisi” menyatakan perubahan yang tampak pada file hasil evaluasi. Prioritas tinggi berarti berpengaruh pada akses, status transaksi, alokasi stok, atau identitas sumber data. Prioritas sedang berarti mengurangi ambiguitas implementasi. Prioritas rendah berarti memperjelas representasi tanpa mengubah proses bisnis.]

== Evaluasi Kelengkapan Class

#figure(
  table(
    columns: (23%, 77%),
    stroke: 0.4pt,
    inset: (x: 3pt, y: 5pt),
    align: left + top,
    table.header([*Class diagram 01*], [*Hasil pemeriksaan per class*]),
    [User],
    paragraf[Awal: identitas akun dan status tersedia, tetapi nama serta sifat email dan hash belum jelas. Revisi: nama dicantumkan, email/hash/role/status dienkapsulasi. perubahan email melalui operasi terkontrol.],

    [Address],
    paragraf[Awal: alamat dan titik lokasi tersedia. Revisi: nama serta kode provinsi/kota ditambahkan sesuai SQL. perubahan alamat default dibuat eksplisit.],

    [Vehicle],
    paragraf[Awal: nomor polisi dan jenis saja. Revisi: merek, model, dan tahun produksi ditambahkan untuk identitas kendaraan SKPL-FR-08.],

    [Workshop],
    [Awal: status, lokasi, dan marketplace tersedia. Revisi: nama dan status verifikasi dicantumkan. aktivasi dipicu keputusan pemeriksa.],

    [Workshop Document],
    paragraf[Awal: status dan pemeriksa tersedia. Revisi: NIB/NPWP dicantumkan. keputusan persetujuan dan penolakan diberi parameter bertipe.],

    [Workshop Membership],
    [Awal: role dan aktif tersedia. Revisi: role serta status aktif dijaga private. operasi perubahan role dan deaktivasi menjelaskan hak akses per bengkel.],

    [AuthService],
    paragraf[Awal: registrasi, verifikasi, login tersedia. Revisi: command dan parameter login diberi tipe. tetap sebagai orkestrator, bukan penyimpan hash.],

    [WorkshopService],
    [Awal: pengajuan, telaah dokumen, penugasan tersedia. Revisi: identitas dokumen dan keputusan diberi tipe.],

    [AccessPolicy],
    [Awal: penjaga role dan cakupan tersedia. Revisi: kontrak parameter bertipe dan disamakan pada diagram 02 serta 05.],

    [UserRepository],
    [Awal: pencarian dan penyimpanan tersedia. Revisi: signature bertipe. kemungkinan hasil tidak ditemukan tetap kontrak implementasi.],

    [Workshop Repository], [Awal: pencarian dan penyimpanan tersedia. Revisi: signature bertipe.],
    [Verification Sender],
    [Awal: pengiriman kode tersedia. Revisi: email dan kode diberi tipe. masa berlaku kode tetap kebijakan layanan.],
  ),
  caption: [Evaluasi seluruh class pada diagram akun dan bengkel],
) <eval-01>

#figure(
  table(
    columns: (23%, 77%),
    stroke: 0.4pt,
    inset: (x: 3pt, y: 5pt),
    align: left + top,
    table.header([*Class diagram 02*], [*Hasil pemeriksaan per class*]),
    [Booking],
    [Awal: identitas, status, jadwal, dan total tersedia. Revisi: kode booking, alamat pickup opsional, metode/bukti/waktu ACC, dan waktu selesai estimasi dicantumkan. status dan total dienkapsulasi.],

    [BookingServiceItem],
    [Awal: pekerjaan dan mekanik tersedia. Revisi: referensi mekanik dinyatakan sebagai keanggotaan bengkel, foto dan riwayat progres dicantumkan.],

    [BookingProduct],
    [Awal: kuantitas serta harga satuan tersedia. Revisi: dipertahankan. subtotal tetap perilaku turunan, bukan nilai bebas.],

    [EstimateDocument],
    [Awal: tampilan dokumen terpisah dari tabel. Revisi: dipertahankan sebagai document view. URL tetap tercatat pada booking.],

    [BookingService],
    [Awal: membuat dan membatalkan booking. Revisi: command, ID, dan alasan bertipe. penjadwalan tetap melibatkan SlotPolicy.],

    [EstimateService],
    [Awal: menyiapkan, menyetujui, memulai kerja. Revisi: input inspeksi dan keputusan bertipe. urutan stok setelah ACC dan pembayaran tetap dipertahankan.],

    [SlotPolicy], [Awal: kapasitas dan reservasi tersedia. Revisi: waktu serta identitas bengkel/booking bertipe.],
    [CoveragePolicy],
    [Awal: cakupan dan ongkos pickup tersedia. Revisi: titik lokasi dan jarak diberi tipe. tidak menetapkan tarif numerik baru.],

    [BookingRepository],
    [Awal: baca terkunci, simpan, cari jadwal. Revisi: signature bertipe. penguncian dipertahankan untuk aturan transaksi.],

    [InventoryService], [Awal: kontrak modul stok ditampilkan. Revisi: signature disejajarkan dengan diagram 03.],
    [PaymentService],
    [Awal: pemeriksaan lunas tersedia. Revisi: ID booking diberi tipe dan disamakan dengan diagram 04.],

    [AccessPolicy], [Awal: hanya cakupan bengkel dicantumkan. Revisi: kontrak lengkap disamakan dengan diagram 01.],
  ),
  caption: [Evaluasi seluruh class pada diagram booking dan estimasi],
) <eval-02>

#figure(
  table(
    columns: (23%, 77%),
    stroke: 0.4pt,
    inset: (x: 3pt, y: 5pt),
    align: left + top,
    table.header([*Class diagram 03*], [*Hasil pemeriksaan per class*]),
    [Category], [Awal: ID dan nama memadai untuk master kategori. dipertahankan.],
    [CategoryBrand], [Awal: ID dan nama tersedia. Revisi: atribut logo ditambahkan sesuai skema.],
    [Product],
    [Awal: bengkel, kategori, SKU, harga, status tersedia. Revisi: kategori merek opsional dan operasi deaktivasi dicantumkan. harga tetap decimal.],

    [ProductStock],
    [Awal: unit stok dan satu target alokasi tersedia. Revisi: nomor seri/waktu reservasi dicantumkan. status dan referensi alokasi dienkapsulasi.],

    [MarketplaceOrder],
    [Awal: status, alamat kirim, total tersedia. Revisi: kode transaksi, subtotal, ongkos kirim, waktu bayar/terima dicantumkan.],

    [MarketplaceOrderDetail],
    [Awal: pengiriman tersedia. Revisi: bengkel penjual, status retur, bukti, waktu pengajuan, dan operasi retur dicantumkan.],

    [InventoryService],
    [Awal: hitung, tahan, lepas, konsumsi unit tersedia. Revisi: kontrak pemeriksaan dan alokasi servis diselaraskan dengan diagram 02.],

    [MarketplaceService],
    [Awal: checkout, pemenuhan, batal, pengajuan retur tersedia. Revisi: keputusan retur ditambahkan sesuai sekuens DPPL 29.],

    [CatalogService], [Awal: CRUD katalog tersedia. Revisi: command dan ID bertipe. tetap dibatasi ke katalog.],
    [OfflineSaleService],
    [Awal: penjualan tunai tersedia. Revisi: parameter bertipe. pemetaan catatan kas ke sumber pembayaran fisik perlu diputuskan sebelum implementasi.],

    [ProductRepository],
    [Awal: SKU scoped per bengkel tersedia. Revisi: kontrak bertipe. sesuai keunikan komposit SQL.],

    [StockRepository],
    [Awal: penguncian dan penyimpanan tersedia. Revisi: tipe permintaan eksplisit. tipe koleksi unit perlu dispesifikkan pada rancangan implementasi.],

    [OrderRepository], [Awal: baca terkunci dan simpan tersedia. Revisi: kontrak bertipe.],
    [PaymentService],
    [Awal: QRIS dan refund lintas modul tersedia. Revisi: sumber dan jumlah pembayaran dibuat eksplisit. kontrak disamakan dengan diagram 04.],
  ),
  caption: [Evaluasi seluruh class pada diagram inventori dan marketplace],
) <eval-03>

#figure(
  table(
    columns: (23%, 77%),
    stroke: 0.4pt,
    inset: (x: 3pt, y: 5pt),
    align: left + top,
    table.header([*Class diagram 04*], [*Hasil pemeriksaan per class*]),
    [Payment],
    [Awal: dua foreign key sumber dan refund tersedia, tetapi opsionalitas tidak jelas. Revisi: kode/jenis/ref/waktu bayar dicantumkan. sumber, jumlah, dan status dienkapsulasi.],

    [BookingPickup],
    [Awal: tugas, jenis leg, status, ongkos, bukti tersedia. Revisi: staf mengacu ke membership. waktu jadwal, berangkat, selesai ditambahkan.],

    [PickupHistory],
    [Awal: lokasi, status, waktu tersedia. Revisi: catatan ditambahkan untuk kejadian offline sesuai skema.],

    [PaymentService],
    [Awal: QRIS, tunai, konfirmasi, refund. Revisi: sumber dan nominal bertipe. pemeriksaan lunas disamakan dengan diagram 02.],

    [PickupService],
    [Awal: penugasan dan lokasi. Revisi: jenis leg pickup/pengantaran menjadi parameter agar keunikan per booking dapat dijaga.],

    [InvoiceService],
    [Awal: renderer dan pembayaran tersedia. Revisi: dependensi BookingRepository ditambahkan untuk menyimpan URL invoice pada booking.],

    [DocumentRenderer],
    [Awal: rendering tersedia. Revisi: ID booking diberi tipe. detail isi invoice adalah kontrak tahap kode.],

    [DummyQrisAdapter],
    [Awal: buat/periksa pembayaran. Revisi: kode dan nominal diberi tipe tanpa mengganti metode baseline.],

    [PaymentRepository], [Awal: baca terkunci dan simpan. Revisi: signature bertipe.],
    [PickupRepository], [Awal: baca/simpan/riwayat. Revisi: signature bertipe.],
    [LocationStream],
    [Awal: siaran lokasi. Revisi: ID booking dan Point diberi tipe. akses penerima tetap dibatasi kebijakan aplikasi.],
  ),
  caption: [Evaluasi seluruh class pada diagram pembayaran dan pickup],
) <eval-04>

#figure(
  table(
    columns: (23%, 77%),
    stroke: 0.4pt,
    inset: (x: 3pt, y: 5pt),
    align: left + top,
    table.header([*Class diagram 05*], [*Hasil pemeriksaan per class*]),
    [Review],
    [Awal: rating, balasan, sembunyi tersedia. Revisi: waktu, alasan moderasi, dan metode perubahan terkendali ditambahkan. satu sumber transaksi tetap wajib.],

    [ReviewService],
    [Awal: create/edit/reply/moderate tersedia. Revisi: sumber bertipe dan AuditSink ditetapkan sebagai dependensi eksplisit.],

    [ComplaintCase],
    [Awal: kasus memiliki sourceId tanpa jenis. Revisi: jenis sumber dan status bertipe. tetap ditandai sebagai persistensi terencana.],

    [ComplaintService],
    [Awal: pembukaan dan resolusi tersedia. Revisi: dependensi notifikasi eksplisit dan keputusan bertipe.],

    [NotificationService],
    [Awal: mengirim dan menyimpan notifikasi. Revisi: event bertipe. dipasangkan dengan class Notification yang sebelumnya belum didefinisikan.],

    [PlatformAdmin Service],
    [Awal: kategori/promosi serta audit tersedia. Revisi: command bertipe. tidak menambah aturan promosi baru.],

    [RevenueReport Service],
    [Awal: merangkum tanpa sumber data dan otorisasi eksplisit. Revisi: PaymentRepository, AccessPolicy, AuditSink, dan tipe laporan ditambahkan.],

    [Review Repository],
    [Awal: cari sumber/simpan tersedia. Revisi: kontrak bertipe. pencarian kini menerima jenis sumber untuk membedakan booking dan pesanan marketplace.],

    [Complaint Repository], [Awal: persistensi terencana. Revisi: parameter simpan bertipe.],
    [Notification Repository], [Awal: persistensi terencana. Revisi: parameter Notification bertipe.],
    [MasterDataRepository], [Awal: penyimpanan kategori/promosi. Revisi: tipe entitas eksplisit.],
    [AuditSink], [Awal: catat tindakan. Revisi: identitas pelaku, tindakan, dan subjek bertipe.],
  ),
  caption: [Evaluasi seluruh class pada diagram ulasan dan layanan pendukung],
) <eval-05>

Dua class baru pada revisi 05 adalah `Notification` dan `RevenueReport`. Keduanya melengkapi tipe yang sudah dipakai oleh operasi baseline. yang pertama tetap berstatus rancangan persistensi, sedangkan yang kedua adalah tampilan hasil perhitungan. Pada revisi 04, `BookingRepository` hanya ditampilkan sebagai kontrak lintas modul yang sudah ada pada diagram 02.

== Evaluasi Atribut dan Tipe Data

`UUID` sesuai untuk identitas entitas dan foreign key PostgreSQL. `decimal` pada uang harus dipetakan ke `NUMERIC(14,2)`. `int` untuk kuantitas/rating memiliki batas SQL (`quantity > 0`, rating 1–5). `datetime` mewakili `TIMESTAMPTZ`, sedangkan `Point` mewakili PostGIS `GEOGRAPHY(Point,4326)`. `json` pada foto, riwayat, dan alamat kirim mewakili `JSONB`. struktur payload perlu kontrak terpisah agar tidak menjadi objek bebas. Status yang berasal dari enum SQL tetap enum domain, bukan string generik. Perbedaan tipe ini adalah pemetaan rancangan, bukan perubahan skema.

Atribut yang dapat kosong pada SQL meliputi `user.email`, `user.password_hash`, `booking.id_address` untuk booking non-pickup, bukti dan waktu ACC, referensi pembayaran, waktu perjalanan, data retur, serta salah satu sumber pada Payment/Review. Mermaid tidak mengekspresikan nullability per field secara kaya. kontrak implementasi harus menandai optional secara eksplisit. Identitas `booking_service.id_mechanic` dan `booking_pickup.id_workshop_user_management` menunjuk membership staf, bukan ID user langsung. `ProductStock` tetap unit fisik, sehingga alokasi tidak dimodelkan sebagai angka stok global. Pencatatan subtotal pada SQL tetap snapshot transaksi walaupun operasi `subtotal()` dapat menghitung ulang untuk validasi.

== Evaluasi Access Modifier

Pada baseline, seluruh atribut entity ditandai public. Ini berisiko memungkinkan perubahan status serta bukti tanpa melewati validasi. Revisi membuat `User.email/passwordHash/role/accountStatus`, `WorkshopMembership.role/isActive`, `Payment.amount/status/sumber`, `ProductStock.status/target`, `Booking.status/approval`, dan `Review.isHidden/ownerReply` private. Perubahan diarahkan melalui operasi domain atau layanan yang memiliki otorisasi. Identitas yang dibaca oleh kolaborator dan data deskriptif tetap public dalam diagram sebagai representasi akses baca konseptual. implementasi dapat menggunakan getter/read model yang tidak menyediakan mutasi bebas. Protected tidak diterapkan karena tidak ada hierarki pewarisan yang memerlukannya. Pembatasan hak akses pengguna tetap ditentukan AccessPolicy dan transaksi, bukan hanya simbol visibilitas UML.

== Evaluasi Method

Pada baseline, banyak operasi belum memberi tipe pada parameter: misalnya `login(email,password)`, `approve(reviewerId)`, `cancel(reason)`, `holdUnits(productId,qty,targetId)`, `confirm(paymentId,reference)`, dan `moderate(id,reason)`. Seluruh operasi pada diagram revisi memakai parameter dan return type yang tertulis, termasuk `void`. Bentuk `Command`, `DomainEvent`, `StockRequest`, dan `ReportPeriod` adalah tipe kontrak konseptual. susunan fieldnya harus dipastikan sebelum menghasilkan kode. Tipe `Availability` menyatakan hasil pengecekan stok, tidak berarti alokasi sudah terjadi. Method `decideReturn` menutup celah antara class diagram dan sekuens DPPL 29. Operasi pembayaran tetap di PaymentService, sedangkan `Payment.confirm` menjaga perubahan status pada entity. Validasi role tetap di AccessPolicy agar service tidak menggandakan aturan otorisasi.

== Evaluasi Relasi Antarkelas

Komposisi Booking–BookingServiceItem/BookingProduct, Product–ProductStock, MarketplaceOrder–Detail, BookingPickup–History, dan Workshop–Document menyatakan kepemilikan konseptual. Karena tabel memakai foreign key serta sebagian data memakai soft delete, komposisi tidak boleh ditafsirkan sebagai penghapusan fisik otomatis. Association User–Workshop (1 ke 0..\*) sesuai satu pemilik dan banyak bengkel. User–WorkshopMembership–Workshop menjaga akses staf per bengkel. Kategori merek optional. detail pesanan menunjuk produk dan bengkel penjual. Payment dan Review masing-masing memiliki dua foreign key sumber yang optional secara individu, tetapi constraint SQL mewajibkan tepat satu terisi. Payment refund menunjuk pembayaran asal melalui relasi diri. `BookingPickup` unik per pasangan booking dan jenis perjalanan. Dependency service ke interface/repository adalah relasi pemakaian, bukan kepemilikan objek persisten. Inheritance tidak ditambahkan karena role staf dan jenis transaksi lebih tepat dinyatakan sebagai enum serta komposisi/association.

== Evaluasi Kenormalan Class Diagram

Pemisahan entity, application service, repository, policy, dan adapter pada DPPL memberi kohesi yang baik. Koreksi utama ialah mengurangi kebebasan mutasi state, memperjelas kontrak, dan menambahkan dependensi yang memang dipakai. `MarketplaceService` mengoordinasikan beberapa proses, tetapi belum perlu dipecah karena transaksi order, pengiriman, pembatalan, dan retur masih berada dalam satu siklus pesanan. keputusan pemecahan dapat ditinjau berdasarkan kompleksitas implementasi. `OfflineSaleService` tetap terpisah dari checkout marketplace karena kanal dan aktornya berbeda. `RevenueReportService` tetap read-only dan tidak mengubah Payment. Duplikasi `AccessPolicy`, `InventoryService`, dan `PaymentService` antardiagram adalah tampilan kontrak modul. signature yang sama mencegah interpretasi sebagai class berbeda. Ini adalah kenormalan desain objek. bentuk tabel dan keunikan SQL dinilai terpisah.

#pagebreak()
#page(flipped: true)[
  == Rekapitulasi Hasil Evaluasi
  #figure(
    table(
      columns: (0.8fr, 1.5fr, 1.3fr, 1.3fr, 1.7fr, 0.9fr, 1.8fr),
      stroke: 0.4pt,
      inset: (x: 3pt, y: 5pt),
      align: left + top,

      table.header(
        [*Diagram*], [*Komponen*], [*Kondisi awal*], [*Hasil evaluasi*], [*Masalah*], [*Prioritas*], [*Rekomendasi*]
      ),
      [01 Akun],
      [User. Membership],
      [Atribut state public],
      [Perlu enkapsulasi],
      [Hash, role, dan status mudah diubah tanpa guard],
      [Tinggi],
      [Private untuk state. operasi perubahan dan policy bertipe.],

      [01 Akun],
      [Address. Vehicle. WorkshopDocument],
      [Atribut inti sebagian],
      [Perlu data identitas],
      [Field rujukan SQL tidak terlihat],
      [Sedang],
      [Tambah field terpilih dan tipe keputusan.],

      [02 Booking],
      [Booking. EstimateService],
      [ACC kurang rinci],
      [Perlu jejak persetujuan],
      [Metode, bukti, waktu, dan keputusan ambigu],
      [Tinggi],
      [Tambah state ACC dan signature keputusan.],

      [02 Booking],
      [ServiceItem. InventoryService],
      [Staf dan stok lintas modul],
      [Perlu kontrak sama],
      [ID mekanik dan pemeriksaan stok ambigu],
      [Tinggi],
      [Tegaskan membership dan kontrak stok.],

      [03 Stok],
      [ProductStock],
      [Unit tersedia],
      [Invariant perlu dijaga],
      [Status dan target alokasi public],
      [Tinggi],
      [Enkapsulasi dan transisi alokasi.],

      [03 Pasar],
      [OrderDetail. MarketplaceService],
      [Retur sebagian],
      [Keputusan retur hilang],
      [Bukti/waktu/status tidak lengkap],
      [Tinggi],
      [Tambah state dan operasi keputusan retur.],

      [03 Offline],
      [OfflineSaleService],
      [Jual tunai ada],
      [Pemetaan data belum tegas],
      [Sumber Payment dibatasi dua FK],
      [Sedang],
      [Putuskan representasi transaksi kas tanpa melanggar constraint.],

      [04 Bayar],
      [Payment. PaymentService],
      [Sumber dan nominal public],
      [Tepat satu sumber],
      [Status/refund tidak terlindungi],
      [Tinggi],
      [Private, kontrak sumber dan nominal, validasi SQL.],

      [04 Pickup],
      [PickupService. InvoiceService],
      [Jenis leg dan dependensi kurang],
      [Perlu perluasan],
      [Keunikan perjalanan dan penyimpanan URL belum jelas],
      [Sedang],
      [Tipe leg. akses BookingRepository.],

      [05 Ulasan],
      [Review. ReviewService],
      [Moderasi sebagian],
      [Jejak dan waktu kurang],
      [Alasan/waktu dan audit kurang],
      [Sedang],
      [Tambah field serta audit eksplisit.],

      [05 Dukung],
      [Notification. RevenueReportService],
      [Tipe hasil belum ada],
      [Perlu model hasil],
      [Repository menyimpan tipe tak didefinisikan. laporan tanpa sumber],
      [Sedang],
      [Tambah Notification, RevenueReport, dependensi baca dan akses.],
    ),
    caption: [Rekapitulasi temuan, prioritas, dan rekomendasi],
  ) <rekap>
]@rekap ini membedakan masalah yang bersumber dari baseline dan keputusan revisi. Prioritas tinggi terutama terkait SKPL-NFR-01 sampai SKPL-NFR-04 serta constraint `payment_exactly_one_source` dan `product_stock_allocation_check`.

#pagebreak()

= PERBAIKAN CLASS DIAGRAM

== Dasar Perbaikan

Revisi hanya dilakukan bila temuan dapat ditelusuri ke kebutuhan, skema, atau sekuens. Nama entitas dan pembagian lima modul dipertahankan. Atribut ditambah secara selektif agar perilaku yang dinilai memiliki konteks. kolom audit rutin tidak disalin seluruhnya ke setiap class. `decimal`, `datetime`, `json`, dan enum dipertahankan sebagai abstraksi yang dapat dipetakan ke PostgreSQL. Tipe kontrak konseptual tidak dianggap sebagai tabel baru. Perubahan visibilitas ditujukan pada state yang menuntut validasi. Tidak ada keputusan tarif atau kebijakan bisnis numerik baru.

== Perbaikan Class Diagram Akun dan Bengkel

Pada diagram 01, class User memperoleh `name`, sementara email, hash, role, dan status menjadi private. `changeEmail` memberi titik kendali perubahan. Address menampakkan wilayah administrasi. Vehicle menampakkan merek, model, dan tahun. Workshop menampakkan nama dan verifikasi. WorkshopDocument memuat data legalitas kunci dan keputusan pemeriksa bertipe. WorkshopMembership menyembunyikan role dan aktivasi, sesuai pembatasan staf per bengkel. Interface repository dan pengirim verifikasi mendapat parameter bertipe. Association pemilik dan staf dipertahankan karena cocok dengan foreign key sumber. komposisi dokumen dibaca sebagai kepemilikan konsep, bukan cascade delete.

== Perbaikan Class Diagram Booking dan Estimasi

Booking mendapat `bookingCode`, alamat pickup, waktu selesai estimasi, serta metode, bukti, dan waktu persetujuan. Status dan total dibuat private supaya perubahan tidak memotong prosedur persetujuan. BookingServiceItem mengacu membership mekanik dan menyimpan abstraksi foto/riwayat. `EstimateService.approve` menyatakan keputusan dan bukti secara eksplisit, sesuai sekuens DPPL 21. Pemeriksaan ketersediaan tetap sebelum persetujuan tanpa menahan unit. alokasi dilakukan setelah ACC dengan pemeriksaan ulang. `EstimateDocument` tetap view, sebab URL dokumen disimpan di booking, bukan tabel terpisah.

== Perbaikan Class Diagram Inventori dan Marketplace

Product menampakkan brand opsional, ProductStock menampakkan nomor seri dan waktu reservasi, sementara status serta target alokasi menjadi private. Order mencatat komponen total dan waktu transaksi, dan detail mencatat bengkel penjual serta status/bukti/waktu retur. `MarketplaceService.decideReturn` ditambahkan berdasarkan sekuens DPPL 29. `InventoryService` menyediakan kontrak yang sama dengan diagram 02. Penjualan tunai offline tetap sebagai layanan tersendiri. representasi pembayaran fisiknya perlu diputuskan agar tidak bertentangan dengan constraint sumber Payment. Nilai barang dan stok tetap dibatasi per bengkel.

== Perbaikan Class Diagram Pembayaran dan Pickup

Payment memperoleh kode, jenis, referensi, serta waktu bayar. `bookingId` dan `marketplaceOrderId` masing-masing dapat kosong, tetapi validasi mengharuskan tepat satu sumber. Status dan nominal tidak diubah langsung dari luar. Refund menunjuk Payment asal dan menerima nominal eksplisit. Pickup mencatat waktu serta membership petugas. `PickupService.assign` menerima jenis perjalanan karena satu booking dapat memiliki leg pickup dan pengantaran. `InvoiceService` menggunakan BookingRepository untuk hasil dokumen final pada booking. `LocationStream` tetap antarmuka pengiriman pembaruan, sedangkan riwayat posisi dimiliki BookingPickup.

== Perbaikan Class Diagram Ulasan dan Layanan Pendukung

Review mendapat waktu, alasan moderasi, dan operasi menyembunyikan konten. edit 24 jam tetap kebijakan layanan yang menggunakan `createdAt`. ComplaintCase mendapat jenis sumber agar sumber laporan tidak ambigu. Class Notification ditambahkan karena NotificationRepository telah menyimpan objek tersebut pada baseline. RevenueReport sebagai view dan PaymentRepository sebagai sumber baca memperjelas hasil laporan menurut metode pembayaran. AccessPolicy dan AuditSink menjadi dependensi eksplisit. Label `planned_persistence` tetap menunjukkan bahwa penyimpanan keluhan dan notifikasi adalah rancangan, bukan tabel yang telah ada pada skema referensi.

== Perbandingan Class Diagram Sebelum dan Sesudah Perbaikan

Subbab ini merujuk PNG baseline yang sudah tersedia pada `dppl/hasil/Class Diagram/` dan PNG revisi yang akan dihasilkan dari lima file `.mmd` di `week6/revisi/`. Setelah PNG revisi tersedia, gambar-01-asli sampai @gambar-05-revisi akan tampil saat laporan dibangun. Sumber Mermaid tidak dimasukkan langsung ke dokumen Typst.

#figure(
  image("../dppl/hasil/Class Diagram/01-akun-dan-bengkel.png", width: 100%, height: 15cm, fit: "contain"),
  caption: [Class Diagram akun dan bengkel sebelum revisi],
) <gambar-01-asli>
#figure(
  image("./hasil//01-akun-dan-bengkel-revisi.png", width: 100%, height: 15cm, fit: "contain"),
  caption: [Class Diagram akun dan bengkel setelah revisi],
) <gambar-01-revisi>
#figure(
  image("../dppl/hasil/Class Diagram/02-booking-dan-estimasi.png", width: 100%, height: 15cm, fit: "contain"),
  caption: [Class Diagram booking dan estimasi sebelum revisi],
) <gambar-02-asli>

#pagebreak()

#page(flipped: true)[

  #figure(
    image("./hasil//02-booking-dan-estimasi-revisi.png", width: 100%, height: 13.5cm, fit: "contain"),
    caption: [Class Diagram booking dan estimasi setelah revisi],
  ) <gambar-02-revisi>
]
#figure(
  image("../dppl/hasil/Class Diagram/03-inventori-dan-marketplace.png", width: 100%, height: 15cm, fit: "contain"),
  caption: [Class Diagram inventori dan marketplace sebelum revisi],
) <gambar-03-asli>
#figure(
  image("./hasil//03-inventori-dan-marketplace-revisi.png", width: 100%, height: 15cm, fit: "contain"),
  caption: [Class Diagram inventori dan marketplace setelah revisi],
) <gambar-03-revisi>
#figure(
  image("../dppl/hasil/Class Diagram/04-pembayaran-dan-pickup.png", width: 100%, height: 15cm, fit: "contain"),
  caption: [Class Diagram pembayaran dan pickup sebelum revisi],
) <gambar-04-asli>
#figure(
  image("./hasil//04-pembayaran-dan-pickup-revisi.png", width: 100%, height: 15cm, fit: "contain"),
  caption: [Class Diagram pembayaran dan pickup setelah revisi],
) <gambar-04-revisi>
#figure(
  image("../dppl/hasil/Class Diagram/05-ulasan-dan-layanan-pendukung.png", width: 100%, height: 15cm, fit: "contain"),
  caption: [Class Diagram ulasan dan layanan pendukung sebelum revisi],
) <gambar-05-asli>
#pagebreak()
#page(flipped: true)[
  #figure(
    image("./hasil//05-ulasan-dan-layanan-pendukung-revisi.png", width: 100%, height: 13cm, fit: "contain"),
    caption: [Class Diagram ulasan dan layanan pendukung setelah revisi],
  ) <gambar-05-revisi>
]

#figure(
  table(
    columns: (16%, 39%, 45%),
    stroke: 0.4pt,
    inset: 3pt,
    table.header([*Diagram*], [*Sebelum*], [*Sesudah*]),
    [01],
    [Atribut akun/staf public. identitas terpilih belum tampak.],
    [State penting private. identitas dan signature bertipe.],

    [02], [ACC serta data inspeksi belum rinci.], [Bukti/metode/waktu ACC dan foto/progres terlihat.],
    [03], [Alokasi dan retur kurang rinci.], [Target unit terlindungi. jejak retur dan keputusan terlihat.],
    [04],
    [Sumber/status pembayaran terbuka. leg tidak eksplisit.],
    [Sumber/status private. tipe leg dan akses invoice tegas.],

    [05],
    [Tipe Notification/Report dan sumber laporan belum jelas.],
    [View laporan, notifikasi, audit, dan data moderasi eksplisit.],
  ),
  caption: [Ringkasan perubahan visual dan semantik per diagram],
) <banding>

@banding merangkum perubahan yang akan dapat diperiksa pada pasangan gambar setelah PNG tersedia. Perluasan atribut tidak dimaksudkan mengganti keputusan bisnis pada SKPL. ia membuat aturan yang sudah ada lebih mudah diturunkan menjadi kontrak kode.

== Validasi Hasil Perbaikan

Validasi desain dilakukan dengan membandingkan nama class, kontrak lintas diagram, dan foreign key terhadap baseline. Signature `AccessPolicy`, `InventoryService`, dan `PaymentService` yang ditampilkan di beberapa diagram diperiksa konsistensinya. Relasi komposisi dinilai menurut kepemilikan konseptual, sedangkan aturan persisten tetap mengikuti SQL. Pemeriksaan statis telah memastikan kelima file revisi memiliki deklarasi class, signature bertipe, dan target berkas PNG yang konsisten dengan script. lima PNG baseline telah tersedia pada DPPL. Keterbacaan gambar serta sintaks Mermaid secara penuh perlu diperiksa setelah render dijalankan. Evaluasi ini tidak menyatakan hasil pengujian perilaku aplikasi.


#pagebreak()
= ANALISIS KESIAPAN IMPLEMENTASI KODE

== Pemetaan Class Diagram terhadap Implementasi

Entity seperti User, Booking, ProductStock, Payment, dan Review dapat menjadi model domain dengan transisi status yang dilindungi. Application service menjadi koordinator use case dan transaksi. Repository adalah kontrak baca/tulis terhadap data persisten. policy menampung kapasitas, cakupan wilayah, atau otorisasi. adapter mengisolasi Dummy QRIS, pengiriman verifikasi, rendering dokumen, dan penyiaran lokasi. `EstimateDocument` serta `RevenueReport` adalah hasil baca/tampilan, bukan tabel otomatis. Pemisahan ini memberi titik pengujian yang jelas tanpa menetapkan struktur paket, framework, atau isi method pada tahap ini.

== Kesiapan Atribut dan Tipe Data

Identitas UUID, enum status, uang decimal, timestamp, Point, serta data JSON sudah cukup jelas untuk pemetaan tingkat rancangan. Implementasi masih perlu menetapkan nilai optional pada tipe bahasa yang dipakai dan memvalidasi batas numerik SQL. `StockRequest`, payload foto, alamat snapshot, serta bukti persetujuan memerlukan skema data lebih rinci. Keunikan SKU hanya dalam satu bengkel, nomor polisi dalam satu pemilik, dan satu perjalanan per jenis per booking harus dipertahankan. Field `price` pada detail pesanan dan booking adalah snapshot transaksi, sehingga tidak boleh mengikuti perubahan harga katalog setelah transaksi dibuat.

== Kesiapan Method dan Parameter

Diagram revisi memberi tipe pada semua parameter yang ditampilkan serta return type pada operasi layanan, entity, policy, repository, dan adapter. Beberapa tipe konseptual, seperti command, Availability, PaymentRowSet, dan DomainEvent, masih perlu definisi field serta aturan error. Operasi yang mengganti status harus menentukan prasyarat dan hasil gagal saat penerjemahan kode, terutama ACC estimasi, alokasi unit, pembayaran, pembatalan, refund, dan retur. Penetapan transaksi atomik dibutuhkan pada penguncian unit dan perubahan status terkait. Diagram kelas menjadi dasar signature, sedangkan urutan rinci tetap dirujuk pada diagram sekuens.

== Kesiapan Interface dan Relasi

Interface repository dan adapter telah memisahkan domain dari penyimpanan serta integrasi. Dependency lintas modul yang sama sudah diperjelas untuk InventoryService, PaymentService, dan AccessPolicy. Tidak ada pewarisan yang dipaksakan. Saat implementasi, `PaymentRepository.findForReport` perlu menyediakan data sesuai cakupan bengkel dan periode, sedangkan pembaca notifikasi serta hasil laporan harus tetap mengikuti otorisasi. Komposisi pada diagram tidak otomatis berarti penghapusan data. siklus hidup persisten ditentukan kebijakan dan foreign key.

== Kesesuaian dengan Rancangan Database

Sebagian besar entity memiliki padanan langsung pada 19 tabel ERD: User, Address, Vehicle, Workshop, WorkshopDocument, WorkshopMembership, Product, ProductStock, MarketplaceOrder/Detail, Booking/Service/Product/Pickup/History, Payment, dan Review. Nama domain yang berbeda dari tabel dijelaskan oleh tanggung jawab konsep, misalnya WorkshopMembership terhadap `workshop_user_management`. `Payment` dan `Review` wajib memiliki tepat satu sumber, sedangkan ProductStock mengikuti constraint alokasi eksklusif. `estimate_document_url` dan `invoice_url` tetap atribut booking. Keluhan, notifikasi, promosi, serta audit adalah rancangan pendukung yang memerlukan keputusan persistensi tersendiri. Penjualan spare part offline membutuhkan pemetaan transaksi kas yang sah terhadap dua sumber Payment yang ada. Ini merupakan keputusan desain data lanjutan, bukan dasar untuk mengubah aturan bisnis secara sepihak.

== Hasil Analisis Kesiapan Implementasi

Lima diagram revisi cukup siap sebagai peta class, state, operasi, dan kolaborasi lintas modul. Kesiapan ini bersyarat pada empat keputusan sebelum kode dibuat: definisi payload command/event dan hasil error. nullability serta constraint sumber. batas transaksi stok/pembayaran. dan representasi penyimpanan untuk proses pendukung serta penjualan offline. Kebutuhan pembuatan kode dan integrasi login pada tugas Week 6 tetap dicatat sebagai tahap berikutnya sesuai pembatasan pekerjaan ini.

#pagebreak()

= KESIMPULAN DAN REKOMENDASI

== Kesimpulan Evaluasi

Kelima diagram baseline sudah mencakup modul utama Service Ride dan memisahkan sebagian besar tanggung jawab secara masuk akal. Temuan paling penting adalah state sensitif yang public, signature method tanpa tipe parameter, jejak persetujuan/retur yang belum tampak lengkap, serta beberapa kontrak lintas diagram yang belum seragam. Foreign key dan constraint SQL memberi rujukan konkret untuk mengoreksi representasi tanpa menyamakan class diagram dengan ERD.

== Hasil Perbaikan

Lima file revisi mempertahankan class inti dan menambah atribut terpilih, tipe parameter/hasil, visibilitas state, operasi retur, jenis perjalanan pickup, serta dependensi invoice dan laporan. Notification dan RevenueReport melengkapi tipe yang digunakan dalam layanan pendukung. Diagram asli dan PNG baseline tetap berada pada lokasi DPPL tanpa perubahan. Referensi gambar revisi pada sumber Typst menunjuk keluaran PNG yang akan dibuat oleh script rendering Week 6.

== Rekomendasi Implementasi

Terjemahkan entity dengan aturan transisi yang menjaga status dan nominal. jadikan policy sebagai pemeriksa role serta cakupan bengkel. gunakan repository untuk transaksi dan penguncian data. dan pertahankan adapter sebagai batas integrasi. Cocokkan enum dan aturan optional dengan PostgreSQL. Susun kontrak input serta kegagalan untuk operasi lintas modul sebelum pembuatan method. Uji kemudian skenario gagal yang ditetapkan SKPL-NFR-10, termasuk stok berubah, QRIS belum valid, estimasi ditolak, lokasi berhenti, pickup dibatalkan, dan bukti retur tidak memenuhi syarat.

== Rekomendasi Pengembangan Selanjutnya

Validasi lebih lanjut diperlukan untuk struktur command/event, kebijakan error dan idempotensi pembayaran, representasi penjualan offline terhadap sumber Payment, penyimpanan keluhan/notifikasi/promosi/audit, serta detail bukti dan retensi data. Batas numerik tarif pickup dan kompensasi tidak ditetapkan oleh diagram ini karena baseline belum memutuskan nilainya. Perubahan kebijakan tersebut harus kembali ditelusuri ke SKPL/DPPL sebelum disahkan.

== Referensi Dokumen

- Service Ride Project, `SKPL.typ`, ringkasan SKPL-FR-01–47 dan SKPL-NFR-01–10.
- Service Ride Project, `DPPL.typ`, arsitektur perangkat lunak, diagram kelas keseluruhan, dan perancangan detil kelas.
- Service Ride Project, `db_schema.sql`, PostgreSQL dan PostGIS, khususnya tabel booking, product_stock, payment, dan review.
- Service Ride Project, `dppl/README.md`, keputusan rancangan dan batas skema.
- Service Ride Project, `dppl/Class Diagram/`, lima baseline. `dppl/ERD/01-skema-fisik.mmd`. dan sekuens terkait.
