# Data Validation
-- Cek jumlah baris tiap tabel

SELECT 'SiswaCoding'          AS tabel, COUNT(*) AS total_rows FROM `KeaktifanEkskulCoding.SiswaCoding`
UNION ALL
SELECT 'EkstrakurikulerCoding',          COUNT(*) FROM `KeaktifanEkskulCoding.EkstrakurikulerCoding`
UNION ALL
SELECT 'InstrukturCoding',               COUNT(*) FROM `KeaktifanEkskulCoding.InstrukturCoding`
UNION ALL
SELECT 'PartisipasiCoding',              COUNT(*) FROM `KeaktifanEkskulCoding.PartisipasiCoding`;

--Cek nilai NULL di kolom kunci
SELECT
  COUNTIF(NIS IS NULL)           AS null_NIS,
  COUNTIF(Nama_Lengkap IS NULL)  AS null_Nama,
  COUNTIF(Kelas IS NULL)         AS null_Kelas,
  COUNTIF(Kota_Wilayah IS NULL)  AS null_Kota
FROM `KeaktifanEkskulCoding.SiswaCoding`;

--Cek nilai unik Jenis_Kelamin
SELECT Jenis_Kelamin, COUNT(*) AS jumlah
FROM `KeaktifanEkskulCoding.SiswaCoding`
GROUP BY 1;

--Cek rentang nilai Pct_Kehadiran (harus 0–100)
SELECT
  MIN(Pct_Kehadiran) AS min_kehadiran,
  MAX(Pct_Kehadiran) AS max_kehadiran,
  AVG(Pct_Kehadiran) AS avg_kehadiran
FROM `KeaktifanEkskulCoding.PartisipasiCoding`;

-- ────────────────────────────────────────────────────────────
--  ANALISIS UTAMA
-- ────────────────────────────────────────────────────────────
 
--Total & persentase partisipasi per ekstrakurikuler
SELECT
  e.Kode_EK,
  e.Nama_Ekstrakurikuler,
  e.Platform_Tools,
  COUNT(p.ID_Partisipasi)                              AS total_peserta,
  ROUND(AVG(p.Pct_Kehadiran), 2)                       AS avg_kehadiran_pct,
  ROUND(AVG(p.Nilai_Akhir), 2)                         AS avg_nilai,
  COUNTIF(p.Sertifikat = 'Ya')                         AS total_sertifikat,
  ROUND(COUNTIF(p.Sertifikat = 'Ya') / COUNT(*) * 100, 1) AS pct_sertifikat
FROM `KeaktifanEkskulCoding.PartisipasiCoding` p
JOIN `KeaktifanEkskulCoding.EkstrakurikulerCoding` e
  ON p.Kode_EK = e.Kode_EK
GROUP BY 1, 2, 3
ORDER BY total_peserta DESC;

--Distribusi partisipasi per kelas & gender
SELECT
  s.Kelas,
  s.Jenis_Kelamin,
  COUNT(DISTINCT p.NIS)            AS jumlah_siswa,
  COUNT(p.ID_Partisipasi)          AS total_partisipasi,
  ROUND(AVG(p.Pct_Kehadiran), 2)  AS avg_kehadiran_pct,
  ROUND(AVG(p.Nilai_Akhir), 2)    AS avg_nilai
FROM `KeaktifanEkskulCoding.PartisipasiCoding` p
JOIN `KeaktifanEkskulCoding.SiswaCoding` s
  ON p.NIS = s.NIS
GROUP BY 1, 2
ORDER BY 1, 2;

--Tren partisipasi per semester
SELECT
  p.Tahun_Ajaran,
  p.Semester,
  CONCAT(p.Tahun_Ajaran, ' - ', p.Semester) AS periode,
  COUNT(DISTINCT p.NIS)                      AS jumlah_siswa_aktif,
  COUNT(p.ID_Partisipasi)                    AS total_pendaftaran,
  ROUND(AVG(p.Pct_Kehadiran), 2)            AS avg_kehadiran_pct,
  ROUND(AVG(p.Nilai_Akhir), 2)              AS avg_nilai
FROM `KeaktifanEkskulCoding.PartisipasiCoding` p
GROUP BY 1, 2, 3
ORDER BY 1, 2;

--Distribusi partisipasi per wilayah Jakarta
SELECT
  s.Kota_Wilayah,
  s.Kecamatan,
  COUNT(DISTINCT s.NIS)            AS total_siswa,
  COUNT(DISTINCT p.NIS)            AS siswa_aktif_ekskul,
  COUNT(p.ID_Partisipasi)          AS total_partisipasi,
  ROUND(AVG(p.Pct_Kehadiran), 2)  AS avg_kehadiran_pct
FROM `KeaktifanEkskulCoding.SiswaCoding` s
LEFT JOIN `KeaktifanEkskulCoding.PartisipasiCoding` p
  ON s.NIS = p.NIS
GROUP BY 1, 2
ORDER BY total_siswa DESC;

