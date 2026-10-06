# DESKRIPSI PERANCANGAN PERANGKAT LUNAK

## ServiceRide

| Informasi | Keterangan |
|---|---|
| Nama Sistem | ServiceRide |
| Jenis Dokumen | Deskripsi Perancangan Perangkat Lunak |
| Singkatan | DPPL |
| Acuan | SKPL ServiceRide v1.0 |
| Versi | 1.0 |
| Status | Draft |

# 1. Pendahuluan

Dokumen Deskripsi Perancangan Perangkat Lunak atau DPPL ServiceRide menjelaskan rancangan teknis yang digunakan untuk merealisasikan kebutuhan yang telah didefinisikan pada SKPL ServiceRide.

ServiceRide merupakan sistem yang menghubungkan customer dengan bengkel untuk proses booking servis, troubleshooting awal, estimasi biaya, pickup dan delivery kendaraan, pemeriksaan kendaraan, monitoring servis, serta pembayaran.

Rancangan pada dokumen ini mencakup:

1. Arsitektur sistem.
2. Perancangan frontend.
3. Perancangan backend.
4. Perancangan database.
5. Entity Relationship Diagram.
6. Struktur komponen.
7. Perancangan API.
8. Sequence Diagram.
9. Activity Diagram.
10. Perancangan antarmuka.
11. Integrasi layanan eksternal.
12. Keamanan dan konsistensi data.
13. Struktur deployment.
14. Traceability terhadap SKPL.

Stack teknologi yang sudah ditetapkan pada project adalah frontend menggunakan React, Vite, TypeScript, Tailwind CSS, dan shadcn/ui. Backend menggunakan Golang dengan PostgreSQL, pgvector, Redis, dan sqlc.

Struktur database, endpoint API, pembagian module backend, dan penggunaan pgvector pada dokumen ini merupakan rancangan awal dan masih dapat direvisi ketika implementasi dimulai.

# 2. Prinsip Perancangan

ServiceRide dirancang menggunakan beberapa prinsip utama.

1. PostgreSQL menjadi sumber data utama atau source of truth.

2. Redis tidak digunakan sebagai penyimpanan permanen. Redis hanya digunakan untuk cache, rate limiting, temporary state, dan kebutuhan koordinasi yang tidak boleh menggantikan data PostgreSQL.

3. Frontend tidak melakukan akses langsung ke database.

4. Seluruh perubahan data bisnis dilakukan melalui backend.

5. Setiap fitur memiliki batas tanggung jawab yang jelas.

6. Perubahan status booking harus mengikuti alur status yang valid.

7. Penambahan biaya servis tidak boleh langsung dianggap disetujui customer.

8. Pembayaran harus dapat diverifikasi berdasarkan transaksi dari Payment Provider.

9. Pickup dan delivery harus memiliki informasi driver serta pencatatan serah terima kendaraan.

10. Aktivitas penting harus memiliki riwayat agar dapat ditelusuri.

Prinsip tersebut juga mempertimbangkan risiko proyek yang telah diidentifikasi, khususnya keamanan kendaraan saat pickup, perubahan estimasi biaya, keterlambatan pelayanan, dan ketergantungan terhadap third party.

# 3. Arsitektur Sistem

ServiceRide menggunakan arsitektur client server dengan backend sebagai pusat business logic.

```mermaid
flowchart TB

    subgraph CLIENT["Client Layer"]
        WEB["Web Application<br/>React + Vite + TypeScript"]
        MOBILE["Mobile Application<br/>Future / TBD"]
    end

    subgraph BACKEND["Backend Service - Golang"]
        API["HTTP API"]
        AUTH["Authentication & Authorization"]
        BUSINESS["Business Logic"]
        INTEGRATION["External Integration Layer"]
    end

    subgraph DATA["Data Layer"]
        PG["PostgreSQL"]
        VECTOR["pgvector"]
        REDIS["Redis"]
    end

    subgraph EXTERNAL["External Services"]
        PAYMENT["Payment Provider"]
        LOCATION["Location Service"]
        PUSH["Push Notification Service"]
    end

    WEB --> API
    MOBILE --> API

    API --> AUTH
    API --> BUSINESS

    BUSINESS --> PG
    BUSINESS --> VECTOR
    BUSINESS --> REDIS

    BUSINESS --> INTEGRATION

    INTEGRATION --> PAYMENT
    INTEGRATION --> LOCATION
    INTEGRATION --> PUSH
```

Frontend bertanggung jawab pada presentation layer dan interaksi pengguna.

Backend bertanggung jawab atas:

1. Validasi request.
2. Authorization.
3. Business rules.
4. Pengelolaan booking.
5. Pemeriksaan kendaraan.
6. Pengelolaan estimasi dan persetujuan biaya.
7. Pickup dan delivery.
8. Pembayaran.
9. Notifikasi.
10. Integrasi third party.
11. Penyimpanan data.

PostgreSQL menjadi penyimpanan utama, sedangkan Redis menjadi komponen pendukung.

# 4. Perancangan Frontend

Frontend ServiceRide menggunakan pendekatan feature based agar masing masing domain dapat dikembangkan secara terpisah.

```mermaid
flowchart TB

    APP["Application"]

    APP --> ROUTER["Routing"]
    APP --> AUTH["Authentication State"]
    APP --> FEATURES["Feature Modules"]
    APP --> SHARED["Shared Components"]
    APP --> API["API Client"]

    FEATURES --> VEHICLE["Vehicle"]
    FEATURES --> WORKSHOP["Workshop"]
    FEATURES --> TROUBLE["Troubleshooting"]
    FEATURES --> BOOKING["Booking"]
    FEATURES --> SERVICE["Service Tracking"]
    FEATURES --> PAYMENT["Payment"]
    FEATURES --> PROFILE["Profile"]

    SHARED --> UI["shadcn/ui"]
    SHARED --> FORM["Form Components"]
    SHARED --> TABLE["Table Components"]
    SHARED --> MODAL["Dialog / Modal"]
    SHARED --> MAP["Map Components"]

    API --> BACKEND["ServiceRide Backend API"]
```

