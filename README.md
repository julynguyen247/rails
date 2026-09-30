# Dayflow

Ứng dụng todo một trang xây bằng Rails 6 và PostgreSQL. Có tạo, sửa, xóa, đánh dấu hoàn thành, deadline, mức ưu tiên, ảnh đính kèm, bộ lọc và thống kê tiến độ.

## Chạy local

Yêu cầu: Ruby 2.7.8, Node.js, Yarn, PostgreSQL và thư viện `libpq-dev`.

```bash
# Ubuntu/Debian: cài PostgreSQL client để build gem pg
sudo apt install libpq-dev

bundle install
yarn install

# Nếu máy có Docker, có thể chạy PostgreSQL nhanh bằng:
docker compose up -d postgres

bin/rails db:prepare
bin/rails db:seed       # tùy chọn, thêm dữ liệu mẫu
bin/rails server
```

Mở `http://localhost:3000`.

## Xem database bằng pgAdmin

```bash
docker compose up -d pgadmin
```

Mở `http://localhost:5050`, đăng nhập bằng `admin@dayflow.dev` / `admin123`.
Server `Dayflow PostgreSQL` đã được tạo sẵn; khi được hỏi mật khẩu database, nhập `postgres`.

Mặc định app kết nối `postgres:postgres@localhost:5432/dayflow_development`. Có thể đổi bằng các biến môi trường:

```bash
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=postgres
DB_PASSWORD=postgres
DB_NAME=dayflow_development
```

Ở production, đặt một biến `DATABASE_URL` chuẩn PostgreSQL.

## Kiểm thử

```bash
bin/rails db:test:prepare
bin/rails test
```
