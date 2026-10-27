# Diagram DPPL Service Ride

Kumpulan ini adalah **rancangan DPPL untuk ditinjau**, disusun dari `SKPL.typ`, diagram pada folder `skpl/`, `db_schema.sql`, `query.sql`, dan `README.md` proyek. `DPPL.typ` belum diisi atau diubah oleh pekerjaan ini. Sumber kebutuhan adalah baseline SKPL, sedangkan nama service, repository, policy, dan adapter pada class serta sequence diagram adalah **usulan pemecahan implementasi** karena backend belum tersedia pada proyek lokal.

## Isi

| Folder | Jumlah | Notasi Mermaid | Cakupan |
|---|---:|---|---|
| `Class Diagram/` | 5 | `classDiagram` | Akun dan bengkel; booking dan estimasi; inventori dan marketplace; pembayaran dan pickup; ulasan dan layanan pendukung. |
| `Sequence Diagram/` | 34 | `sequenceDiagram` | Satu file per 34 skenario utama SKPL, nomor 01–34. |
| `Activity Diagram/` | 8 | `swimlane-beta` | Proses teknis yang memerlukan validasi, keputusan, dan perpindahan tanggung jawab. |
| `ERD/` | 1 | `erDiagram` | Seluruh 19 tabel, atribut, primary key, foreign key, dan 38 relasi foreign key dari `db_schema.sql`. |
| `DFD/` | 5 | `flowchart` dengan bentuk DFD | Diagram konteks, level 0, dan dekomposisi level 1 booking, marketplace, pembayaran. |

Mermaid menyediakan notasi langsung untuk class, sequence, dan ERD. `swimlane-beta` digunakan untuk activity diagram dengan pemilik langkah; Mermaid belum menyediakan deklarasi `activityDiagram` khusus. DFD juga tidak memiliki deklarasi tersendiri, sehingga file DFD memakai bentuk proses, entitas eksternal, dan *data store* yang didukung oleh flowchart Mermaid.

## Keputusan rancangan dan batas skema

- `workshop` pada skema dipakai sebagai unit operasional atau cabang. Tidak ada tabel `branch` terpisah; pembatasan stok dan staf dilakukan dengan `id_workshop`.
- Stok fisik bersifat per unit di `product_stock`. Unit `held` menunjuk tepat satu `booking_product` atau `marketplace_transaction_detail`, sesuai constraint skema. Pengecekan estimasi belum mengalokasikan stok; alokasi dilakukan setelah persetujuan, dengan pemeriksaan ulang dan transaksi basis data.
- `estimate_document_url` dan `invoice_url` adalah kolom pada `booking`; keduanya **bukan tabel terpisah** pada ERD fisik. Kelas `EstimateDocument` dan `InvoiceService` adalah tampilan dokumen dan layanan aplikasi.
- Keluhan, notifikasi, promosi, serta audit disebut di SKPL, tetapi belum mempunyai tabel khusus dalam `db_schema.sql`. Kelas dan repository terkait pada diagram adalah rancangan yang memerlukan migrasi skema sebelum implementasi penuh. Pada DFD level 0, hanya penyimpanan ulasan yang telah memiliki tabel fisik untuk modul 6.0.
- Verifikasi email memerlukan penyimpanan kode sementara. Implementasinya bisa memakai Redis sesuai lingkungan proyek, tetapi kunci, masa berlaku, dan kebijakan pengiriman perlu ditetapkan saat implementasi.
- Pembayaran daring dalam baseline adalah Dummy QRIS Service Ride. Ekspedisi dan nomor resi marketplace dimasukkan manual. `LocationStream` merepresentasikan penyiaran SSE, sedangkan titik lokasi disimpan di PostGIS.
- `db_schema.sql` mempunyai constraint komposit yang tidak dapat diekspresikan lengkap oleh notasi ERD atribut Mermaid: `vehicle_owner_plate_unique`, `workshop_member_role_unique`, `product_workshop_sku_unique`, `marketplace_transaction_product_unique`, `booking_product_unique`, `product_serial_unique`, dan `booking_pickup_leg_unique`. Aturan sumber tunggal pada `payment` dan `review`, serta aturan alokasi `product_stock`, tetap mengikuti SQL asli.

## Merender PNG

Jalankan `./render.sh` dari folder ini. Skrip memerlukan Mermaid CLI `mmdc`, membuat `hasil/` dengan struktur folder yang sama, dan memakai skala 4 serta latar putih. Jika diagram ERD terlalu besar untuk lingkungan lokal, jalankan `SCALE=3 ./render.sh` untuk mengurangi ukuran raster tanpa mengubah sumber `.mmd`.

## Referensi sintaks Mermaid

- [Class diagram](https://mermaid.js.org/syntax/classDiagram.html)
- [Sequence diagram](https://mermaid.js.org/syntax/sequenceDiagram.html)
- [Swimlanes](https://mermaid.js.org/syntax/swimlanes.html)
- [Entity relationship diagram](https://mermaid.js.org/syntax/entityRelationshipDiagram.html)
- [Flowchart dan bentuk data store](https://mermaid.js.org/syntax/flowchart.html)