Struktur frontend yang disarankan:

```text
src/
  app/
  components/
  features/
    auth/
    vehicles/
    workshops/
    troubleshooting/
    bookings/
    service/
    transport/
    payments/
    notifications/
  lib/
  services/
  types/
  hooks/
```

Business rules tidak ditempatkan pada komponen UI.

Frontend hanya bertanggung jawab terhadap:

1. Menampilkan data.
2. Mengambil input pengguna.
3. Validasi dasar input.
4. Mengirim request.
5. Menampilkan response dan error.

Validasi final tetap dilakukan oleh backend.

# 5. Perancangan Backend

Backend dirancang menggunakan modular layered architecture.

```mermaid
flowchart LR

    HTTP["HTTP Request"]

    HANDLER["Handler Layer"]
    SERVICE["Service / Use Case Layer"]
    REPO["Repository Layer"]
    SQLC["sqlc"]
    DB["PostgreSQL"]

    ADAPTER["External Adapter"]
    THIRD["Third Party"]

    CACHE["Cache Layer"]
    REDIS["Redis"]

    HTTP --> HANDLER
    HANDLER --> SERVICE

    SERVICE --> REPO
    REPO --> SQLC
    SQLC --> DB

    SERVICE --> CACHE
    CACHE --> REDIS

    SERVICE --> ADAPTER
    ADAPTER --> THIRD
```

Pembagian tanggung jawab:

| Layer | Tanggung Jawab |
|---|---|
| Handler | Menerima HTTP request, parsing input, dan menghasilkan HTTP response |
| Service / Use Case | Menjalankan business logic dan aturan bisnis |
| Repository | Interface akses data |
| sqlc | Menjalankan query PostgreSQL dengan generated code |
| Adapter | Menghubungkan backend dengan layanan pihak ketiga |
| Cache | Mengelola data sementara pada Redis |

Module utama backend dirancang sebagai:

1. Auth.
2. User.
3. Vehicle.
4. Workshop.
5. Service Catalog.
6. Troubleshooting.
7. Booking.
8. Inspection.
9. Quotation.
10. Service Job.
11. Transport.
12. Billing.
13. Payment.
14. Notification.
15. Support.

# 6. Perancangan Database

Database utama menggunakan PostgreSQL.

Primary key disarankan menggunakan UUID agar identifier tidak bergantung pada sequence yang mudah ditebak dan lebih aman digunakan pada distributed environment.

Penggunaan UUID merupakan keputusan desain awal dan masih dapat direvisi sebelum database migration dibuat.

## 6.1 Identity dan Workshop

```mermaid
erDiagram

    USERS {
        uuid id PK
        varchar full_name
        varchar email UK
        varchar phone
        varchar password_hash
        varchar status
        timestamptz created_at
        timestamptz updated_at
    }

    ROLES {
        smallint id PK
        varchar code UK
        varchar name
    }

    USER_ROLES {
        uuid user_id FK
        smallint role_id FK
    }

    WORKSHOPS {
        uuid id PK
        varchar name
        varchar phone
        text address
        decimal latitude
        decimal longitude
        varchar status
        timestamptz created_at
        timestamptz updated_at
    }

    WORKSHOP_MEMBERS {
        uuid id PK
        uuid workshop_id FK
        uuid user_id FK
        varchar role
        varchar status
        timestamptz joined_at
    }

    WORKSHOP_OPERATING_HOURS {
        uuid id PK
        uuid workshop_id FK
        smallint day_of_week
        time open_time
        time close_time
        boolean is_closed
    }

    WORKSHOP_SLOTS {
        uuid id PK
        uuid workshop_id FK
        timestamptz start_at
        timestamptz end_at
        integer capacity
        varchar status
    }

    VEHICLES {
        uuid id PK
        uuid customer_id FK
        varchar vehicle_type
        varchar brand
        varchar model
        integer manufacture_year
        varchar license_plate
        varchar transmission
        bigint odometer
        text notes
        timestamptz created_at
    }

    SERVICES {
        uuid id PK
        uuid workshop_id FK
        varchar name
        text description
        varchar vehicle_category
        decimal base_price
        integer estimated_duration_minute
        boolean is_active
    }

    USERS ||--o{ USER_ROLES : has
    ROLES ||--o{ USER_ROLES : assigned

    USERS ||--o{ VEHICLES : owns

    WORKSHOPS ||--o{ WORKSHOP_MEMBERS : contains
    USERS ||--o{ WORKSHOP_MEMBERS : joins

    WORKSHOPS ||--o{ WORKSHOP_OPERATING_HOURS : defines
    WORKSHOPS ||--o{ WORKSHOP_SLOTS : provides
    WORKSHOPS ||--o{ SERVICES : provides
```

`WORKSHOP_MEMBERS` digunakan untuk menentukan hubungan user dengan bengkel.

Contohnya satu user dapat menjadi:

1. Owner pada bengkel A.
2. Admin pada bengkel A.
3. Mechanic pada bengkel B.

Dengan demikian role operasional bengkel tidak disimpan langsung sebagai satu kolom pada `USERS`.

# 7. ERD Booking dan Servis

