-- Service Ride | 5 contoh data untuk masing-masing dari 19 tabel.
-- Jalankan db_schema.sql terlebih dahulu. Semua akun contoh memakai password_hash NULL.
-- Data demo; domain example.test bukan file/media sungguhan.
BEGIN;

-- user: 5 rows
INSERT INTO "user" (id, name, email, password_hash, phone_number, alternative_phone_number, profile, date_birth, gender, role, account_status, is_verified) VALUES
    ('00000000-0000-4000-8000-000100000001', 'Admin Service Ride', 'admin@service-ride.test', NULL, '08123456001', NULL, NULL, '1990-02-11', 'male', 'super_admin', 'active', TRUE),
    ('00000000-0000-4000-8000-000100000002', 'Dina Putri', 'dina@example.test', NULL, '08123456002', '081300000002', NULL, '1991-03-12', 'female', 'customer', 'active', TRUE),
    ('00000000-0000-4000-8000-000100000003', 'Rizky Firmansyah', 'rizky@example.test', NULL, '08123456003', NULL, NULL, '1992-04-13', 'male', 'workshop', 'active', TRUE),
    ('00000000-0000-4000-8000-000100000004', 'Agus Mekanik', 'agus@example.test', NULL, '08123456004', NULL, NULL, '1993-05-14', 'male', 'workshop', 'active', TRUE),
    ('00000000-0000-4000-8000-000100000005', 'Bayu Kurir', 'bayu@example.test', NULL, '08123456005', NULL, NULL, '1994-06-15', 'male', 'workshop', 'active', TRUE);

-- address: 5 rows
INSERT INTO address (id, id_user, name, province_id, city_id, full_address, geog, is_default) VALUES
    ('00000000-0000-4000-8000-000200000001', '00000000-0000-4000-8000-000100000002', 'Rumah', 35, 3576, 'Jalan Majapahit No. 10, Mojokerto', ST_GeogFromText('SRID=4326;POINT(112.4341 -7.4738)'), TRUE),
    ('00000000-0000-4000-8000-000200000002', '00000000-0000-4000-8000-000100000002', 'Kantor', 35, 3576, 'Jalan Gajah Mada No. 15, Mojokerto', ST_GeogFromText('SRID=4326;POINT(112.438 -7.469)'), FALSE),
    ('00000000-0000-4000-8000-000200000003', '00000000-0000-4000-8000-000100000002', 'Alamat Keluarga', 35, 3576, 'Jalan Benteng Pancasila No. 22, Mojokerto', ST_GeogFromText('SRID=4326;POINT(112.4471 -7.475)'), FALSE),
    ('00000000-0000-4000-8000-000200000004', '00000000-0000-4000-8000-000100000002', 'Alamat Pickup 2', 35, 3576, 'Jalan Empunala No. 9, Mojokerto', ST_GeogFromText('SRID=4326;POINT(112.451 -7.483)'), FALSE),
    ('00000000-0000-4000-8000-000200000005', '00000000-0000-4000-8000-000100000002', 'Alamat Pickup 3', 35, 3576, 'Jalan Pemuda No. 3, Mojokerto', ST_GeogFromText('SRID=4326;POINT(112.429 -7.478)'), FALSE);

-- vehicle: 5 rows
INSERT INTO vehicle (id, id_user, plate_number, brand, model, production_year, type, notes) VALUES
    ('00000000-0000-4000-8000-000300000001', '00000000-0000-4000-8000-000100000002', 'S 1234 AB', 'Honda', 'Vario 125', 2021, 'motorcycle', NULL),
    ('00000000-0000-4000-8000-000300000002', '00000000-0000-4000-8000-000100000002', 'S 2345 BC', 'Yamaha', 'NMAX', 2022, 'motorcycle', NULL),
    ('00000000-0000-4000-8000-000300000003', '00000000-0000-4000-8000-000100000002', 'S 3456 CD', 'Honda', 'Beat', 2020, 'motorcycle', NULL),
    ('00000000-0000-4000-8000-000300000004', '00000000-0000-4000-8000-000100000002', 'S 4567 DE', 'Toyota', 'Avanza', 2019, 'car', NULL),
    ('00000000-0000-4000-8000-000300000005', '00000000-0000-4000-8000-000100000002', 'S 5678 EF', 'Suzuki', 'Ertiga', 2023, 'car', NULL);

