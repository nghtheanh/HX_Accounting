# Ma trận truy vết
| FR | Module | Kiểm tra nghiệm thu |
|---|---|---|
| FR-M01 | Tổng quan | Dashboard khớp sổ đã ghi; nhãn tạm tính |
| FR-M02 | Tiền mặt | Chuyển quỹ không sinh doanh thu |
| FR-M03 | Ngân hàng | Import lặp không nhân đôi |
| FR-M04 | Bán hàng | Không ghi doanh thu chỉ vì đặt cọc |
| FR-M05 | Mua hàng | Nhận hàng và hóa đơn có thể khác ngày |
| FR-M06 | Phải thu | Tổng chi tiết khớp tài khoản |
| FR-M07 | Phải trả | Không phân bổ vượt khoản mở |
| FR-M08 | Kho | Không tồn âm; đối soát lượng và giá trị |
| FR-M09 | Danh mục | Mã duy nhất; ngừng dùng thay xóa |
| FR-M10 | Tổng hợp | Nợ=Có; kỳ khóa bất biến |
| FR-M11 | Sản xuất | Quản lý cập nhật; truy vết sản lượng |
| FR-M12 | BOM | Lệnh giữ phiên bản được duyệt |
| FR-M13 | Giá thành | Không tính trùng phôi; đối soát WIP |
| FR-M14 | Gia công | Giao vật tư không phải bán hàng |
| FR-M15 | Nhân sự | Thông tin lương hạn chế truy cập |
| FR-M16 | Chấm công | Import trùng không tăng công |
| FR-M17 | Tiền lương | Bảng lương chốt không tự tính lại |
| FR-M18 | Tài sản | Không khấu hao vượt giá trị phân bổ |
| FR-M19 | CCDC | Không phân bổ trùng kỳ |
| FR-M20 | Hóa đơn | Không phát hành hóa đơn; cảnh báo sai lệch |
| FR-M21 | Báo cáo | Tổng báo cáo truy về chứng từ |
| FR-M22 | Ngân sách | Vượt ngưỡng chuyển chủ duyệt |
| FR-M23 | Phê duyệt | Đổi số tiền sau duyệt phải duyệt lại |
| FR-M24 | Quản trị | Không vượt quyền hoặc ghi sổ khi thiếu policy |

## Milestone 0 · Truy vết nền tảng

- **M0-01** · Workspace, phiên bản, lockfile, build và lint. Bằng chứng `pnpm install --frozen-lockfile`, `pnpm build`, `pnpm lint`. Quyết định trong [ADR 0001](adr/0001-m0-foundation.md).
- **M0-02** · Web DEMO tiếng Việt và HTTP health. Bằng chứng `pnpm test` (HTTP liveness/readiness không có DB) và `pnpm test:smoke` (web và API đã chạy).
- **M0-03** · Compose, PostgreSQL thật, migration bootstrap và CI. Bằng chứng `docker compose config --quiet`, `docker compose up --build --detach --wait`, `pnpm db:status`, `pnpm db:deploy` lần hai và `pnpm test:db`. Rollback DEMO trong [README](../README.md).
- **M0-04** · Đối chiếu đặc tả, khoảng trống, lộ trình, kiểm thử và chuyển đổi dữ liệu. Bằng chứng trong [kế hoạch triển khai](IMPLEMENTATION_PLAN.md) và `pnpm test:golden`. Sáu ca Golden là oracle tính toán độc lập; các case T01–T20 thuộc milestone nghiệp vụ hoặc phát hành.