--Top 10 siswa dengan nilai tertinggi
SELECT
  s.NIS,
  s.Nama_Lengkap,
  s.Kelas,
  s.Nama_Sekolah,
  e.Nama_Ekstrakurikuler,
  p.Tahun_Ajaran,
  p.Semester,
  p.Pct_Kehadiran,
  p.Nilai_Akhir,
  p.Sertifikat
FROM `KeaktifanEkskulCoding.PartisipasiCoding` p
JOIN `KeaktifanEkskulCoding.SiswaCoding` s         ON p.NIS = s.NIS
JOIN `KeaktifanEkskulCoding.EkstrakurikulerCoding` e ON p.Kode_EK = e.Kode_EK
ORDER BY p.Nilai_Akhir DESC, p.Pct_Kehadiran DESC
LIMIT 10;

 --Performa instruktur berdasarkan rata-rata nilai siswa
SELECT
  i.ID_Instruktur,
  i.Nama_Instruktur,
  i.Spesialisasi,
  COUNT(p.ID_Partisipasi)          AS total_siswa_diajar,
  ROUND(AVG(p.Nilai_Akhir), 2)    AS avg_nilai_siswa,
  ROUND(AVG(p.Pct_Kehadiran), 2)  AS avg_kehadiran_siswa,
  COUNTIF(p.Sertifikat = 'Ya')    AS total_sertifikat_diterbitkan
FROM `KeaktifanEkskulCoding.PartisipasiCoding` p
JOIN `KeaktifanEkskulCoding.InstrukturCoding` i
  ON p.ID_Instruktur = i.ID_Instruktur
GROUP BY 1, 2, 3
ORDER BY avg_nilai_siswa DESC;

--Siswa yang mengikuti lebih dari 1 ekskul (multi-ekskul)
SELECT
  s.NIS,
  s.Nama_Lengkap,
  s.Kelas,
  s.Kota_Wilayah,
  COUNT(DISTINCT p.Kode_EK)       AS jumlah_ekskul,
  STRING_AGG(DISTINCT e.Nama_Ekstrakurikuler, ', ') AS daftar_ekskul,
  ROUND(AVG(p.Nilai_Akhir), 2)   AS avg_nilai
FROM `KeaktifanEkskulCoding.PartisipasiCoding` p
JOIN `KeaktifanEkskulCoding.SiswaCoding` s         ON p.NIS = s.NIS
JOIN `KeaktifanEkskulCoding.EkstrakurikulerCoding` e ON p.Kode_EK = e.Kode_EK
GROUP BY 1, 2, 3, 4
HAVING jumlah_ekskul > 1
ORDER BY jumlah_ekskul DESC, avg_nilai DESC;

-- ────────────────────────────────────────────────────────────
-- BUAT VIEW UNTUK POWER BI / LOOKER STUDIO
-- ────────────────────────────────────────────────────────────
 
-- View master (join semua tabel)

CREATE OR REPLACE VIEW `KeaktifanEkskulCoding.vw_master_partisipasi` AS
SELECT
  p.ID_Partisipasi,
  p.Tahun_Ajaran,
  p.Semester,
  p.Tanggal_Daftar,
  p.Status,
  p.Total_Pertemuan,
  p.Hadir,
  p.Pct_Kehadiran,
  p.Nilai_Akhir,
  p.Sertifikat,
  -- Siswa
  s.NIS,
  s.Nama_Lengkap,
  s.Jenis_Kelamin,
  s.Kelas,
  s.Usia_Tahun,
  s.Nama_Sekolah,
  s.Kecamatan,
  s.Kota_Wilayah,
  -- Ekstrakurikuler
  e.Kode_EK,
  e.Nama_Ekstrakurikuler,
  e.Platform_Tools,
  e.Hari,
  e.Jam_Mulai,
  e.Jam_Selesai,
  -- Instruktur
  i.Nama_Instruktur,
  i.Spesialisasi
FROM `KeaktifanEkskulCoding.PartisipasiCoding` p
LEFT JOIN `KeaktifanEkskulCoding.SiswaCoding` s 
       ON p.NIS = s.NIS
LEFT JOIN `KeaktifanEkskulCoding.EkstrakurikulerCoding` e 
       ON p.Kode_EK = e.Kode_EK
LEFT JOIN `KeaktifanEkskulCoding.InstrukturCoding` i 
       ON p.ID_Instruktur = i.ID_Instruktur;

--View ringkasan per ekskul (siap pakai di dashboard)
CREATE OR REPLACE VIEW `KeaktifanEkskulCoding.vw_ringkasan_ekskul` AS
SELECT
  Kode_EK,
  Nama_Ekstrakurikuler,
  Platform_Tools,
  Tahun_Ajaran,
  Semester,
  COUNT(DISTINCT NIS)           AS total_siswa,
  ROUND(AVG(Pct_Kehadiran), 2)  AS avg_kehadiran,
  ROUND(AVG(Nilai_Akhir), 2)    AS avg_nilai,
  COUNTIF(Sertifikat = 'Ya')    AS total_sertifikat
FROM `KeaktifanEkskulCoding.vw_master_partisipasi`
GROUP BY
  Kode_EK,
  Nama_Ekstrakurikuler,
  Platform_Tools,
  Tahun_Ajaran,
  Semester;