-- workshop: 5 rows
INSERT INTO workshop (id, id_user, name, description, logo, phone_number, verified, marketplace_enabled, province_id, city_id, full_address, geog, status) VALUES
    ('00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000100000003', 'Bengkel Prima Mojokerto', 'Servis dan penjualan suku cadang kendaraan.', 'https://example.test/workshops/1.png', '0321000001', TRUE, TRUE, 35, 3576, 'Jalan Pahlawan No. 11, Mojokerto', ST_GeogFromText('SRID=4326;POINT(112.437 -7.472)'), 'active'),
    ('00000000-0000-4000-8000-000400000002', '00000000-0000-4000-8000-000100000003', 'Bengkel Prima Sooko', 'Servis dan penjualan suku cadang kendaraan.', 'https://example.test/workshops/2.png', '0321000002', TRUE, FALSE, 35, 3576, 'Jalan Raya Sooko No. 30, Mojokerto', ST_GeogFromText('SRID=4326;POINT(112.42 -7.488)'), 'active'),
    ('00000000-0000-4000-8000-000400000003', '00000000-0000-4000-8000-000100000003', 'Bengkel Prima Surabaya', 'Servis dan penjualan suku cadang kendaraan.', 'https://example.test/workshops/3.png', '0321000003', FALSE, FALSE, 35, 3578, 'Jalan Diponegoro No. 40, Surabaya', ST_GeogFromText('SRID=4326;POINT(112.752 -7.26)'), 'pending'),
    ('00000000-0000-4000-8000-000400000004', '00000000-0000-4000-8000-000100000003', 'Bengkel Prima Jombang', 'Servis dan penjualan suku cadang kendaraan.', 'https://example.test/workshops/4.png', '0321000004', FALSE, FALSE, 35, 3517, 'Jalan A. Yani No. 51, Jombang', ST_GeogFromText('SRID=4326;POINT(112.235 -7.546)'), 'pending'),
    ('00000000-0000-4000-8000-000400000005', '00000000-0000-4000-8000-000100000003', 'Bengkel Prima Kediri', 'Servis dan penjualan suku cadang kendaraan.', 'https://example.test/workshops/5.png', '0321000005', FALSE, FALSE, 35, 3571, 'Jalan Dhoho No. 18, Kediri', ST_GeogFromText('SRID=4326;POINT(112.0167 -7.8167)'), 'inactive');

-- workshop_document: 5 rows
INSERT INTO workshop_document (id, id_workshop, nib, npwp, business_incorporation_certificate, business_incorporation_declaration, status, approved_by, note, created_at, approved_on, rejected_on) VALUES
    ('00000000-0000-4000-8000-000500000001', '00000000-0000-4000-8000-000400000001', '912345678901', '010203040501', 'https://example.test/legal/akta-1.pdf', NULL, 'approved', '00000000-0000-4000-8000-000100000001', 'Dokumen valid', '2026-09-01 09:00:00+07', '2026-09-02 10:00:00+07', NULL),
    ('00000000-0000-4000-8000-000500000002', '00000000-0000-4000-8000-000400000002', '912345678902', '010203040502', 'https://example.test/legal/akta-2.pdf', NULL, 'approved', '00000000-0000-4000-8000-000100000001', 'Dokumen valid', '2026-09-02 09:00:00+07', '2026-09-03 10:00:00+07', NULL),
    ('00000000-0000-4000-8000-000500000003', '00000000-0000-4000-8000-000400000003', '912345678903', '010203040503', 'https://example.test/legal/akta-3.pdf', NULL, 'pending', NULL, 'Menunggu verifikasi', '2026-09-03 09:00:00+07', NULL, NULL),
    ('00000000-0000-4000-8000-000500000004', '00000000-0000-4000-8000-000400000004', '912345678904', '010203040504', 'https://example.test/legal/akta-4.pdf', NULL, 'pending', NULL, 'Menunggu verifikasi', '2026-09-04 09:00:00+07', NULL, NULL),
    ('00000000-0000-4000-8000-000500000005', '00000000-0000-4000-8000-000400000005', '912345678905', '010203040505', 'https://example.test/legal/akta-5.pdf', NULL, 'rejected', '00000000-0000-4000-8000-000100000001', 'Perlu revisi dokumen', '2026-09-05 09:00:00+07', NULL, '2026-09-10 10:00:00+07');

