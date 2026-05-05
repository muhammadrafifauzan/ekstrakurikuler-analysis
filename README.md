# 📊 Analisis Ekstrakurikuler Coding SD Jakarta
### *Data Analytics Portfolio Project — Transformasi dari Guru Coding ke Data Analyst*

---

> **Tentang Proyek Ini**
> Proyek ini merupakan bagian dari perjalanan saya bertransformasi dari seorang **guru ekstrakurikuler coding** menjadi **Data Analyst**. Selama mengajar, saya menyadari betapa berharganya data yang terkumpul dari kegiatan belajar siswa — dan betapa banyak insight yang bisa digali darinya untuk pengambilan keputusan yang lebih baik.
>
> Dataset ini adalah **data dummy** yang saya buat berdasarkan pengalaman nyata mengajar coding di sekolah dasar Jakarta, dengan struktur dan pola yang mencerminkan kondisi riil di lapangan.

---

## 🎯 Tujuan Analisis

1. Memahami **pola partisipasi siswa** di berbagai jenis ekstrakurikuler coding
2. Mengidentifikasi **faktor yang mempengaruhi nilai akhir** siswa
3. Menganalisis **sebaran geografis** peserta berdasarkan wilayah Jakarta
4. Mengukur **performa instruktur** berdasarkan capaian siswa yang diajarnya
5. Menemukan **tren pendaftaran** dari semester ke semester

---

## 🗂️ Struktur Dataset

Dataset terdiri dari **4 tabel relasional** dengan total ±400 baris data:

```
dataset_coding_ekskul_jakarta/
├── siswa.csv           # Data 150 siswa peserta ekskul
├── ekstrakurikuler.csv # Katalog 7 jenis kegiatan coding
├── instruktur.csv      # Profil 5 instruktur pengajar
└── partisipasi.csv     # 251 catatan keikutsertaan siswa
```

### `siswa.csv` — Data Peserta
| Kolom | Tipe | Deskripsi |
|-------|------|-----------|
| `NIS` | INT | Nomor Induk Siswa (Primary Key) |
| `Nama_Lengkap` | STRING | Nama lengkap siswa |
| `Jenis_Kelamin` | STRING | Laki-laki / Perempuan |
| `Kelas` | STRING | Tingkatan kelas (4A, 4B, 5A, 5B, 6A, 6B) |
| `Usia_Tahun` | INT | Usia siswa dalam tahun |
| `Nama_Sekolah` | STRING | Nama SDN asal |
| `Kecamatan` | STRING | Kecamatan domisili |
| `Kota_Wilayah` | STRING | Kota administrasi Jakarta |

**Sample Data:**
```
NIS,Nama_Lengkap,Jenis_Kelamin,Kelas,Usia_Tahun,Nama_Sekolah,Kecamatan,Kota_Wilayah
20240001,Rizky Wibowo,Laki-laki,5A,11,SDN 04 Mampang Prapatan,Mampang Prapatan,Jakarta Selatan
20240002,Bima Wibowo,Laki-laki,4A,10,SDN 04 Tanjung Priok,Tanjung Priok,Jakarta Utara
20240059,Putri Kusuma,Perempuan,5A,11,SDN 02 Cilandak,Cilandak,Jakarta Selatan
```

---

### `ekstrakurikuler.csv` — Katalog Kegiatan
| Kolom | Tipe | Deskripsi |
|-------|------|-----------|
| `Kode_EK` | STRING | Kode unik ekstrakurikuler (Primary Key) |
| `Nama_Ekstrakurikuler` | STRING | Nama kegiatan |
| `Platform_Tools` | STRING | Tools/bahasa pemrograman yang digunakan |
| `Deskripsi` | STRING | Deskripsi singkat kegiatan |
| `Hari` | STRING | Hari pelaksanaan |
| `Jam_Mulai` / `Jam_Selesai` | TIME | Jadwal kegiatan |
| `Kapasitas_Maks` | INT | Batas maksimal peserta |
| `Status` | STRING | Status kegiatan (Aktif) |