```mermaid
erDiagram

    BOOKINGS {
        uuid id PK
        varchar booking_code UK
        uuid customer_id FK
        uuid vehicle_id FK
        uuid workshop_id FK
        uuid workshop_slot_id FK
        varchar delivery_method
        text complaint
        varchar status
        decimal initial_estimate
        timestamptz scheduled_at
        timestamptz created_at
        timestamptz updated_at
    }

    BOOKING_SERVICES {
        uuid id PK
        uuid booking_id FK
        uuid service_id FK
        integer quantity
        decimal unit_price
        decimal subtotal
    }

    SERVICES {
        uuid id PK
        uuid workshop_id FK
        varchar name
        decimal base_price
    }

    INSPECTIONS {
        uuid id PK
        uuid booking_id FK
        uuid mechanic_id FK
        text summary
        timestamptz inspected_at
    }

    INSPECTION_ITEMS {
        uuid id PK
        uuid inspection_id FK
        varchar component
        varchar condition
        text recommendation
        boolean action_required
    }

    QUOTES {
        uuid id PK
        uuid booking_id FK
        integer version
        uuid created_by FK
        decimal subtotal
        decimal transport_fee
        decimal other_fee
        decimal total
        varchar status
        timestamptz created_at
    }

    QUOTE_ITEMS {
        uuid id PK
        uuid quote_id FK
        varchar item_type
        varchar description
        integer quantity
        decimal unit_price
        decimal subtotal
    }

    QUOTE_APPROVALS {
        uuid id PK
        uuid quote_id FK
        uuid customer_id FK
        varchar decision
        text reason
        timestamptz decided_at
    }

    SERVICE_JOBS {
        uuid id PK
        uuid booking_id FK
        uuid mechanic_id FK
        varchar name
        text description
        varchar status
        timestamptz started_at
        timestamptz completed_at
    }

    BOOKING_STATUS_HISTORY {
        uuid id PK
        uuid booking_id FK
        varchar previous_status
        varchar new_status
        uuid changed_by FK
        text notes
        timestamptz created_at
    }

    BOOKINGS ||--o{ BOOKING_SERVICES : contains
    SERVICES ||--o{ BOOKING_SERVICES : selected

    BOOKINGS ||--o{ INSPECTIONS : inspected
    INSPECTIONS ||--o{ INSPECTION_ITEMS : contains

    BOOKINGS ||--o{ QUOTES : receives
    QUOTES ||--|{ QUOTE_ITEMS : contains
    QUOTES ||--o{ QUOTE_APPROVALS : approval

    BOOKINGS ||--o{ SERVICE_JOBS : contains
    BOOKINGS ||--o{ BOOKING_STATUS_HISTORY : records
```

Pemisahan `QUOTES` dan `QUOTE_ITEMS` diperlukan karena satu booking dapat memperoleh lebih dari satu versi estimasi.

Contoh:

1. Quote versi 1 dibuat berdasarkan booking awal.
2. Kendaraan diperiksa.
3. Mekanik menemukan kampas rem harus diganti.
4. Quote versi 2 dibuat.
5. Customer menerima quote versi 2.
6. Quote versi 2 menjadi dasar pekerjaan tambahan.

Quote lama tetap disimpan untuk kebutuhan audit.

# 8. ERD Pickup, Delivery, dan Pembayaran

```mermaid
erDiagram

    BOOKINGS {
        uuid id PK
        varchar booking_code
        varchar status
    }

    TRANSPORT_TASKS {
        uuid id PK
        uuid booking_id FK
        uuid driver_id FK
        varchar task_type
        text origin_address
        decimal origin_latitude
        decimal origin_longitude
        text destination_address
        decimal destination_latitude
        decimal destination_longitude
        timestamptz scheduled_at
        timestamptz started_at
        timestamptz completed_at
        varchar status
    }

    HANDOVER_RECORDS {
        uuid id PK
        uuid transport_task_id FK
        uuid recorded_by FK
        bigint odometer
        varchar fuel_level
        text vehicle_condition
        text notes
        timestamptz handed_over_at
    }

    INVOICES {
        uuid id PK
        uuid booking_id FK
        uuid quote_id FK
        varchar invoice_number UK
        decimal total_amount
        varchar status
        timestamptz issued_at
        timestamptz paid_at
    }

    PAYMENTS {
        uuid id PK
        uuid invoice_id FK
        varchar provider
        varchar external_reference UK
        varchar payment_method
        decimal amount
        varchar status
        timestamptz created_at
        timestamptz paid_at
    }

    NOTIFICATIONS {
        uuid id PK
        uuid user_id FK
        uuid booking_id FK
        varchar channel
        varchar type
        varchar title
        text message
        varchar status
        timestamptz sent_at
        timestamptz read_at
    }

    BOOKINGS ||--o{ TRANSPORT_TASKS : transport
    TRANSPORT_TASKS ||--o{ HANDOVER_RECORDS : records

    BOOKINGS ||--o| INVOICES : billed
    INVOICES ||--o{ PAYMENTS : payment_attempt

    BOOKINGS ||--o{ NOTIFICATIONS : generates
```

Satu booking dapat mempunyai dua `TRANSPORT_TASKS`.

Contoh:

1. `PICKUP`: customer menuju bengkel.
2. `DELIVERY`: bengkel menuju customer.

Keduanya tidak digabung menjadi satu record karena driver, waktu, rute, dan status keduanya dapat berbeda.

# 9. ERD Troubleshooting

PostgreSQL pada project telah direncanakan menggunakan pgvector.

Rancangan awal penggunaan pgvector adalah membantu pencarian pengetahuan troubleshooting berdasarkan kemiripan gejala.

