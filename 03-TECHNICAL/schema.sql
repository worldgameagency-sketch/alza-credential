-- 1. Tabel Institutions (Sekolah / Kampus)
CREATE TABLE institutions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    legal_name VARCHAR(255) NOT NULL,
    display_name VARCHAR(255) NOT NULL,
    institution_type VARCHAR(50) NOT NULL, -- Contoh: SMA, SMK, Universitas, Kursus
    address TEXT,
    website VARCHAR(255),
    verification_status VARCHAR(50) DEFAULT 'PENDING', -- PENDING, VERIFIED
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabel Users (Akun Admin & Super Admin)
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    institution_id UUID REFERENCES institutions(id) ON DELETE CASCADE,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL, -- super_admin, institution_admin
    status VARCHAR(50) DEFAULT 'ACTIVE', -- ACTIVE, SUSPENDED
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabel Credentials (Data Ijazah / Kredensial)
CREATE TABLE credentials (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    institution_id UUID REFERENCES institutions(id) ON DELETE CASCADE,
    credential_id VARCHAR(100) UNIQUE NOT NULL, -- Contoh: CRD-2027-000001
    student_name VARCHAR(255) NOT NULL,
    student_number VARCHAR(100) NOT NULL, -- NISN atau NIM
    program_name VARCHAR(255) NOT NULL, -- Program studi / jurusan
    degree_name VARCHAR(255) NOT NULL, -- Gelar
    graduation_date DATE NOT NULL,
    credential_number VARCHAR(100) NOT NULL, -- Nomor ijazah fisik
    document_hash VARCHAR(255) NOT NULL, -- SHA-256 Hash
    blockchain_network VARCHAR(50) DEFAULT 'Polygon',
    blockchain_tx_hash VARCHAR(255), -- Transaction hash bukti anchor
    status VARCHAR(50) DEFAULT 'ACTIVE', -- ACTIVE, REVOKED
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. Tabel Revocations (Log Pencabutan Kredensial)
CREATE TABLE revocations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    credential_id UUID REFERENCES credentials(id) ON DELETE CASCADE,
    reason TEXT NOT NULL,
    revoked_by UUID REFERENCES users(id),
    revoked_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. Tabel Audit Logs (Pencatatan Aktivitas Penting)
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    actor_id UUID,
    action VARCHAR(100) NOT NULL, -- ISSUE_CREDENTIAL, REVOKE_CREDENTIAL, LOGIN, dll
    target_type VARCHAR(50),
    target_id UUID,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
