# Laporan Analisis Integrasi IoT, Web, dan AI

## 1. Pendahuluan
Project ini merupakan contoh integrasi tiga platform utama, yaitu **IoT**, **Web**, dan **AI**, dalam satu alur kerja sistem monitoring sensor lingkungan. Tujuannya adalah mengumpulkan data sensor, mengelola data melalui web, lalu memproses data tersebut dengan model AI untuk menghasilkan prediksi kondisi sensor.

## 2. Peran Masing-Masing Platform

### IoT
IoT berperan sebagai sumber data. Pada project ini, data sensor lingkungan seperti temperature, humidity, CO, LPG, smoke, light intensity, dan motion status dihasilkan secara simulasi melalui script PHP pada folder `simulation/`.

### Web
Web berperan sebagai pusat pengelolaan data. Teknologi PHP digunakan untuk menerima data sensor, menyimpannya ke MySQL, menampilkan dashboard, serta menyediakan API untuk mengirim dan membaca data. File utama yang mendukung fungsi ini berada pada folder `api/`, `config/`, `index.php`, dan `assets/`.

### AI
AI berperan sebagai mesin analisis dan prediksi. Model machine learning disimpan dalam format `.pkl` dan dijalankan melalui script Python pada folder `ai_model/`. Data sensor yang diterima akan diproses oleh model untuk menentukan status seperti `NORMAL`, `WARNING`, atau `DANGER`.

## 3. Alur Integrasi Antar Platform

Integrasi ketiga platform bekerja dengan alur berikut:

1. IoT menghasilkan data sensor lingkungan.
2. Web menerima data tersebut melalui API dan menyimpannya ke database MySQL.
3. Web memanggil script AI Python untuk melakukan prediksi berdasarkan data sensor terbaru.
4. AI mengembalikan hasil prediksi dalam bentuk JSON.
5. Web menyimpan hasil prediksi ke database dan menampilkannya di dashboard.

Secara sederhana, alurnya dapat digambarkan sebagai berikut:

```text
IoT / Sensor Simulasi
        ↓
Web (PHP + MySQL)
        ↓
AI (Python Model)
        ↓
Web menampilkan hasil prediksi
```

## 4. Bentuk Integrasi pada Project

- **IoT ke Web**: data sensor dikirim ke API PHP untuk disimpan.
- **Web ke AI**: PHP mengirim data sensor ke script Python untuk diprediksi.
- **AI ke Web**: hasil prediksi dikirim kembali dalam format JSON lalu ditampilkan pada dashboard.

Integrasi ini membuat sistem tidak hanya menampilkan data mentah, tetapi juga menghasilkan informasi yang lebih bermakna untuk analisis kondisi lingkungan.

## 5. Kesimpulan

Kesimpulannya, IoT, Web, dan AI saling melengkapi dalam project ini. IoT bertugas mengumpulkan data, Web bertugas mengelola dan menampilkan data, sedangkan AI bertugas menganalisis data dan memberikan hasil prediksi. Kombinasi ketiga platform ini menghasilkan sistem monitoring yang lebih interaktif, informatif, dan cerdas.