```mermaid
erDiagram

    TROUBLESHOOTING_SESSIONS {
        uuid id PK
        uuid customer_id FK
        uuid vehicle_id FK
        text complaint
        text result_summary
        timestamptz created_at
    }

    DIAGNOSTIC_KNOWLEDGE {
        uuid id PK
        varchar title
        varchar vehicle_category
        text symptom_text
        text recommendation
        vector embedding
        boolean is_active
    }

    TROUBLESHOOTING_MATCHES {
        uuid id PK
        uuid session_id FK
        uuid knowledge_id FK
        decimal similarity_score
    }

    TROUBLESHOOTING_SESSIONS ||--o{ TROUBLESHOOTING_MATCHES : produces
    DIAGNOSTIC_KNOWLEDGE ||--o{ TROUBLESHOOTING_MATCHES : matched
```

Hasil troubleshooting tetap hanya bersifat informasi awal sebagaimana ditentukan pada SKPL.

Hasil tersebut tidak boleh menggantikan diagnosis dari mekanik.

# 10. Relasi dan Constraint Krusial

Beberapa constraint perlu diterapkan sejak database dan service layer dibuat.

1. Kendaraan pada booking harus dimiliki customer yang membuat booking.

2. Service yang dipilih harus berasal dari workshop yang sama dengan booking.

3. Workshop slot harus berasal dari workshop yang sama dengan booking.

4. Jumlah booking aktif tidak boleh melebihi kapasitas slot.

5. Mechanic yang menerima pekerjaan harus merupakan member aktif pada workshop tersebut.

6. Driver yang menerima transport task harus merupakan member aktif pada workshop tersebut.

7. Customer hanya dapat memberikan approval terhadap quote dari booking miliknya.

8. Quote yang telah digantikan versi baru tidak boleh menjadi dasar invoice kecuali kembali diaktifkan melalui proses yang sah.

9. Pekerjaan tambahan yang menambah biaya hanya dapat dilakukan setelah quote mendapatkan approval customer.

10. Invoice hanya dibuat berdasarkan quote final yang telah disetujui.

11. Nilai payment harus mengacu pada invoice.

12. `external_reference` pada payment harus unique untuk mencegah transaksi yang sama diproses lebih dari satu kali.

13. Payment callback atau webhook harus diproses secara idempotent.

14. Perubahan status booking harus disimpan pada `BOOKING_STATUS_HISTORY`.

15. Redis tidak boleh menjadi satu satunya tempat penyimpanan status booking, payment, atau servis.

# 11. Struktur Komponen Backend

```mermaid
flowchart TB

    API["API Layer"]

    API --> AUTH["Auth Module"]
    API --> USER["User Module"]
    API --> VEHICLE["Vehicle Module"]
    API --> WORKSHOP["Workshop Module"]
    API --> TROUBLE["Troubleshooting Module"]
    API --> BOOKING["Booking Module"]
    API --> INSPECTION["Inspection Module"]
    API --> QUOTE["Quotation Module"]
    API --> JOB["Service Job Module"]
    API --> TRANSPORT["Transport Module"]
    API --> BILLING["Billing Module"]
    API --> PAYMENT["Payment Module"]
    API --> NOTIFICATION["Notification Module"]
    API --> SUPPORT["Support Module"]

    BOOKING --> WORKSHOP
    BOOKING --> VEHICLE

    INSPECTION --> BOOKING
    QUOTE --> INSPECTION
    JOB --> QUOTE

    TRANSPORT --> BOOKING

    BILLING --> QUOTE
    PAYMENT --> BILLING

    NOTIFICATION --> BOOKING
    NOTIFICATION --> PAYMENT

    TROUBLE --> VECTOR["Vector Repository"]
```

Dependensi antar module dibuat satu arah untuk mengurangi coupling.

Contohnya `Payment Module` tidak mengubah booking secara langsung melalui database.

Alur yang disarankan:

`Payment → Billing Service → Booking Service`

Dengan pendekatan tersebut business rule perubahan booking tetap berada pada Booking Service.

# 12. Perancangan API

API berikut merupakan rancangan awal REST API.

## 12.1 Authentication dan User

| Method | Endpoint | Fungsi |
|---|---|---|
| POST | `/api/v1/auth/register` | Registrasi akun |
| POST | `/api/v1/auth/login` | Login |
| POST | `/api/v1/auth/logout` | Logout |
| GET | `/api/v1/me` | Mendapatkan profil pengguna |
| PATCH | `/api/v1/me` | Memperbarui profil |

Mekanisme session atau access token belum ditetapkan pada sumber project dan harus diputuskan sebelum implementasi authentication dimulai.

## 12.2 Vehicle

| Method | Endpoint | Fungsi |
|---|---|---|
| GET | `/api/v1/vehicles` | Daftar kendaraan customer |
| POST | `/api/v1/vehicles` | Menambahkan kendaraan |
| GET | `/api/v1/vehicles/{id}` | Detail kendaraan |
| PATCH | `/api/v1/vehicles/{id}` | Memperbarui kendaraan |
| DELETE | `/api/v1/vehicles/{id}` | Menghapus atau menonaktifkan kendaraan |

## 12.3 Workshop

| Method | Endpoint | Fungsi |
|---|---|---|
| GET | `/api/v1/workshops` | Pencarian bengkel |
| GET | `/api/v1/workshops/{id}` | Detail bengkel |
| GET | `/api/v1/workshops/{id}/services` | Daftar layanan |
| GET | `/api/v1/workshops/{id}/slots` | Jadwal tersedia |
| POST | `/api/v1/workshops/{id}/services` | Menambahkan layanan |
| PATCH | `/api/v1/workshops/{id}` | Memperbarui informasi bengkel |

## 12.4 Troubleshooting

| Method | Endpoint | Fungsi |
|---|---|---|
| POST | `/api/v1/troubleshooting` | Membuat troubleshooting session |
| GET | `/api/v1/troubleshooting/{id}` | Melihat hasil troubleshooting |

## 12.5 Booking

