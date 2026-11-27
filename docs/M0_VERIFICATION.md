# Kết quả xác minh Milestone 0

Ngày 27/11/2026. Kiểm thử trên Windows với Node.js 24.22.3 và PostgreSQL 17.12 chạy cục bộ, bằng DB riêng `workpilot_demo`. Sáu ca Golden dùng dữ liệu DEMO.

- `pnpm install --frozen-lockfile` thành công với pnpm 10.34.9. `pnpm lint` hoàn tất với ngưỡng 0 cảnh báo. `pnpm build` biên dịch API và dựng trang Next.js.
- `pnpm test` chạy 6 ca Golden và 1 ca HTTP. Liveness trả 200 và kết quả readiness trả 503 khi thiếu cấu hình DB.
- `pnpm db:deploy` áp một migration trên DB trống. Lần thứ hai không còn migration chờ. `pnpm db:status` xác nhận schema hiện hành.
- `pnpm test:db` xác nhận PostgreSQL major 17, schema `workpilot`, một bản ghi migration thành công và readiness 200 qua kết nối thật.
- `pnpm test:smoke` chạy 2 ca qua HTTP trên bản build đang chạy. Trang tiếng Việt có nhãn DEMO và cả hai API health trả 200.
- `docker compose config --quiet` thành công trên Windows với Compose v2.40.3. `actionlint` 1.7.12 kiểm tra workflow `.github/workflows/ci.yml` thành công.

## Docker Engine và stack cục bộ

- Phiên Windows thiếu quyền Administrator để bật WSL 2 (DISM trả mã 740). Docker Engine 29.9.3 và Compose v5.7.2 được cài và xác minh trên máy ảo Alpine Linux 3.24 x86_64 cục bộ qua VMware Workstation. Dịch vụ `docker` đang chạy và được đăng ký trong runlevel `default` của OpenRC.
- Trên Engine cục bộ, `docker compose up --build --detach --wait --wait-timeout 180` dựng thành công bản `a22751c` trên volume DEMO mới. `docker compose ps --all` xác nhận `db`, `api`, `web` ở trạng thái `healthy` và `migrate` thoát mã 0. Các cổng ứng dụng và DB bind loopback của máy ảo.
- Log `migrate` xác nhận áp `20261127000000_bootstrap`; `db:status` xác nhận schema hiện hành và lần chạy `db:deploy` tiếp theo không còn migration chờ. Một ca tích hợp PostgreSQL 17 thật và hai ca smoke HTTP đều đạt. Stack DEMO vẫn chạy trong máy ảo tại thời điểm bàn giao.

## GitHub Actions và Docker Compose

- Workflow `M0 verification` chạy trên `ubuntu-latest` cho commit `a22751cd8fee0ec01f5ac5baa71a1e7070c868c4` trên `main`. Job `verify` hoàn tất thành công trong 1 phút 55 giây. [Run 45963694631](https://github.com/nghtheanh/HX_Accounting/actions/runs/45963694631)
- Runner build image và chạy đủ `db`, `migrate`, `api`, `web` bằng `docker compose up --build --detach --wait --wait-timeout 180`. Log xác nhận `db`, `api`, `web` khỏe và `migrate` đã hoàn thành. `pnpm db:status`, lần triển khai lại migration, `pnpm test:db` với PostgreSQL thực trong container và hai bài `pnpm test:smoke` đều đạt.
- `docker compose down --volumes` hoàn tất, dọn các container, mạng và volume DEMO của lần chạy CI. [Log job verify](https://github.com/nghtheanh/HX_Accounting/actions/runs/45963694631/job/140387217439)

## Cổng phê duyệt

Review tại workspace đã đối chiếu phạm vi với M0, migration bootstrap với trạng thái PostgreSQL, hai đường dẫn health với hợp đồng và dữ liệu mẫu với nhãn DEMO. Quy trình rollback volume DEMO ở [README](../README.md). Xác minh kỹ thuật M0 đã đạt trên Docker Engine cục bộ và GitHub Actions. Chờ người dùng phê duyệt M0 trước khi mở M1.
