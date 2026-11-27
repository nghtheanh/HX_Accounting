# WorkPilot Accounting v1.0 — Development Kit
Bộ đặc tả phát triển, không phải ứng dụng đã chạy. Tên WorkPilot là mã dự án; tên hiển thị lấy từ cấu hình doanh nghiệp.
## Bắt đầu
1. Giải nén vào repository mới, mở bằng Coding Agent. Đọc AGENTS.md, MASTER_PROMPT.md, DECISION_LOG.md.
2. Đọc SRS, quy tắc nghiệp vụ và roadmap; triển khai M0 trước. Không yêu cầu agent sinh cả ERP trong một lượt.
3. SQL và OpenAPI là hợp đồng khởi điểm cần hoàn thiện theo từng milestone; không chạy SQL trên dữ liệu thật.
4. Chạy `python tests/verify_golden.py` để kiểm tra các phép tính mẫu độc lập. Đây không phải test ứng dụng.
5. Kế toán xác nhận chính sách, đối soát dữ liệu và ký nghiệm thu trước cutover.
## Thứ tự ưu tiên khi mâu thuẫn
DECISION_LOG > ACCOUNTING_RULES (chính sách đã duyệt) > SRS > API/schema > UI. Nếu mâu thuẫn liên quan tiền, dừng nghiệp vụ và ghi issue, không tự chọn.

## Milestone 0 · Môi trường phát triển

Bản DEMO có trang web tiếng Việt và API kiểm tra trạng thái. Xem [phân tích đặc tả và kế hoạch](docs/IMPLEMENTATION_PLAN.md), [ADR nền tảng](docs/adr/0001-m0-foundation.md), [hợp đồng health](contracts/m0-health.openapi.json) và [kết quả xác minh](docs/M0_VERIFICATION.md).

Dùng Docker Engine và Compose v2 với Linux containers để chạy trọn bộ DEMO:

```sh
docker compose up --build --detach --wait --wait-timeout 180
docker compose ps --all
```

Web ở `http://localhost:3000`. API dùng `http://localhost:3001/api/v1/health` và `/api/v1/health/ready`. PostgreSQL 17.12 cho host ở `127.0.0.1:54329`. Service `migrate` áp bootstrap một lần trước khi khởi động API.

Để phát triển trên host, cài Node và pnpm đúng phiên bản trong `.node-version` và `package.json`, cùng Python 3.12+. Chỉ khởi động service DB, thiết lập `DATABASE_URL` từ [.env.example](.env.example) trong shell. Ví dụ PowerShell dùng `$env:DATABASE_URL = 'postgresql://workpilot_demo:workpilot_demo@127.0.0.1:54329/workpilot_demo'`.

```sh
docker compose up --detach --wait db
pnpm install --frozen-lockfile
pnpm db:deploy
pnpm dev
```

Web tự cập nhật khi chỉnh mã. Khởi động lại lệnh dev sau khi sửa TypeScript API để biên dịch lại. Với cả frontend, API và DB đang chạy, chạy `pnpm test:smoke`. Dùng các lệnh sau để xác minh build và migration trên DB DEMO:

```sh
pnpm lint
pnpm build
pnpm test
pnpm db:status
pnpm test:db
```

`docker compose down` dừng bộ DEMO và giữ volume. Rollback M0 trên bộ dùng thử có thể bỏ toàn bộ volume DEMO bằng `docker compose down --volumes` từ thư mục này nếu đã xác nhận dữ liệu trong volume có thể bỏ. Sau đó quay lại phiên bản đặc tả ban đầu hoặc dựng lại M0. Bootstrap tạo schema rỗng và lịch sử migration Prisma. Chỉ dùng thông tin đăng nhập DEMO và DB cô lập cho các lệnh trên.