| Method | Endpoint | Fungsi |
|---|---|---|
| GET | `/api/v1/bookings` | Daftar booking pengguna |
| POST | `/api/v1/bookings` | Membuat booking |
| GET | `/api/v1/bookings/{id}` | Detail booking |
| POST | `/api/v1/bookings/{id}/accept` | Bengkel menerima booking |
| POST | `/api/v1/bookings/{id}/cancel` | Membatalkan booking |
| GET | `/api/v1/bookings/{id}/history` | Riwayat perubahan status |

## 12.6 Inspection dan Quotation

| Method | Endpoint | Fungsi |
|---|---|---|
| POST | `/api/v1/bookings/{id}/inspections` | Membuat hasil pemeriksaan |
| GET | `/api/v1/bookings/{id}/inspections` | Melihat pemeriksaan |
| POST | `/api/v1/bookings/{id}/quotes` | Membuat quote |
| GET | `/api/v1/bookings/{id}/quotes` | Daftar quote |
| POST | `/api/v1/quotes/{id}/approve` | Customer menerima quote |
| POST | `/api/v1/quotes/{id}/reject` | Customer menolak quote |

## 12.7 Service Job

| Method | Endpoint | Fungsi |
|---|---|---|
| GET | `/api/v1/mechanic/jobs` | Daftar pekerjaan mekanik |
| GET | `/api/v1/mechanic/jobs/{id}` | Detail pekerjaan |
| POST | `/api/v1/mechanic/jobs/{id}/start` | Memulai servis |
| POST | `/api/v1/mechanic/jobs/{id}/complete` | Menyelesaikan servis |

## 12.8 Transport

| Method | Endpoint | Fungsi |
|---|---|---|
| GET | `/api/v1/driver/tasks` | Daftar pickup atau delivery |
| GET | `/api/v1/driver/tasks/{id}` | Detail tugas |
| POST | `/api/v1/driver/tasks/{id}/start` | Memulai perjalanan |
| POST | `/api/v1/driver/tasks/{id}/handover` | Mencatat serah terima |
| POST | `/api/v1/driver/tasks/{id}/complete` | Menyelesaikan tugas |

## 12.9 Payment

| Method | Endpoint | Fungsi |
|---|---|---|
| GET | `/api/v1/bookings/{id}/invoice` | Mendapatkan invoice |
| POST | `/api/v1/invoices/{id}/payments` | Membuat pembayaran |
| GET | `/api/v1/payments/{id}` | Melihat status pembayaran |
| POST | `/api/v1/webhooks/payment` | Callback Payment Provider |

Endpoint webhook tidak menggunakan authorization pengguna biasa.

Keaslian request harus diverifikasi menggunakan mekanisme signature yang disediakan Payment Provider.

# 13. Sequence Diagram Booking Servis

```mermaid
sequenceDiagram
    actor Customer
    participant FE as Frontend
    participant API as Backend API
    participant Booking as Booking Service
    participant Workshop as Workshop Service
    participant DB as PostgreSQL

    Customer->>FE: Pilih kendaraan, bengkel, layanan, jadwal
    FE->>API: POST /bookings
    API->>Booking: CreateBooking()

    Booking->>Workshop: ValidateWorkshopAndSlot()
    Workshop->>DB: Check service dan slot
    DB-->>Workshop: Data availability
    Workshop-->>Booking: Valid

    Booking->>DB: Validate vehicle ownership
    DB-->>Booking: Valid

    Booking->>DB: Insert booking
    Booking->>DB: Insert booking services
    Booking->>DB: Insert status history

    DB-->>Booking: Success
    Booking-->>API: Booking created
    API-->>FE: 201 Created
    FE-->>Customer: Booking berhasil dibuat
```

# 14. Sequence Diagram Pemeriksaan dan Persetujuan Biaya

```mermaid
sequenceDiagram
    actor Mechanic
    actor Customer

    participant FE as Application
    participant API as Backend API
    participant Inspection as Inspection Service
    participant Quote as Quotation Service
    participant Booking as Booking Service
    participant Notification as Notification Service
    participant DB as PostgreSQL

    Mechanic->>FE: Input hasil pemeriksaan
    FE->>API: POST /bookings/{id}/inspections
    API->>Inspection: CreateInspection()
    Inspection->>DB: Save inspection

    Mechanic->>FE: Buat rincian pekerjaan
    FE->>API: POST /bookings/{id}/quotes
    API->>Quote: CreateQuote()
    Quote->>DB: Save quote dan quote items

    Quote->>Booking: Change status WAITING_APPROVAL
    Booking->>DB: Update booking status

    Quote->>Notification: Notify customer
    Notification-->>Customer: Rincian biaya baru

    Customer->>FE: Approve quote
    FE->>API: POST /quotes/{id}/approve
    API->>Quote: ApproveQuote()
    Quote->>DB: Save approval

    Quote->>Booking: Continue service
    Booking->>DB: Update status

    API-->>FE: Approval accepted
```

# 15. Sequence Diagram Pickup Kendaraan

```mermaid
sequenceDiagram
    actor Admin
    actor Driver
    actor Customer

    participant API as Backend API
    participant Transport as Transport Service
    participant Location as Location Service
    participant DB as PostgreSQL

    Admin->>API: Assign driver
    API->>Transport: AssignDriver()

    Transport->>DB: Validate driver membership
    DB-->>Transport: Valid

    Transport->>DB: Save assignment

    Driver->>API: Start pickup
    API->>Transport: StartTask()

    Transport->>Location: Request route
    Location-->>Transport: Route information

    Transport->>DB: Update IN_PROGRESS

    Driver->>Customer: Pickup kendaraan

    Driver->>API: Submit handover
    API->>Transport: RecordHandover()

    Transport->>DB: Save handover record

    Driver->>API: Complete pickup
    Transport->>DB: Update COMPLETED
```