-- workshop_user_management: 5 rows
INSERT INTO workshop_user_management (id, id_user, id_workshop, role, is_active) VALUES
    ('00000000-0000-4000-8000-000600000001', '00000000-0000-4000-8000-000100000003', '00000000-0000-4000-8000-000400000001', 'owner', TRUE),
    ('00000000-0000-4000-8000-000600000002', '00000000-0000-4000-8000-000100000003', '00000000-0000-4000-8000-000400000002', 'owner', TRUE),
    ('00000000-0000-4000-8000-000600000003', '00000000-0000-4000-8000-000100000003', '00000000-0000-4000-8000-000400000001', 'warehouse_administrator', TRUE),
    ('00000000-0000-4000-8000-000600000004', '00000000-0000-4000-8000-000100000004', '00000000-0000-4000-8000-000400000001', 'mechanic', TRUE),
    ('00000000-0000-4000-8000-000600000005', '00000000-0000-4000-8000-000100000005', '00000000-0000-4000-8000-000400000001', 'pickup_service', TRUE);

-- category: 5 rows
INSERT INTO category (id, name) VALUES
    ('00000000-0000-4000-8000-000700000001', 'Oli Mesin'),
    ('00000000-0000-4000-8000-000700000002', 'Filter Udara'),
    ('00000000-0000-4000-8000-000700000003', 'Sistem Pengereman'),
    ('00000000-0000-4000-8000-000700000004', 'Aki'),
    ('00000000-0000-4000-8000-000700000005', 'Busi');

-- category_brand: 5 rows
INSERT INTO category_brand (id, name, logo) VALUES
    ('00000000-0000-4000-8000-000800000001', 'AHM', 'https://example.test/brands/1.png'),
    ('00000000-0000-4000-8000-000800000002', 'Yamaha Genuine Parts', 'https://example.test/brands/2.png'),
    ('00000000-0000-4000-8000-000800000003', 'Brembo', 'https://example.test/brands/3.png'),
    ('00000000-0000-4000-8000-000800000004', 'GS Astra', 'https://example.test/brands/4.png'),
    ('00000000-0000-4000-8000-000800000005', 'NGK', 'https://example.test/brands/5.png');

