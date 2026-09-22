# API Specification - Alza Credential V1

Dokumen ini merinci endpoint API utama yang disediakan oleh backend sistem untuk mendukung fungsionalitas MVP.

## 1. Authentication Endpoints
- **POST `/api/v1/auth/login`**
  - **Deskripsi**: Masuk bagi admin institusi atau super admin.
  - **Payload**: `{ "email": "admin@sekolah.sch.id", "password": "xxx" }`
  - **Response**: `{ "token": "JWT_TOKEN", "role": "institution_admin" }`

## 2. Institution / Issuance Endpoints (Protected)
- **POST `/api/v1/credentials/issue`**
  - **Deskripsi**: Menerbitkan kredensial/ijazah baru dan melakukan *anchoring* hash ke blockchain.
  - **Headers**: `Authorization: Bearer <JWT_TOKEN>`
  - **Payload**: 
    ```json
    {
      "student_name": "Ahmad Budi",
      "student_number": "12345678",
      "program_name": "Teknik Informatika",
      "degree_name": "Sarjana Komputer",
      "graduation_date": "2027-08-15",
      "credential_number": "IJZ-2027-9988"
    }
    ```
  - **Response**: `{ "credential_id": "CRD-2027-000001", "status": "ACTIVE", "blockchain_tx_hash": "0x..." }`

- **POST `/api/v1/credentials/revoke`**
  - **Deskripsi**: Mencabut kredensial yang sudah diterbitkan jika terjadi kesalahan/pembatalan.
  - **Headers**: `Authorization: Bearer <JWT_TOKEN>`
  - **Payload**: `{ "credential_id": "CRD-2027-000001", "reason": "Kesalahan penulisan data nama." }`
  - **Response**: `{ "status": "REVOKED", "revoked_at": "2027-09-22T..." }`

## 3. Public Verification Endpoint (Open / No Auth)
- **GET `/api/v1/verify/{credential_id}`**
  - **Deskripsi**: Digunakan oleh halaman verifikasi publik atau QR code scanner untuk mengecek keaslian ijazah.
  - **Response**: 
    ```json
    {
      "credential_id": "CRD-2027-000001",
      "institution_name": "Universitas Contoh",
      "student_name": "Ahmad Budi",
      "program_name": "Teknik Informatika",
      "graduation_date": "2027-08-15",
      "status": "ACTIVE",
      "document_hash": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
      "blockchain_tx_hash": "0x..."
    }
    ```