**Daftar Ekstrakurikuler:**
| Kode | Nama | Tools | Hari | Kapasitas |
|------|------|-------|------|-----------|
| EK001 | Scratch Programming | Scratch | Senin | 24 |
| EK002 | Python Junior | Python | Selasa | 27 |
| EK003 | Web Design Dasar | HTML/CSS | Rabu | 24 |
| EK004 | Robotika & Coding | Lego Mindstorms | Kamis | 30 |
| EK005 | Game Development | GameMaker | Jumat | 27 |
| EK006 | Digital Art & Coding | Canva + Code | Senin | 32 |
| EK007 | Coding Club Lanjutan | Python/Scratch | Rabu | 35 |

---

### `instruktur.csv` — Data Pengajar
| Kolom | Tipe | Deskripsi |
|-------|------|-----------|
| `ID_Instruktur` | STRING | ID unik instruktur (Primary Key) |
| `Nama_Instruktur` | STRING | Nama lengkap |
| `Spesialisasi` | STRING | Bidang keahlian |
| `Pendidikan_Terakhir` | STRING | Latar belakang pendidikan |
| `Email` | STRING | Email institusional |
| `Tahun_Bergabung` | INT | Tahun mulai mengajar |

**Sample Data:**
```
INS001,Budi Santoso,Scratch & Python,S1 Teknik Informatika UI,budi.santoso@coding.sch.id,2019
INS002,Rina Marlina,Web Design,S1 Desain Komunikasi Visual,rina.marlina@coding.sch.id,2020
INS003,Agus Prasetyo,Robotika,S2 Teknik Elektro ITB,agus.prasetyo@coding.sch.id,2018
```

---

### `partisipasi.csv` — Rekap Keikutsertaan
| Kolom | Tipe | Deskripsi |
|-------|------|-----------|
| `ID_Partisipasi` | STRING | ID unik catatan (Primary Key) |
| `NIS` | INT | Foreign Key → siswa.csv |
| `Kode_EK` | STRING | Foreign Key → ekstrakurikuler.csv |
| `Tahun_Ajaran` | STRING | Misal: 2023/2024 |
| `Semester` | STRING | Ganjil / Genap |
| `Tanggal_Daftar` | DATE | Tanggal pendaftaran |
| `Total_Pertemuan` | INT | Jumlah pertemuan dalam semester |
| `Hadir` | INT | Jumlah kehadiran aktual |
| `Pct_Kehadiran` | FLOAT | Persentase kehadiran (%) |
| `Nilai_Akhir` | FLOAT | Nilai akhir semester (0–100) |
| `Status` | STRING | Aktif / Selesai |
| `ID_Instruktur` | STRING | Foreign Key → instruktur.csv |
| `Sertifikat` | STRING | Ya / Tidak |

**Sample Data:**
```
ID_Partisipasi,NIS,Kode_EK,Tahun_Ajaran,Semester,Total_Pertemuan,Hadir,Pct_Kehadiran,Nilai_Akhir
P0001,20240001,EK004,2023/2024,Ganjil,13,8,61.5,79.5
P0002,20240001,EK003,2023/2024,Genap,19,13,68.4,82.2
P0059,20240059,EK007,2023/2024,Ganjil,16,15,93.75,94.85
```

---

## 📐 Relasi Antar Tabel (ERD)

