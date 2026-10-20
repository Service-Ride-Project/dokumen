-- Service Ride | PostgreSQL 14+ with PostGIS
-- Run this file before query.sql.
-- PostGIS is required for geography(Point, 4326).
BEGIN;

CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TYPE gender_enum AS ENUM ('male', 'female');
CREATE TYPE user_role_enum AS ENUM ('super_admin', 'customer', 'workshop');
CREATE TYPE account_status_enum AS ENUM ('draft', 'active', 'suspended');
CREATE TYPE vehicle_type_enum AS ENUM ('motorcycle', 'car');
CREATE TYPE workshop_status_enum AS ENUM ('pending', 'active', 'suspended', 'inactive');
CREATE TYPE document_status_enum AS ENUM ('pending', 'approved', 'rejected');
CREATE TYPE workshop_staff_role_enum AS ENUM ('owner', 'warehouse_administrator', 'operations_administrator', 'mechanic', 'pickup_service');
CREATE TYPE product_stock_status_enum AS ENUM ('available', 'held', 'used_service', 'sold_marketplace', 'sold_offline', 'damaged');
CREATE TYPE marketplace_order_status_enum AS ENUM ('pending_payment', 'cancelled', 'processing', 'shipping', 'completed', 'returned');
CREATE TYPE marketplace_item_status_enum AS ENUM ('pending', 'packaging', 'shipped', 'delivered', 'cancelled', 'returned');
CREATE TYPE marketplace_return_status_enum AS ENUM ('none', 'requested', 'approved', 'rejected', 'refunded');
CREATE TYPE booking_type_enum AS ENUM ('online_pickup', 'online_visit', 'offline');
CREATE TYPE booking_status_enum AS ENUM ('pending', 'confirmed', 'inspection', 'waiting_approval', 'approved', 'in_progress', 'completed', 'cancelled');
CREATE TYPE approval_status_enum AS ENUM ('pending', 'approved', 'rejected');
CREATE TYPE approval_method_enum AS ENUM ('application', 'whatsapp', 'phone');
CREATE TYPE booking_service_status_enum AS ENUM ('inspection', 'pending', 'in_progress', 'completed');
CREATE TYPE pickup_type_enum AS ENUM ('pickup', 'delivery');
CREATE TYPE pickup_status_enum AS ENUM ('pending', 'assigned', 'on_the_way', 'arrived', 'completed', 'cancelled');
CREATE TYPE pickup_history_status_enum AS ENUM ('departed', 'on_the_way', 'arrived', 'handed_over', 'offline');
CREATE TYPE payment_type_enum AS ENUM ('pickup', 'service', 'marketplace', 'refund');
CREATE TYPE payment_method_enum AS ENUM ('qris', 'cash', 'wallet');
CREATE TYPE payment_status_enum AS ENUM ('pending', 'paid', 'failed', 'cancelled', 'refunded');

