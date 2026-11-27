# Quy tắc bất biến cho mọi agent
- Không sửa/xóa bút toán đã ghi sổ; đảo hoặc điều chỉnh bằng chứng từ mới có liên kết.
- Nợ = Có; kỳ mở; quyền server-side; chính sách đã duyệt; tất cả cập nhật liên quan cùng transaction.
- Không dùng JS Number để tính tiền; numeric/decimal, JSON decimal dạng string; làm tròn có quy tắc và phân bổ phần dư xác định.
- Không lưu mật khẩu ngân hàng, không tự chuyển tiền. Không log dữ liệu lương, token, số tài khoản đầy đủ.
- Không bỏ qua lỗi, không xóa test, không sửa trực tiếp production. Không dùng mock thay kiểm thử tích hợp DB.
- Mỗi PR có migration, test, tài liệu, review và rollback; cập nhật traceability. Dữ liệu mẫu phải được đánh dấu DEMO.