```
┌─────────────┐       ┌──────────────────┐       ┌──────────────────┐
│   siswa     │       │   partisipasi    │       │ ekstrakurikuler  │
│─────────────│       │──────────────────│       │──────────────────│
│ NIS (PK)    │◄──────│ NIS (FK)         │──────►│ Kode_EK (PK)     │
│ Nama_Lengkap│       │ Kode_EK (FK)     │       │ Nama_Ekskul      │
│ Jenis_Kelamin│      │ ID_Instruktur(FK)│       │ Platform_Tools   │
│ Kelas       │       │ Tahun_Ajaran     │       │ Kapasitas_Maks   │
│ Kota_Wilayah│       │ Pct_Kehadiran    │       └──────────────────┘
└─────────────┘       │ Nilai_Akhir      │
                      │ Sertifikat       │       ┌──────────────────┐
                      └──────────────────┘       │   instruktur     │
                               │                 │──────────────────│
                               └────────────────►│ ID_Instruktur(PK)│
                                                 │ Nama_Instruktur  │
                                                 │ Spesialisasi     │
                                                 └──────────────────┘
```

---

## 📊 Dashboard — Looker Studio

🔗 **[Lihat Dashboard Interaktif](https://datastudio.google.com/reporting/ab125de5-f553-4ce3-a790-caa94b18d0b4)**

Dashboard mencakup **10 halaman analisis**:

| # | Sheet / Tab | Insight Utama |
|---|-------------|---------------|
| 1 | **Multi-Ekskul** | Siswa yang mengikuti lebih dari 1 kegiatan coding |
| 2 | **Performa Instruktur** | Ranking instruktur berdasarkan nilai & kehadiran siswa |
| 3 | **Top 10 Siswa** | Siswa berprestasi dengan nilai akhir tertinggi |
| 4 | **Wilayah Jakarta** | Sebaran partisipasi per kota administrasi |
| 5 | **Tren Semester** | Perkembangan jumlah peserta & nilai dari waktu ke waktu |
| 6 | **Kelas & Gender** | Distribusi partisipasi berdasarkan kelas & jenis kelamin |
| 7 | **Data Ekstrakurikuler** | Statistik per jenis ekskul (nilai rata-rata, kehadiran) |
| 8 | **Cek Kehadiran** | Validasi rentang persentase kehadiran (min/max/avg) |
| 9 | **Unik Gender** | Pengecekan distribusi gender dalam dataset |
| 10 | **Cek Null** | Audit kualitas data — deteksi nilai kosong |

---

## 🗄️ SQL Query — `EkskulCodingAnalyst.sql`

File ini berisi seluruh query analisis yang dijalankan di **Google BigQuery** dengan dataset `KeaktifanEkskulCoding`. Query dibagi menjadi tiga bagian utama:

### 1. 🔎 Data Validation
Langkah pertama sebelum analisis: memastikan data bersih dan konsisten.

| Query | Tujuan |
|-------|--------|
| `COUNT(*)` per tabel | Verifikasi jumlah baris — memastikan semua data berhasil di-load |
| `COUNTIF(kolom IS NULL)` | Deteksi nilai kosong di kolom kunci (`NIS`, `Nama_Lengkap`, `Kelas`, `Kota_Wilayah`) |
| `GROUP BY Jenis_Kelamin` | Cek nilai unik gender — pastikan tidak ada typo atau nilai tak terduga |
| `MIN / MAX / AVG Pct_Kehadiran` | Validasi rentang nilai kehadiran harus berada di antara 0–100 |

---

### 2. 📊 Analisis Utama
Delapan query analitik yang masing-masing menjawab satu pertanyaan bisnis:

| # | Query | Pertanyaan yang Dijawab |
|---|-------|------------------------|
| 1 | **Partisipasi per Ekskul** | Ekskul mana yang paling diminati? Berapa rata-rata nilai dan sertifikat per ekskul? |
| 2 | **Distribusi Kelas & Gender** | Bagaimana pola partisipasi berdasarkan tingkatan kelas dan jenis kelamin? |
| 3 | **Tren per Semester** | Apakah jumlah peserta dan nilai meningkat dari semester ke semester? |
| 4 | **Sebaran Wilayah Jakarta** | Kecamatan dan kota mana yang paling banyak mengirimkan peserta? |
| 5 | **Top 10 Siswa** | Siapa saja siswa berprestasi tertinggi berdasarkan nilai akhir dan kehadiran? |
| 6 | **Performa Instruktur** | Instruktur mana yang menghasilkan rata-rata nilai siswa terbaik? |
| 7 | **Multi-Ekskul** | Apakah siswa yang ikut lebih dari 1 ekskul memiliki nilai lebih tinggi? |

**Contoh query — Performa Instruktur:**
```sql
SELECT
  i.Nama_Instruktur,
  i.Spesialisasi,
  COUNT(p.ID_Partisipasi)          AS total_siswa_diajar,
  ROUND(AVG(p.Nilai_Akhir), 2)    AS avg_nilai_siswa,
  ROUND(AVG(p.Pct_Kehadiran), 2)  AS avg_kehadiran_siswa,
  COUNTIF(p.Sertifikat = 'Ya')    AS total_sertifikat_diterbitkan
FROM `KeaktifanEkskulCoding.PartisipasiCoding` p
JOIN `KeaktifanEkskulCoding.InstrukturCoding` i
  ON p.ID_Instruktur = i.ID_Instruktur
GROUP BY 1, 2
ORDER BY avg_nilai_siswa DESC;
```

**Contoh query — Siswa Multi-Ekskul:**
```sql
SELECT
  s.Nama_Lengkap,
  s.Kelas,
  COUNT(DISTINCT p.Kode_EK)       AS jumlah_ekskul,
  STRING_AGG(DISTINCT e.Nama_Ekstrakurikuler, ', ') AS daftar_ekskul,
  ROUND(AVG(p.Nilai_Akhir), 2)   AS avg_nilai
FROM `KeaktifanEkskulCoding.PartisipasiCoding` p
JOIN `KeaktifanEkskulCoding.SiswaCoding` s ON p.NIS = s.NIS
JOIN `KeaktifanEkskulCoding.EkstrakurikulerCoding` e ON p.Kode_EK = e.Kode_EK
GROUP BY 1, 2
HAVING jumlah_ekskul > 1
ORDER BY jumlah_ekskul DESC, avg_nilai DESC;
```

---

### 3. 🖼️ BigQuery VIEW untuk Dashboard
Dua VIEW siap pakai yang dibuat sebagai sumber data langsung untuk **Looker Studio**:

**`vw_master_partisipasi`** — JOIN semua 4 tabel menjadi satu flat table dengan 26 kolom. Ini adalah sumber utama semua chart di dashboard.
```
partisipasi ──► siswa          (LEFT JOIN by NIS)
            ──► ekstrakurikuler (LEFT JOIN by Kode_EK)
            ──► instruktur      (LEFT JOIN by ID_Instruktur)
```

**`vw_ringkasan_ekskul`** — Agregasi ringkas per ekskul per semester: total siswa, rata-rata kehadiran, rata-rata nilai, dan jumlah sertifikat. Digunakan untuk chart tren dan perbandingan ekskul.

> 💡 *Penggunaan VIEW memungkinkan pemisahan logika transformasi data dari dashboard, sehingga jika data sumber diperbarui, semua chart di Looker Studio otomatis ikut terupdate tanpa perlu konfigurasi ulang.*

---

## 🔍 Key Findings (Preview)

> Beberapa insight menarik dari analisis data ini:

- 🏆 **Top Performer**: Siswa yang mengikuti 2–3 ekskul sekaligus cenderung memiliki rata-rata nilai lebih tinggi (avg 83+) dibanding yang hanya ikut 1 ekskul
- 📍 **Jakarta Selatan** konsisten menjadi wilayah dengan jumlah peserta terbanyak
- 👩‍💻 **Digital Art & Coding** adalah ekskul paling banyak diminati, khususnya oleh siswi perempuan
- 📈 **Kehadiran ↔ Nilai**: Siswa dengan kehadiran >75% rata-rata mendapat nilai di atas 80
- 🥇 **Instruktur Rina Marlina** (Web Design) memimpin dalam rata-rata nilai siswa (77.39) dengan 52 siswa aktif

---

## 🛠️ Tools & Tech Stack

| Kategori | Tools |
|----------|-------|
| **Data Preparation** | Python (Pandas, NumPy) |
| **Data Cleaning** | Python, Excel |
| **Query & Analisis** | Google BigQuery (SQL) |
| **Visualization** | Google Looker Studio |
| **Version Control** | Git & GitHub |
| **Spreadsheet Analysis** | Google Sheets / Excel |

---

## 📁 Struktur Repositori

```
📦 ekskul-coding-jakarta/
 ├── 📂 data/
 │   ├── raw/
 │   │   ├── siswa.csv
 │   │   ├── ekstrakurikuler.csv
 │   │   ├── instruktur.csv
 │   │   └── partisipasi.csv
 │   └── processed/
 │       └── Data_Dashboard_Looker_Studio.xlsx
 ├── 📂 sql/
 │   └── EkskulCodingAnalyst.sql       # Query BigQuery lengkap + VIEW dashboard
 ├── 📂 notebooks/
 │   └── exploratory_analysis.ipynb    # (coming soon)
 ├── 📂 dashboard/
 │   └── screenshot_dashboard.png
 ├── 📄 README.md
 └── 📄 data_dictionary.md             # (coming soon)
```

---

## 🚀 Cara Menggunakan Dataset

### Clone Repository
```bash
git clone https://github.com/username/ekskul-coding-jakarta.git
cd ekskul-coding-jakarta
```

### Load Data dengan Python
```python
import pandas as pd

# Load semua tabel
siswa        = pd.read_csv('data/raw/siswa.csv')
ekskul       = pd.read_csv('data/raw/ekstrakurikuler.csv')
instruktur   = pd.read_csv('data/raw/instruktur.csv')
partisipasi  = pd.read_csv('data/raw/partisipasi.csv')

# Join tabel utama
df = partisipasi.merge(siswa, on='NIS') \
                .merge(ekskul, on='Kode_EK') \
                .merge(instruktur, on='ID_Instruktur')

print(df.shape)       # (251, ~25 kolom)
print(df.head())
```

### Quick Stats
```python
# Rata-rata nilai per ekstrakurikuler
df.groupby('Nama_Ekstrakurikuler')['Nilai_Akhir'].mean().sort_values(ascending=False)

# Distribusi siswa per wilayah
siswa['Kota_Wilayah'].value_counts()

# Korelasi kehadiran vs nilai
df[['Pct_Kehadiran', 'Nilai_Akhir']].corr()
```

---

## 👤 Tentang Saya

Saya adalah seorang **guru ekstrakurikuler coding** di sekolah dasar Jakarta yang saat ini dalam proses transisi menjadi **Data Analyst**. Latar belakang saya di bidang pendidikan teknologi memberi saya perspektif unik dalam menganalisis data — saya tidak hanya melihat angka, tapi juga memahami konteks di baliknya.

**Perjalanan Saya:**
- 🧑‍🏫 Pengalaman mengajar coding (Scratch, Python, Web Design) kepada siswa SD
- 📚 Sedang belajar: SQL, Python for Data Analysis, Data Visualization
- 🎯 Tujuan: Berkontribusi pada peningkatan kualitas pendidikan berbasis data

**Connect with me:**
- 💼 [LinkedIn](https://linkedin.com/in/username)
- 🐙 [GitHub](https://github.com/username)
- 📧 email@example.com

---

## 📌 Disclaimer

> Dataset ini adalah **data dummy / sintetis** yang dibuat untuk keperluan portofolio. Nama siswa, instruktur, dan sekolah adalah fiktif. Pola dan struktur data dirancang untuk mencerminkan kondisi nyata kegiatan ekstrakurikuler coding di Jakarta.

---

## 📜 Lisensi

Dataset ini bebas digunakan untuk keperluan belajar dan portofolio. Mohon cantumkan credit jika digunakan ulang.

---

*⭐ Jika repositori ini bermanfaat, silakan beri bintang!*

*Last updated: Mei 2026*