# 16. Sequence Diagram Pembayaran

```mermaid
sequenceDiagram
    actor Customer

    participant FE as Frontend
    participant API as Backend API
    participant Billing as Billing Service
    participant Payment as Payment Service
    participant Provider as Payment Provider
    participant DB as PostgreSQL

    Customer->>FE: Pilih pembayaran
    FE->>API: POST /invoices/{id}/payments

    API->>Billing: Validate invoice
    Billing->>DB: Get invoice
    DB-->>Billing: Invoice unpaid

    API->>Payment: CreatePayment()
    Payment->>Provider: Create transaction

    Provider-->>Payment: Transaction reference
    Payment->>DB: Save PENDING payment

    Payment-->>API: Payment instruction
    API-->>FE: Payment information

    Provider->>API: Payment webhook
    API->>Payment: Verify webhook

    Payment->>DB: Check external reference

    alt payment belum diproses
        Payment->>DB: Update payment PAID
        Payment->>Billing: MarkInvoicePaid()
        Billing->>DB: Update invoice PAID
    else webhook duplicate
        Payment-->>Provider: Ignore duplicate safely
    end
```

# 17. Activity Diagram Proses Servis

```mermaid
flowchart TD

    START([Mulai])

    A["Customer memilih kendaraan"]
    B["Pilih bengkel dan layanan"]
    C["Pilih jadwal"]
    D["Buat booking"]
    E{"Booking diterima?"}

    F["Booking dibatalkan"]
    G{"Menggunakan pickup?"}

    H["Driver mengambil kendaraan"]
    I["Customer membawa kendaraan"]
    J["Kendaraan diterima bengkel"]

    K["Mekanik melakukan pemeriksaan"]
    L{"Ada perubahan biaya?"}

    M["Kirim quote baru"]
    N{"Customer menyetujui?"}
    O["Servis sesuai pekerjaan disetujui"]
    P["Pekerjaan tambahan tidak dilakukan"]

    Q["Servis selesai"]
    R["Buat invoice"]
    S["Customer melakukan pembayaran"]
    T{"Delivery?"}

    U["Driver mengantar kendaraan"]
    V["Customer mengambil kendaraan"]

    W["Booking selesai"]

    END([Selesai])

    START --> A
    A --> B
    B --> C
    C --> D
    D --> E

    E -- Tidak --> F
    F --> END

    E -- Ya --> G

    G -- Ya --> H
    G -- Tidak --> I

    H --> J
    I --> J

    J --> K
    K --> L

    L -- Ya --> M
    M --> N

    N -- Ya --> O
    N -- Tidak --> P

    L -- Tidak --> O
    P --> O

    O --> Q
    Q --> R
    R --> S
    S --> T

    T -- Ya --> U
    T -- Tidak --> V

    U --> W
    V --> W
    W --> END
```

# 18. State Diagram Booking

Perubahan status booking tidak dilakukan secara bebas.

```mermaid
stateDiagram-v2

    [*] --> PENDING

    PENDING --> ACCEPTED
    PENDING --> CANCELLED

    ACCEPTED --> WAITING_PICKUP
    ACCEPTED --> VEHICLE_RECEIVED

    WAITING_PICKUP --> PICKUP_IN_PROGRESS
    PICKUP_IN_PROGRESS --> VEHICLE_RECEIVED

    VEHICLE_RECEIVED --> INSPECTION

    INSPECTION --> WAITING_APPROVAL
    INSPECTION --> SERVICE_IN_PROGRESS

    WAITING_APPROVAL --> SERVICE_IN_PROGRESS
    WAITING_APPROVAL --> SERVICE_ADJUSTED

    SERVICE_ADJUSTED --> SERVICE_IN_PROGRESS

    SERVICE_IN_PROGRESS --> SERVICE_COMPLETED

    SERVICE_COMPLETED --> WAITING_PAYMENT

    WAITING_PAYMENT --> PAID

    PAID --> WAITING_DELIVERY
    PAID --> COMPLETED

    WAITING_DELIVERY --> DELIVERY_IN_PROGRESS
    DELIVERY_IN_PROGRESS --> COMPLETED

    COMPLETED --> [*]
    CANCELLED --> [*]
```

Backend harus menolak perubahan status yang tidak mempunyai transition valid.

Contoh:

`PENDING → SERVICE_COMPLETED`

harus ditolak.

# 19. Perancangan Interface

Perancangan UI pada DPPL difokuskan pada struktur layar dan kebutuhan informasi, bukan desain visual akhir.

## 19.1 Customer

### Dashboard

Menampilkan:

1. Kendaraan milik customer.
2. Booking aktif.
3. Status servis terbaru.
4. Notifikasi.
5. Shortcut pencarian bengkel.

### Daftar Bengkel

Menampilkan:

1. Nama bengkel.
2. Lokasi.
3. Jarak.
4. Jam operasional.
5. Jenis kendaraan yang dilayani.
6. Layanan tersedia.

### Detail Bengkel

Menampilkan:

1. Informasi bengkel.
2. Lokasi.
3. Jam operasional.
4. Daftar layanan.
5. Estimasi harga.
6. Jadwal tersedia.
7. Tombol booking.

### Booking

Form booking terdiri dari:

1. Kendaraan.
2. Bengkel.
3. Layanan.
4. Keluhan.
5. Jadwal.
6. Pickup atau datang langsung.
7. Estimasi biaya awal.

### Detail Booking

Menampilkan:

1. Booking code.
2. Kendaraan.
3. Bengkel.
4. Jadwal.
5. Status.
6. Status history.
7. Mekanik apabila telah ditentukan.
8. Driver apabila menggunakan pickup.
9. Pemeriksaan.
10. Quote.
11. Approval.
12. Invoice.
13. Payment.