-- product: 5 rows
INSERT INTO product (id, id_workshop, id_category, id_category_brand, id_workshop_user_management, name, sku, description, image, price, is_active) VALUES
    ('00000000-0000-4000-8000-000900000001', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000700000001', '00000000-0000-4000-8000-000800000001', '00000000-0000-4000-8000-000600000003', 'Oli Mesin 10W-30', 'OLI-001', 'Suku cadang oli mesin 10w-30 untuk kendaraan.', 'https://example.test/products/OLI-001.png', 45000, TRUE),
    ('00000000-0000-4000-8000-000900000002', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000700000002', '00000000-0000-4000-8000-000800000002', '00000000-0000-4000-8000-000600000003', 'Filter Udara NMAX', 'FLT-002', 'Suku cadang filter udara nmax untuk kendaraan.', 'https://example.test/products/FLT-002.png', 80000, TRUE),
    ('00000000-0000-4000-8000-000900000003', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000700000003', '00000000-0000-4000-8000-000800000003', '00000000-0000-4000-8000-000600000003', 'Kampas Rem Depan', 'REM-003', 'Suku cadang kampas rem depan untuk kendaraan.', 'https://example.test/products/REM-003.png', 150000, TRUE),
    ('00000000-0000-4000-8000-000900000004', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000700000004', '00000000-0000-4000-8000-000800000004', '00000000-0000-4000-8000-000600000003', 'Aki Kering 12V', 'AKI-004', 'Suku cadang aki kering 12v untuk kendaraan.', 'https://example.test/products/AKI-004.png', 230000, TRUE),
    ('00000000-0000-4000-8000-000900000005', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000700000005', '00000000-0000-4000-8000-000800000005', '00000000-0000-4000-8000-000600000003', 'Busi Iridium', 'BUS-005', 'Suku cadang busi iridium untuk kendaraan.', 'https://example.test/products/BUS-005.png', 95000, TRUE);

-- marketplace_transaction: 5 rows
INSERT INTO marketplace_transaction (id, id_user, transaction_code, status, shipping_address, subtotal, shipping_cost, total_amount, invoice_url, paid_at, received_at, created_at) VALUES
    ('00000000-0000-4000-8000-000a00000001', '00000000-0000-4000-8000-000100000002', 'SR-MKT-202610-001', 'completed', '{"name":"Dina Putri","phone":"08123456002","full_address":"Jalan Majapahit No. 10, Mojokerto","city_id":3576}'::JSONB, 45000, 15000, 60000, 'https://example.test/invoices/marketplace-1.pdf', '2026-10-06 11:00:00+07', '2026-10-08 15:00:00+07', '2026-10-06 10:30:00+07'),
    ('00000000-0000-4000-8000-000a00000002', '00000000-0000-4000-8000-000100000002', 'SR-MKT-202610-002', 'processing', '{"name":"Dina Putri","phone":"08123456002","full_address":"Jalan Gajah Mada No. 15, Mojokerto","city_id":3576}'::JSONB, 80000, 15000, 95000, NULL, '2026-10-19 11:00:00+07', NULL, '2026-10-19 10:30:00+07'),
    ('00000000-0000-4000-8000-000a00000003', '00000000-0000-4000-8000-000100000002', 'SR-MKT-202610-003', 'shipping', '{"name":"Dina Putri","phone":"08123456002","full_address":"Jalan Benteng Pancasila No. 22, Mojokerto","city_id":3576}'::JSONB, 150000, 20000, 170000, NULL, '2026-10-19 11:00:00+07', NULL, '2026-10-19 10:30:00+07'),
    ('00000000-0000-4000-8000-000a00000004', '00000000-0000-4000-8000-000100000002', 'SR-MKT-202610-004', 'completed', '{"name":"Dina Putri","phone":"08123456002","full_address":"Jalan Empunala No. 9, Mojokerto","city_id":3576}'::JSONB, 230000, 20000, 250000, 'https://example.test/invoices/marketplace-4.pdf', '2026-10-13 11:00:00+07', '2026-10-16 16:00:00+07', '2026-10-13 10:30:00+07'),
    ('00000000-0000-4000-8000-000a00000005', '00000000-0000-4000-8000-000100000002', 'SR-MKT-202610-005', 'pending_payment', '{"name":"Dina Putri","phone":"08123456002","full_address":"Jalan Pemuda No. 3, Mojokerto","city_id":3576}'::JSONB, 95000, 15000, 110000, NULL, NULL, NULL, '2026-10-20 10:30:00+07');

-- marketplace_transaction_detail: 5 rows
INSERT INTO marketplace_transaction_detail (id, id_marketplace_transaction, id_workshop, id_product, quantity, price, subtotal, product_snapshot, workshop_snapshot, courier, tracking_number, status, return_status, return_evidence_url, return_requested_at, shipped_at, created_at) VALUES
    ('00000000-0000-4000-8000-000b00000001', '00000000-0000-4000-8000-000a00000001', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000900000001', 1, 45000, 45000, '{"sku":"OLI-001","name":"Oli Mesin 10W-30","price":45000}'::JSONB, '{"name":"Bengkel Prima Mojokerto","phone_number":"0321000001"}'::JSONB, 'JNE', 'SRRESI202610001', 'delivered', 'none', NULL, NULL, '2026-10-06 17:00:00+07', '2026-10-06 10:30:00+07'),
    ('00000000-0000-4000-8000-000b00000002', '00000000-0000-4000-8000-000a00000002', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000900000002', 1, 80000, 80000, '{"sku":"FLT-002","name":"Filter Udara NMAX","price":80000}'::JSONB, '{"name":"Bengkel Prima Mojokerto","phone_number":"0321000001"}'::JSONB, 'J&T', NULL, 'packaging', 'none', NULL, NULL, NULL, '2026-10-19 10:30:00+07'),
    ('00000000-0000-4000-8000-000b00000003', '00000000-0000-4000-8000-000a00000003', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000900000003', 1, 150000, 150000, '{"sku":"REM-003","name":"Kampas Rem Depan","price":150000}'::JSONB, '{"name":"Bengkel Prima Mojokerto","phone_number":"0321000001"}'::JSONB, 'JNE', 'SRRESI202610003', 'shipped', 'none', NULL, NULL, '2026-10-19 17:00:00+07', '2026-10-19 10:30:00+07'),
    ('00000000-0000-4000-8000-000b00000004', '00000000-0000-4000-8000-000a00000004', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000900000004', 1, 230000, 230000, '{"sku":"AKI-004","name":"Aki Kering 12V","price":230000}'::JSONB, '{"name":"Bengkel Prima Mojokerto","phone_number":"0321000001"}'::JSONB, 'JNE', 'SRRESI202610004', 'delivered', 'none', NULL, NULL, '2026-10-13 17:00:00+07', '2026-10-13 10:30:00+07'),
    ('00000000-0000-4000-8000-000b00000005', '00000000-0000-4000-8000-000a00000005', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000900000005', 1, 95000, 95000, '{"sku":"BUS-005","name":"Busi Iridium","price":95000}'::JSONB, '{"name":"Bengkel Prima Mojokerto","phone_number":"0321000001"}'::JSONB, NULL, NULL, 'pending', 'none', NULL, NULL, NULL, '2026-10-20 10:30:00+07');

-- booking: 5 rows
INSERT INTO booking (id, id_user, id_workshop, id_vehicle, id_address, booking_code, booking_type, status, queue_number, address_snapshot, scheduled_at, estimated_finish_at, completed_at, estimated_total, approval_status, approval_method, approval_evidence, approved_at, estimate_document_url, invoice_url, created_at) VALUES
    ('00000000-0000-4000-8000-000c00000001', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000300000001', '00000000-0000-4000-8000-000200000001', 'SR-SVC-202610-001', 'online_pickup', 'completed', 1, '{"full_address":"Jalan Majapahit No. 10, Mojokerto","city_id":3576}'::JSONB, '2026-10-01 09:00:00+07', '2026-10-01 17:00:00+07', '2026-10-01 17:00:00+07', 105000, 'approved', 'application', NULL, '2026-10-01 10:30:00+07', 'https://example.test/estimates/booking-1.pdf', 'https://example.test/invoices/service-1.pdf', '2026-10-01 08:00:00+07'),
    ('00000000-0000-4000-8000-000c00000002', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000300000002', NULL, 'SR-SVC-202610-002', 'online_visit', 'completed', 2, NULL, '2026-10-02 09:00:00+07', '2026-10-02 17:00:00+07', '2026-10-02 17:00:00+07', 150000, 'approved', 'application', NULL, '2026-10-02 10:30:00+07', 'https://example.test/estimates/booking-2.pdf', 'https://example.test/invoices/service-2.pdf', '2026-10-02 08:00:00+07'),
    ('00000000-0000-4000-8000-000c00000003', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000300000003', NULL, 'SR-SVC-202610-003', 'offline', 'completed', 3, NULL, '2026-10-03 09:00:00+07', '2026-10-03 17:00:00+07', '2026-10-03 17:00:00+07', 210000, 'approved', 'whatsapp', 'https://example.test/approvals/booking-3.png', '2026-10-03 10:30:00+07', 'https://example.test/estimates/booking-3.pdf', 'https://example.test/invoices/service-3.pdf', '2026-10-03 08:00:00+07'),
    ('00000000-0000-4000-8000-000c00000004', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000300000004', '00000000-0000-4000-8000-000200000004', 'SR-SVC-202610-004', 'online_pickup', 'in_progress', 4, '{"full_address":"Jalan Empunala No. 9, Mojokerto","city_id":3576}'::JSONB, '2026-10-19 09:00:00+07', '2026-10-19 17:00:00+07', NULL, 310000, 'approved', 'application', NULL, '2026-10-19 10:30:00+07', 'https://example.test/estimates/booking-4.pdf', NULL, '2026-10-19 08:00:00+07'),
    ('00000000-0000-4000-8000-000c00000005', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000300000005', '00000000-0000-4000-8000-000200000005', 'SR-SVC-202610-005', 'online_pickup', 'confirmed', 5, '{"full_address":"Jalan Pemuda No. 3, Mojokerto","city_id":3576}'::JSONB, '2026-10-21 09:00:00+07', '2026-10-21 17:00:00+07', NULL, 135000, 'pending', NULL, NULL, NULL, 'https://example.test/estimates/booking-5.pdf', NULL, '2026-10-20 10:00:00+07');

-- booking_product: 5 rows
INSERT INTO booking_product (id, id_booking, id_product, quantity, unit_price, subtotal) VALUES
    ('00000000-0000-4000-8000-000d00000001', '00000000-0000-4000-8000-000c00000001', '00000000-0000-4000-8000-000900000001', 1, 45000, 45000),
    ('00000000-0000-4000-8000-000d00000002', '00000000-0000-4000-8000-000c00000002', '00000000-0000-4000-8000-000900000002', 1, 80000, 80000),
    ('00000000-0000-4000-8000-000d00000003', '00000000-0000-4000-8000-000c00000003', '00000000-0000-4000-8000-000900000003', 1, 150000, 150000),
    ('00000000-0000-4000-8000-000d00000004', '00000000-0000-4000-8000-000c00000004', '00000000-0000-4000-8000-000900000004', 1, 230000, 230000),
    ('00000000-0000-4000-8000-000d00000005', '00000000-0000-4000-8000-000c00000005', '00000000-0000-4000-8000-000900000005', 1, 95000, 95000);

-- product_stock: 5 rows
INSERT INTO product_stock (id, id_product, id_booking_product, id_marketplace_transaction_detail, serial_number, status, reserved_at) VALUES
    ('00000000-0000-4000-8000-000e00000001', '00000000-0000-4000-8000-000900000001', NULL, NULL, 'SR-UNIT-OLI-001', 'available', NULL),
    ('00000000-0000-4000-8000-000e00000002', '00000000-0000-4000-8000-000900000002', NULL, '00000000-0000-4000-8000-000b00000002', 'SR-UNIT-FLT-002', 'held', '2026-10-19 11:00:00+07'),
    ('00000000-0000-4000-8000-000e00000003', '00000000-0000-4000-8000-000900000003', '00000000-0000-4000-8000-000d00000003', NULL, 'SR-UNIT-REM-003', 'used_service', '2026-10-03 10:30:00+07'),
    ('00000000-0000-4000-8000-000e00000004', '00000000-0000-4000-8000-000900000004', NULL, '00000000-0000-4000-8000-000b00000004', 'SR-UNIT-AKI-004', 'sold_marketplace', '2026-10-13 11:00:00+07'),
    ('00000000-0000-4000-8000-000e00000005', '00000000-0000-4000-8000-000900000005', NULL, NULL, 'SR-UNIT-BUS-005', 'sold_offline', NULL);

-- booking_service: 5 rows
INSERT INTO booking_service (id, id_booking, id_mechanic, customer_complaint, diagnosis, service_description, labor_price, inspection_photos, progress_history, status, started_at, completed_at) VALUES
    ('00000000-0000-4000-8000-000f00000001', '00000000-0000-4000-8000-000c00000001', '00000000-0000-4000-8000-000600000004', 'Mesin terasa kasar', 'Oli perlu diganti', 'Pemeriksaan dan penggantian komponen', 60000, '["https://example.test/inspections/1-1.jpg"]'::JSONB, '[{"status":"inspection","at":"2026-10-01T09:15:00+07:00"}]'::JSONB, 'completed', '2026-10-01 11:00:00+07', '2026-10-01 17:00:00+07'),
    ('00000000-0000-4000-8000-000f00000002', '00000000-0000-4000-8000-000c00000002', '00000000-0000-4000-8000-000600000004', 'Akselerasi berkurang', 'Filter udara kotor', 'Pemeriksaan dan penggantian komponen', 70000, '["https://example.test/inspections/2-1.jpg"]'::JSONB, '[{"status":"inspection","at":"2026-10-02T09:15:00+07:00"}]'::JSONB, 'completed', '2026-10-02 11:00:00+07', '2026-10-02 17:00:00+07'),
    ('00000000-0000-4000-8000-000f00000003', '00000000-0000-4000-8000-000c00000003', '00000000-0000-4000-8000-000600000004', 'Rem berbunyi', 'Kampas rem menipis', 'Pemeriksaan dan penggantian komponen', 60000, '["https://example.test/inspections/3-1.jpg"]'::JSONB, '[{"status":"inspection","at":"2026-10-03T09:15:00+07:00"}]'::JSONB, 'completed', '2026-10-03 11:00:00+07', '2026-10-03 17:00:00+07'),
    ('00000000-0000-4000-8000-000f00000004', '00000000-0000-4000-8000-000c00000004', '00000000-0000-4000-8000-000600000004', 'Mobil sulit dihidupkan', 'Aki melemah', 'Pemeriksaan dan penggantian komponen', 80000, '["https://example.test/inspections/4-1.jpg"]'::JSONB, '[{"status":"inspection","at":"2026-10-19T09:15:00+07:00"}]'::JSONB, 'in_progress', '2026-10-19 11:00:00+07', NULL),
    ('00000000-0000-4000-8000-000f00000005', '00000000-0000-4000-8000-000c00000005', '00000000-0000-4000-8000-000600000004', 'Mesin tersendat', NULL, NULL, 40000, '[]'::JSONB, '[]'::JSONB, 'pending', NULL, NULL);

-- booking_pickup: 5 rows
INSERT INTO booking_pickup (id, id_booking, id_workshop_user_management, pickup_type, status, pickup_fee, scheduled_at, departed_at, completed_at, cancelled_by, cancelled_at, cancellation_reason, handover_evidence) VALUES
    ('00000000-0000-4000-8000-001000000001', '00000000-0000-4000-8000-000c00000001', '00000000-0000-4000-8000-000600000005', 'pickup', 'completed', 35000, '2026-10-01 07:30:00+07', '2026-10-01 08:00:00+07', '2026-10-01 08:30:00+07', NULL, NULL, NULL, 'https://example.test/handover/1-pickup.jpg'),
    ('00000000-0000-4000-8000-001000000002', '00000000-0000-4000-8000-000c00000001', '00000000-0000-4000-8000-000600000005', 'delivery', 'completed', 0, '2026-10-01 17:00:00+07', '2026-10-01 17:05:00+07', '2026-10-01 17:30:00+07', NULL, NULL, NULL, 'https://example.test/handover/1-delivery.jpg'),
    ('00000000-0000-4000-8000-001000000003', '00000000-0000-4000-8000-000c00000004', '00000000-0000-4000-8000-000600000005', 'pickup', 'on_the_way', 25000, '2026-10-19 07:30:00+07', '2026-10-19 08:05:00+07', NULL, NULL, NULL, NULL, NULL),
    ('00000000-0000-4000-8000-001000000004', '00000000-0000-4000-8000-000c00000004', '00000000-0000-4000-8000-000600000005', 'delivery', 'pending', 0, '2026-10-20 17:00:00+07', NULL, NULL, NULL, NULL, NULL, NULL),
    ('00000000-0000-4000-8000-001000000005', '00000000-0000-4000-8000-000c00000005', '00000000-0000-4000-8000-000600000005', 'pickup', 'assigned', 20000, '2026-10-21 07:30:00+07', NULL, NULL, NULL, NULL, NULL, NULL);

-- booking_pickup_history: 5 rows
INSERT INTO booking_pickup_history (id, id_booking_pickup, geog, status, note, recorded_at) VALUES
    ('00000000-0000-4000-8000-001100000001', '00000000-0000-4000-8000-001000000001', ST_GeogFromText('SRID=4326;POINT(112.4341 -7.4738)'), 'departed', 'Driver berangkat', '2026-10-01 08:00:00+07'),
    ('00000000-0000-4000-8000-001100000002', '00000000-0000-4000-8000-001000000001', ST_GeogFromText('SRID=4326;POINT(112.437 -7.472)'), 'arrived', 'Driver tiba di bengkel', '2026-10-01 08:15:00+07'),
    ('00000000-0000-4000-8000-001100000003', '00000000-0000-4000-8000-001000000002', ST_GeogFromText('SRID=4326;POINT(112.437 -7.472)'), 'departed', 'Driver mengantar kendaraan', '2026-10-01 17:05:00+07'),
    ('00000000-0000-4000-8000-001100000004', '00000000-0000-4000-8000-001000000002', ST_GeogFromText('SRID=4326;POINT(112.4341 -7.4738)'), 'handed_over', 'Kendaraan diserahkan', '2026-10-01 17:30:00+07'),
    ('00000000-0000-4000-8000-001100000005', '00000000-0000-4000-8000-001000000003', ST_GeogFromText('SRID=4326;POINT(112.451 -7.483)'), 'departed', 'Penjemputan dimulai', '2026-10-19 08:05:00+07');

-- payment: 5 rows
INSERT INTO payment (id, id_user, id_booking, id_marketplace_transaction, id_original_payment, payment_code, payment_type, payment_method, status, amount, reference_number, paid_at, created_at) VALUES
    ('00000000-0000-4000-8000-001200000001', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000c00000001', NULL, NULL, 'SR-PAY-202610-001', 'pickup', 'qris', 'paid', 35000, 'DUMMY-QRIS-0001', '2026-10-01 07:00:00+07', '2026-10-01 07:00:00+07'),
    ('00000000-0000-4000-8000-001200000002', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000c00000001', NULL, NULL, 'SR-PAY-202610-002', 'service', 'qris', 'paid', 105000, 'DUMMY-QRIS-0002', '2026-10-01 10:45:00+07', '2026-10-01 10:45:00+07'),
    ('00000000-0000-4000-8000-001200000003', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000c00000003', NULL, NULL, 'SR-PAY-202610-003', 'service', 'cash', 'paid', 210000, 'CASH-0003', '2026-10-03 10:45:00+07', '2026-10-03 10:45:00+07'),
    ('00000000-0000-4000-8000-001200000004', '00000000-0000-4000-8000-000100000002', NULL, '00000000-0000-4000-8000-000a00000001', NULL, 'SR-PAY-202610-004', 'marketplace', 'qris', 'paid', 60000, 'DUMMY-QRIS-0004', '2026-10-06 11:00:00+07', '2026-10-06 11:00:00+07'),
    ('00000000-0000-4000-8000-001200000005', '00000000-0000-4000-8000-000100000002', NULL, '00000000-0000-4000-8000-000a00000004', NULL, 'SR-PAY-202610-005', 'marketplace', 'qris', 'paid', 250000, 'DUMMY-QRIS-0005', '2026-10-13 11:00:00+07', '2026-10-13 11:00:00+07');

-- review: 5 rows
INSERT INTO review (id, id_user, id_workshop, id_booking, id_marketplace_transaction, rating, comment, owner_reply, is_hidden, moderation_reason, replied_at, created_at) VALUES
    ('00000000-0000-4000-8000-001300000001', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000c00000001', NULL, 5, 'Pengerjaan rapi dan tepat waktu.', 'Terima kasih atas ulasannya.', FALSE, NULL, '2026-10-10 12:00:00+07', '2026-10-04 10:00:00+07'),
    ('00000000-0000-4000-8000-001300000002', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000c00000002', NULL, 4, 'Pelayanan baik.', NULL, FALSE, NULL, NULL, '2026-10-05 10:00:00+07'),
    ('00000000-0000-4000-8000-001300000003', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000400000001', '00000000-0000-4000-8000-000c00000003', NULL, 5, 'Administrasi pelayanan jelas.', NULL, FALSE, NULL, NULL, '2026-10-06 10:00:00+07'),
    ('00000000-0000-4000-8000-001300000004', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000400000001', NULL, '00000000-0000-4000-8000-000a00000001', 5, 'Produk sesuai pesanan.', 'Terima kasih atas ulasannya.', FALSE, NULL, '2026-10-17 12:00:00+07', '2026-10-09 10:00:00+07'),
    ('00000000-0000-4000-8000-001300000005', '00000000-0000-4000-8000-000100000002', '00000000-0000-4000-8000-000400000001', NULL, '00000000-0000-4000-8000-000a00000004', 4, 'Barang diterima dalam kondisi baik.', NULL, FALSE, NULL, NULL, '2026-10-17 10:00:00+07');

COMMIT;
