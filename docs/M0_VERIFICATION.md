# Kết quả xác minh Milestone 0

Ngày 27/11/2026. Kiểm thử trên Windows với Node.js 24.22.3 và PostgreSQL 17.12 chạy cục bộ, bằng DB riêng `workpilot_demo`. Sáu ca Golden dùng dữ liệu DEMO.

- `pnpm install --frozen-lockfile` thành công với pnpm 10.34.9. `pnpm lint` hoàn tất với ngưỡng 0 cảnh báo. `pnpm build` biên dịch API và dựng trang Next.js.
- `pnpm test` chạy 6 ca Golden và 1 ca HTTP. Liveness trả 200 và kết quả readiness trả 503 khi thiếu cấu hình DB.
- `pnpm db:deploy` áp một migration trên DB trống. Lần thứ hai không còn migration chờ. `pnpm db:status` xác nhận schema hiện hành.
- `pnpm test:db` xác nhận PostgreSQL major 17, schema `workpilot`, một bản ghi migration thành công và readiness 200 qua kết nối thật.
- `pnpm test:smoke` chạy 2 ca qua HTTP trên bản build đang chạy. Trang tiếng Việt có nhãn DEMO và cả hai API health trả 200.
- `docker compose config --quiet` thành công với Compose v2.40.3. Máy kiểm thử thiếu Docker Engine, nên build/chạy Compose đầy đủ và kiểm chứng workflow trên GitHub Actions vẫn cần môi trường có Docker Engine và runner.

Review tại workspace đã đối chiếu phạm vi với M0, migration bootstrap với trạng thái PostgreSQL, hai đường dẫn health với hợp đồng và dữ liệu mẫu với nhãn DEMO. Quy trình rollback volume DEMO ở [README](../README.md). Trạng thái cổng M0 đang chờ bằng chứng chạy Compose/CI và phê duyệt trước khi mở M1.
