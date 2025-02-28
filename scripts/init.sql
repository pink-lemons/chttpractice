CREATE TABLE ingredient (
	ingredient VARCHAR(64) PRIMARY KEY
);

CREATE TABLE inventory (
	ingredient VARCHAR(64) NOT NULL REFERENCES ingredient ON DELETE RESTRICT,
	packaging_type VARCHAR(10),
	pallet_count SMALLINT NOT NULL,
	total_weight BIGINT NOT NULL,
	pounds_per_pallet INTEGER NOT NULL,
	pounds_per_package INTEGER NOT NULL,
	PRIMARY KEY (ingredient, packaging_type)
);

CREATE TABLE delivery (
	vendb_number VARCHAR(64) PRIMARY KEY,
	ingredient VARCHAR(64) NOT NULL REFERENCES ingredient ON DELETE RESTRICT,
	lot_number VARCHAR(64) NOT NULL,
	delivery_date DATE NOT NULL,
	pallet_count SMALLINT NOT NULL,
	weight NUMERIC(9, 2) NOT NULL,
	delivery_company VARCHAR(64) NOT NULL,
	initial_storage_bay VARCHAR(4) NOT NULL
);

CREATE TABLE pickup (
	pickup_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	customer VARCHAR(64) NOT NULL,
	ingredient VARCHAR(64) NOT NULL REFERENCES ingredient ON DELETE RESTRICT,
	pickup_date DATE NOT NULL,
	pickup_company VARCHAR(64),
	driver_name VARCHAR(16),
	damaged TEXT,
	issue TEXT,
	delivery_state VARCHAR(32)
);

CREATE TABLE pallet (
	vendb_number VARCHAR(64) REFERENCES delivery ON DELETE RESTRICT,
	pallet_id SMALLINT,
	ingredient VARCHAR(64) NOT NULL REFERENCES ingredient ON DELETE RESTRICT,
	storage_bay VARCHAR(4) NOT NULL,
	weight NUMERIC(9, 2) NOT NULL,
	pickup_id INTEGER REFERENCES pickup ON DELETE RESTRICT,
	PRIMARY KEY (vendb_number, pallet_id)
);

CREATE INDEX idx_delivery_delivery_date ON delivery (delivery_date);
CREATE INDEX idx_pickup_customer ON pickup (customer);
CREATE INDEX idx_pickup_ingredient ON pickup (ingredient);
CREATE INDEX idx_pallet_ingredient ON pallet (ingredient);
CREATE INDEX idx_pallet_storage_bay ON pallet (storage_bay);
CREATE INDEX idx_pallet_pickup_id ON pallet (pickup_id);