CREATE TABLE "user" (
    id UUID PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255),
    phone_number VARCHAR(25),
    alternative_phone_number VARCHAR(25),
    profile TEXT,
    date_birth DATE,
    gender gender_enum,
    role user_role_enum NOT NULL DEFAULT 'customer',
    account_status account_status_enum NOT NULL DEFAULT 'active',
    is_verified BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE address (
    id UUID PRIMARY KEY,
    id_user UUID NOT NULL REFERENCES "user"(id),
    name VARCHAR(100) NOT NULL,
    province_id INTEGER NOT NULL,
    city_id INTEGER NOT NULL,
    full_address TEXT NOT NULL,
    geog GEOGRAPHY(Point, 4326),
    is_default BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE vehicle (
    id UUID PRIMARY KEY,
    id_user UUID NOT NULL REFERENCES "user"(id),
    plate_number VARCHAR(20) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    production_year INTEGER CHECK (production_year BETWEEN 1900 AND 2100),
    type vehicle_type_enum NOT NULL,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    CONSTRAINT vehicle_owner_plate_unique UNIQUE (id_user, plate_number)
);

CREATE TABLE workshop (
    id UUID PRIMARY KEY,
    id_user UUID NOT NULL REFERENCES "user"(id), -- owner
    name VARCHAR(150) NOT NULL,
    description TEXT,
    logo VARCHAR(500),
    phone_number VARCHAR(25),
    verified BOOLEAN NOT NULL DEFAULT FALSE,
    marketplace_enabled BOOLEAN NOT NULL DEFAULT FALSE,
    province_id INTEGER NOT NULL,
    city_id INTEGER NOT NULL,
    full_address TEXT NOT NULL,
    geog GEOGRAPHY(Point, 4326),
    status workshop_status_enum NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE workshop_document (
    id UUID PRIMARY KEY,
    id_workshop UUID NOT NULL REFERENCES workshop(id),
    nib VARCHAR(30),
    npwp VARCHAR(30),
    business_incorporation_certificate TEXT,
    business_incorporation_declaration TEXT,
    status document_status_enum NOT NULL DEFAULT 'pending',
    approved_by UUID REFERENCES "user"(id),
    note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    approved_on TIMESTAMPTZ,
    rejected_on TIMESTAMPTZ
);

CREATE TABLE workshop_user_management (
    id UUID PRIMARY KEY,
    id_user UUID NOT NULL REFERENCES "user"(id),
    id_workshop UUID NOT NULL REFERENCES workshop(id),
    role workshop_staff_role_enum NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT workshop_member_role_unique UNIQUE (id_user, id_workshop, role)
);

CREATE TABLE category (
    id UUID PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE category_brand (
    id UUID PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    logo TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE product (
    id UUID PRIMARY KEY,
    id_workshop UUID NOT NULL REFERENCES workshop(id),
    id_category UUID NOT NULL REFERENCES category(id),
    id_category_brand UUID REFERENCES category_brand(id),
    id_workshop_user_management UUID REFERENCES workshop_user_management(id),
    name VARCHAR(150) NOT NULL,
    sku VARCHAR(80) NOT NULL,
    description TEXT,
    image TEXT,
    price NUMERIC(14, 2) NOT NULL CHECK (price >= 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    CONSTRAINT product_workshop_sku_unique UNIQUE (id_workshop, sku)
);

CREATE TABLE marketplace_transaction (
    id UUID PRIMARY KEY,
    id_user UUID NOT NULL REFERENCES "user"(id),
    transaction_code VARCHAR(40) NOT NULL UNIQUE,
    status marketplace_order_status_enum NOT NULL DEFAULT 'pending_payment',
    shipping_address JSONB NOT NULL,
    subtotal NUMERIC(14, 2) NOT NULL DEFAULT 0 CHECK (subtotal >= 0),
    shipping_cost NUMERIC(14, 2) NOT NULL DEFAULT 0 CHECK (shipping_cost >= 0),
    total_amount NUMERIC(14, 2) NOT NULL DEFAULT 0 CHECK (total_amount >= 0),
    invoice_url TEXT,
    paid_at TIMESTAMPTZ,
    received_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE marketplace_transaction_detail (
    id UUID PRIMARY KEY,
    id_marketplace_transaction UUID NOT NULL REFERENCES marketplace_transaction(id),
    id_workshop UUID NOT NULL REFERENCES workshop(id),
    id_product UUID NOT NULL REFERENCES product(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price NUMERIC(14, 2) NOT NULL CHECK (price >= 0),
    subtotal NUMERIC(14, 2) NOT NULL CHECK (subtotal >= 0),
    product_snapshot JSONB NOT NULL DEFAULT '{}'::JSONB,
    workshop_snapshot JSONB NOT NULL DEFAULT '{}'::JSONB,
    courier VARCHAR(100),
    tracking_number VARCHAR(100),
    status marketplace_item_status_enum NOT NULL DEFAULT 'pending',
    return_status marketplace_return_status_enum NOT NULL DEFAULT 'none',
    return_evidence_url TEXT,
    return_requested_at TIMESTAMPTZ,
    shipped_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT marketplace_transaction_product_unique UNIQUE (id_marketplace_transaction, id_product)
);

CREATE TABLE booking (
    id UUID PRIMARY KEY,
    id_user UUID NOT NULL REFERENCES "user"(id),
    id_workshop UUID NOT NULL REFERENCES workshop(id),
    id_vehicle UUID NOT NULL REFERENCES vehicle(id),
    id_address UUID REFERENCES address(id),
    booking_code VARCHAR(40) NOT NULL UNIQUE,
    booking_type booking_type_enum NOT NULL,
    status booking_status_enum NOT NULL DEFAULT 'pending',
    queue_number INTEGER CHECK (queue_number > 0),
    address_snapshot JSONB,
    scheduled_at TIMESTAMPTZ NOT NULL,
    estimated_finish_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,
    estimated_total NUMERIC(14, 2) CHECK (estimated_total >= 0),
    approval_status approval_status_enum NOT NULL DEFAULT 'pending',
    approval_method approval_method_enum,
    approval_evidence TEXT,
    approved_at TIMESTAMPTZ,
    estimate_document_url TEXT,
    invoice_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    CONSTRAINT online_pickup_address_required CHECK (booking_type <> 'online_pickup' OR id_address IS NOT NULL)
);

CREATE TABLE booking_product (
    id UUID PRIMARY KEY,
    id_booking UUID NOT NULL REFERENCES booking(id),
    id_product UUID NOT NULL REFERENCES product(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(14, 2) NOT NULL CHECK (unit_price >= 0),
    subtotal NUMERIC(14, 2) NOT NULL CHECK (subtotal >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT booking_product_unique UNIQUE (id_booking, id_product)
);

CREATE TABLE product_stock (
    id UUID PRIMARY KEY,
    id_product UUID NOT NULL REFERENCES product(id),
    id_booking_product UUID REFERENCES booking_product(id),
    id_marketplace_transaction_detail UUID REFERENCES marketplace_transaction_detail(id),
    serial_number VARCHAR(100),
    status product_stock_status_enum NOT NULL DEFAULT 'available',
    reserved_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT product_serial_unique UNIQUE (id_product, serial_number),
    CONSTRAINT product_stock_allocation_check CHECK (
        (status IN ('available', 'sold_offline', 'damaged')
            AND id_booking_product IS NULL AND id_marketplace_transaction_detail IS NULL)
        OR (status = 'held'
            AND num_nonnulls(id_booking_product, id_marketplace_transaction_detail) = 1)
        OR (status = 'used_service'
            AND id_booking_product IS NOT NULL AND id_marketplace_transaction_detail IS NULL)
        OR (status = 'sold_marketplace'
            AND id_booking_product IS NULL AND id_marketplace_transaction_detail IS NOT NULL)
    )
);

CREATE TABLE booking_service (
    id UUID PRIMARY KEY,
    id_booking UUID NOT NULL REFERENCES booking(id),
    id_mechanic UUID NOT NULL REFERENCES workshop_user_management(id),
    customer_complaint TEXT,
    diagnosis TEXT,
    service_description TEXT,
    labor_price NUMERIC(14, 2) NOT NULL DEFAULT 0 CHECK (labor_price >= 0),
    inspection_photos JSONB NOT NULL DEFAULT '[]'::JSONB,
    progress_history JSONB NOT NULL DEFAULT '[]'::JSONB,
    status booking_service_status_enum NOT NULL DEFAULT 'pending',
    started_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE booking_pickup (
    id UUID PRIMARY KEY,
    id_booking UUID NOT NULL REFERENCES booking(id),
    id_workshop_user_management UUID NOT NULL REFERENCES workshop_user_management(id),
    pickup_type pickup_type_enum NOT NULL,
    status pickup_status_enum NOT NULL DEFAULT 'pending',
    pickup_fee NUMERIC(14, 2) NOT NULL DEFAULT 0 CHECK (pickup_fee >= 0),
    scheduled_at TIMESTAMPTZ,
    departed_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,
    cancelled_by UUID REFERENCES "user"(id),
    cancelled_at TIMESTAMPTZ,
    cancellation_reason TEXT,
    handover_evidence TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT booking_pickup_leg_unique UNIQUE (id_booking, pickup_type)
);

CREATE TABLE booking_pickup_history (
    id UUID PRIMARY KEY,
    id_booking_pickup UUID NOT NULL REFERENCES booking_pickup(id),
    geog GEOGRAPHY(Point, 4326),
    status pickup_history_status_enum NOT NULL,
    note TEXT,
    recorded_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE payment (
    id UUID PRIMARY KEY,
    id_user UUID NOT NULL REFERENCES "user"(id),
    id_booking UUID REFERENCES booking(id),
    id_marketplace_transaction UUID REFERENCES marketplace_transaction(id),
    id_original_payment UUID REFERENCES payment(id),
    payment_code VARCHAR(40) NOT NULL UNIQUE,
    payment_type payment_type_enum NOT NULL,
    payment_method payment_method_enum NOT NULL,
    status payment_status_enum NOT NULL DEFAULT 'pending',
    amount NUMERIC(14, 2) NOT NULL CHECK (amount >= 0),
    reference_number VARCHAR(100),
    paid_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT payment_exactly_one_source CHECK (num_nonnulls(id_booking, id_marketplace_transaction) = 1),
    CONSTRAINT payment_not_self_reference CHECK (id_original_payment IS NULL OR id <> id_original_payment)
);

CREATE TABLE review (
    id UUID PRIMARY KEY,
    id_user UUID NOT NULL REFERENCES "user"(id),
    id_workshop UUID NOT NULL REFERENCES workshop(id),
    id_booking UUID REFERENCES booking(id),
    id_marketplace_transaction UUID REFERENCES marketplace_transaction(id),
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    owner_reply TEXT,
    is_hidden BOOLEAN NOT NULL DEFAULT FALSE,
    moderation_reason TEXT,
    replied_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT review_exactly_one_source CHECK (num_nonnulls(id_booking, id_marketplace_transaction) = 1)
);

CREATE INDEX idx_address_user ON address(id_user);
CREATE INDEX idx_workshop_owner ON workshop(id_user);
CREATE INDEX idx_staff_workshop ON workshop_user_management(id_workshop);
CREATE INDEX idx_product_workshop ON product(id_workshop);
CREATE INDEX idx_product_stock_product_status ON product_stock(id_product, status);
CREATE INDEX idx_marketplace_user ON marketplace_transaction(id_user);
CREATE INDEX idx_marketplace_detail_order ON marketplace_transaction_detail(id_marketplace_transaction);
CREATE INDEX idx_booking_workshop_schedule ON booking(id_workshop, scheduled_at);
CREATE INDEX idx_booking_customer ON booking(id_user);
CREATE INDEX idx_pickup_history_task_time ON booking_pickup_history(id_booking_pickup, recorded_at);
CREATE INDEX idx_payment_booking ON payment(id_booking);
CREATE INDEX idx_payment_marketplace ON payment(id_marketplace_transaction);
CREATE INDEX idx_review_workshop ON review(id_workshop);
CREATE INDEX idx_workshop_geo ON workshop USING GIST(geog);
CREATE INDEX idx_address_geo ON address USING GIST(geog);

COMMIT;