## 19.2 Admin Bengkel

Dashboard admin menyediakan:

1. Booking hari ini.
2. Booking menunggu persetujuan.
3. Kendaraan sedang diservis.
4. Pickup aktif.
5. Mekanik tersedia.
6. Driver tersedia.

Admin juga mempunyai halaman:

1. Booking.
2. Jadwal.
3. Service catalog.
4. Mekanik.
5. Driver.
6. Pickup dan delivery.
7. Workshop settings.

## 19.3 Mekanik

Mekanik mempunyai tampilan yang lebih sederhana.

Fungsi utama:

1. Melihat pekerjaan.
2. Membuka detail kendaraan.
3. Melihat keluhan.
4. Menginput pemeriksaan.
5. Menginput pekerjaan tambahan.
6. Memulai servis.
7. Menyelesaikan servis.

## 19.4 Driver

Driver mempunyai halaman:

1. Daftar tugas.
2. Detail pickup.
3. Detail delivery.
4. Navigasi lokasi.
5. Konfirmasi serah terima.
6. Status perjalanan.

# 20. Integrasi Location Service

Location Service digunakan untuk:

1. Mendapatkan koordinat.
2. Menampilkan lokasi bengkel.
3. Menghitung jarak.
4. Membantu rute pickup.
5. Membantu rute delivery.

Backend tidak boleh bergantung langsung pada format response provider.

Digunakan adapter internal:

```mermaid
flowchart LR

    BUSINESS["Transport / Workshop Service"]
    INTERFACE["Location Provider Interface"]

    PROVIDER_A["Location Provider A"]
    PROVIDER_B["Future Provider"]

    BUSINESS --> INTERFACE

    INTERFACE --> PROVIDER_A
    INTERFACE --> PROVIDER_B
```

Dengan pola tersebut penggantian provider tidak membutuhkan perubahan pada seluruh business logic.

Hal ini penting karena perubahan harga atau kebijakan Maps API telah diidentifikasi sebagai risiko proyek.

# 21. Integrasi Payment Provider

Backend menyediakan adapter payment.

Business logic tidak menggunakan SDK payment langsung pada Billing Service.

```mermaid
flowchart LR

    BILLING["Billing Service"]
    PAYMENT["Payment Service"]
    ADAPTER["Payment Provider Adapter"]
    PROVIDER["Payment Provider"]

    BILLING --> PAYMENT
    PAYMENT --> ADAPTER
    ADAPTER --> PROVIDER
```

Payment Provider harus memberikan identifier transaksi yang disimpan pada `external_reference`.

Webhook harus melalui proses:

1. Verifikasi authenticity.
2. Verifikasi transaction reference.
3. Verifikasi nominal.
4. Verifikasi invoice.
5. Idempotency check.
6. Update payment.
7. Update invoice.
8. Update booking jika diperlukan.

# 22. Integrasi Notification

Notification Service digunakan sebagai satu pintu pengiriman notifikasi.

```mermaid
flowchart LR

    BOOKING["Booking"]
    QUOTE["Quotation"]
    PAYMENT["Payment"]
    TRANSPORT["Transport"]

    NOTIFICATION["Notification Service"]
    PROVIDER["Push Notification Provider"]

    BOOKING --> NOTIFICATION
    QUOTE --> NOTIFICATION
    PAYMENT --> NOTIFICATION
    TRANSPORT --> NOTIFICATION

    NOTIFICATION --> PROVIDER
```

Contoh event:

1. Booking diterima.
2. Driver ditugaskan.
3. Kendaraan diterima bengkel.
4. Quote baru tersedia.
5. Quote disetujui.
6. Servis dimulai.
7. Servis selesai.
8. Invoice tersedia.
9. Payment berhasil.
10. Kendaraan sedang diantar.

# 23. Penggunaan Redis

Redis digunakan sebagai supporting infrastructure.

Penggunaan awal yang disarankan:

1. Rate limiting API.
2. Cache data workshop.
3. Cache service catalog.
4. Cache availability yang sering dibaca.
5. Temporary authentication state apabila mekanisme authentication membutuhkannya.
6. Distributed locking pada proses tertentu apabila kemudian diperlukan.

Data berikut tidak boleh hanya disimpan di Redis:

1. Booking.
2. Quote.
3. Approval.
4. Service status.
5. Invoice.
6. Payment.
7. Handover kendaraan.

# 24. Security Design

## 24.1 Authentication

Backend harus memverifikasi identitas pengguna sebelum memberikan akses terhadap resource private.

Teknologi authentication final belum ditentukan pada sumber project sehingga pemilihan session atau token masih menjadi keputusan implementasi.

## 24.2 Authorization

ServiceRide menggunakan Role Based Access Control.

Contoh:

| Resource | Customer | Admin | Mekanik | Driver |
|---|---:|---:|---:|---:|
| Kendaraan sendiri | Read/Write | No | Read terbatas | Read terbatas |
| Booking customer | Read/Write terbatas | Read/Write | Read terbatas | Read terbatas |
| Pemeriksaan | Read | Read | Write | No |
| Quote | Approve | Write | Draft/Input | No |
| Service Job | Read | Manage | Write | No |
| Transport Task | Read | Manage | No | Write |
| Payment | Create/Read | Read | No | No |

Authorization juga harus memeriksa ownership.

Customer dengan role yang benar tetap tidak boleh mengakses booking milik customer lain.

## 24.3 Sensitive Data

Password tidak disimpan dalam bentuk plaintext.

Data sensitif tidak boleh dicatat langsung pada application log.

Contoh data yang harus dihindari dari log:

1. Password.
2. Authentication secret.
3. Payment credential.
4. Full payment token.

# 25. Data Consistency

Operasi yang mengubah beberapa tabel sekaligus harus menggunakan database transaction.

