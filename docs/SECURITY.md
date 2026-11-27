# Bảo mật và RBAC
| Vai trò | Quyền |
|---|---|
| Chủ | Báo cáo toàn bộ, duyệt đặc biệt, cấu hình hạn mức, mở kỳ có lý do |
| Kế toán | Lập/ghi sổ theo policy, tự duyệt thường, công nợ, kho, lương, đối soát |
| Quản lý | Lệnh, sản lượng, QC, xác nhận công, đề nghị vật tư; không xem lương toàn công ty |
| Thủ kho | Nhập/xuất/kiểm kê theo quyền, không xem lợi nhuận |
| Bán hàng | Khách/đơn được giao, công nợ được cấp quyền |
| IT | Quản trị kỹ thuật không mặc nhiên có quyền tài chính |
Deny-by-default, scope company và đối tượng, kiểm tra mọi endpoint/export. MFA cho chủ/kế toán, Argon2id, cookie HttpOnly Secure SameSite, CSRF, rate limit, session revoke. Secrets ngoài repo, TLS, DB private, file private signed URL ngắn hạn, scan file, giới hạn upload, chống formula injection khi export. Audit actor/action/entity/version/reason/time/request ID, redact secrets, append-only cho app role. Log kỹ thuật không chứa dữ liệu lương. Backup mã hóa offsite, PITR, kiểm tra restore; quyền break-glass có audit. Không đưa dữ liệu thật cho AI Coding Agent. Kiểm thử IDOR, SQL injection, XSS, CSRF, privilege escalation, upload, replay, concurrent posting.
