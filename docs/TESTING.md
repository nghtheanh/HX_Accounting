# Kiểm thử và nghiệm thu
Unit decimal/domain; integration PostgreSQL thật với transaction/locks/constraints; API contract; E2E role-based; migration reconciliation; security, load, backup restore. Golden JSON là oracle giả lập không phải chính sách thật. Thêm test cho từng FR và lưu traceability. Không dùng số liệu mẫu trong production.
| Case | Kỳ vọng |
|---|---|
| T01 journal lệch | reject, rollback toàn bộ |
| T02 post trùng hoặc 2 request đồng thời | duy nhất một journal và movement |
| T03 kỳ khóa / policy thiếu | reject |
| T04 chuyển tiền nội bộ | doanh thu/chi phí không đổi |
| T05 đặt cọc và phân bổ nhiều đơn | không ghi doanh thu/thu tiền hai lần |
| T06 xuất kho vượt lô/pool | reject |
| T07 bình quân và xuất hết | không dư giá trị khi lượng=0 |
| T08 nhập lùi ngày chạm kỳ khóa | không thay đổi lịch sử |
| T09 BOM version | lệnh cũ không đổi |
| T10 MTS phôi sang MTO | không cộng trùng giá phôi |
| T11 WIP/overhead | bảo toàn tổng chi phí, xử lý mẫu số 0 |
| T12 lương ứng trước | không ghi chi phí hai lần |
| T13 sửa phiếu đã duyệt | mất hiệu lực duyệt |
| T14 IDOR và export | deny |
| T15 import cùng file | không nhân đôi |
| T16 backup restore | sổ và checksum đối soát |
| T17 hóa đơn lệch chứng từ | cảnh báo, không tự ghi |
| T18 chấm công trùng, ca qua ngày | không cộng đôi; review ngoại lệ |
| T19 chi đặc biệt | kế toán không tự duyệt |
| T20 reverse | ledger và sổ phụ đồng bộ |
Gate production: mọi case trọng yếu pass, dữ liệu thật đối soát, chính sách ký, backup restore thành công, không còn lỗi critical/high chưa xử lý. Chủ và kế toán ký nghiệm thu.