Contoh pembuatan booking:

```text
BEGIN

insert bookings
insert booking_services
insert booking_status_history
reserve workshop slot

COMMIT
```

Apabila salah satu operasi gagal:

```text
ROLLBACK
```

Prinsip yang sama berlaku pada:

1. Quote dan quote items.
2. Approval dan perubahan status.
3. Invoice.
4. Payment webhook.
5. Handover dan perubahan status transport.

# 26. Audit Trail

ServiceRide membutuhkan auditability karena terdapat perubahan status kendaraan dan biaya.

Minimal aktivitas berikut harus dapat ditelusuri:

1. Siapa yang menerima booking.
2. Siapa yang mengubah status.
3. Mekanik yang melakukan pemeriksaan.
4. Mekanik yang melakukan servis.
5. Siapa yang membuat quote.
6. Quote mana yang disetujui.
7. Siapa yang memberikan approval.
8. Driver yang mengambil kendaraan.
9. Driver yang mengembalikan kendaraan.
10. Status payment.

`BOOKING_STATUS_HISTORY` tidak boleh diperbarui untuk mengganti histori lama.

Setiap perubahan dibuat sebagai record baru.

# 27. Deployment Architecture

Deployment provider belum ditetapkan sehingga diagram berikut merupakan logical deployment architecture.

```mermaid
flowchart TB

    USER["User Device"]

    subgraph PUBLIC["Public Layer"]
        WEB["Web Frontend"]
        EDGE["Reverse Proxy / Load Balancer"]
    end

    subgraph APPLICATION["Application Layer"]
        API["ServiceRide Golang API"]
    end

    subgraph DATA["Data Layer"]
        PG["PostgreSQL + pgvector"]
        REDIS["Redis"]
    end

    subgraph THIRD["External Provider"]
        LOCATION["Location Service"]
        PAYMENT["Payment Provider"]
        PUSH["Push Notification"]
    end

    USER -->|HTTPS| WEB
    WEB -->|HTTPS API| EDGE

    EDGE --> API

    API --> PG
    API --> REDIS

    API --> LOCATION
    API --> PAYMENT
    API --> PUSH
```

Database tidak diekspos langsung ke jaringan publik.

Akses database hanya diberikan kepada backend atau komponen administrasi yang secara eksplisit diizinkan.

# 28. Traceability SKPL dan DPPL

Traceability digunakan agar kebutuhan pada SKPL dapat ditelusuri sampai komponen implementasinya.

| SKPL | Implementasi DPPL Utama |
|---|---|
| SKPL-F-001 | Auth Module, User, Role, Authorization |
| SKPL-F-002 | Vehicle Module, VEHICLES |
| SKPL-F-003 | Workshop Module, Location Adapter |
| SKPL-F-004 | WORKSHOPS, SERVICES |
| SKPL-F-005 | Troubleshooting Module, pgvector |
| SKPL-F-006 | Troubleshooting, Services, Quote |
| SKPL-F-007 | Booking Module, BOOKINGS |
| SKPL-F-008 | WORKSHOP_SLOTS |
| SKPL-F-009 | Transport Module |
| SKPL-F-010 | WORKSHOP_MEMBERS, TRANSPORT_TASKS |
| SKPL-F-011 | INSPECTIONS, INSPECTION_ITEMS |
| SKPL-F-012 | QUOTES, QUOTE_ITEMS |
| SKPL-F-013 | QUOTE_APPROVALS |
| SKPL-F-014 | Booking Service, BOOKING_STATUS_HISTORY |
| SKPL-F-015 | Booking Detail dan Status History |
| SKPL-F-016 | Invoice, Payment Module |
| SKPL-F-017 | Notification Service |
| SKPL-F-018 | Workshop Module |
| SKPL-F-019 | Booking Management |
| SKPL-F-020 | Support Module |

# 29. Keputusan yang Belum Final

Beberapa bagian belum mempunyai keputusan resmi dari dokumen project sebelumnya sehingga tidak ditetapkan secara permanen pada DPPL versi awal ini.

1. Mekanisme authentication antara session atau token.

2. Payment Provider yang akan digunakan.

3. Push Notification Provider.

4. Location Service final untuk setiap platform.

5. Cloud Provider.

6. Strategi realtime update, apabila nantinya diperlukan.

7. Detail deployment fisik dan jumlah instance.

8. Struktur final database setelah migration pertama dibuat.

9. Bentuk model atau metode yang digunakan pada troubleshooting.

10. Dimensi vector pada pgvector.

Perubahan terhadap bagian tersebut tidak otomatis mengubah requirement pada SKPL selama fungsi bisnis yang diberikan kepada pengguna tetap sama.

# 30. Kesimpulan

DPPL ServiceRide mendefinisikan rancangan awal sistem mulai dari frontend, backend, database, relasi data, API, proses booking, pemeriksaan, persetujuan biaya, pickup dan delivery, pembayaran, sampai deployment.

Rancangan dibuat dengan memisahkan domain utama ServiceRide sehingga perubahan pada satu bagian tidak secara langsung memengaruhi seluruh sistem.

Database PostgreSQL menjadi sumber data utama, Redis berfungsi sebagai infrastructure pendukung, dan pgvector disiapkan untuk kebutuhan pencarian berbasis vector pada proses troubleshooting.

Struktur booking, quote, approval, invoice, payment, transport, dan audit trail dipisahkan karena masing masing memiliki lifecycle berbeda dan merupakan bagian krusial dalam menjaga konsistensi proses ServiceRide.

DPPL ini menjadi baseline awal implementasi. Perubahan arsitektur, tabel, API, maupun provider eksternal harus tetap menjaga kesesuaian terhadap requirement yang telah ditentukan pada SKPL ServiceRide.
