# Quy tắc kế toán và thuật toán
## Chính sách
Sandbox dùng tài khoản giả lập 111,112,131,331,152,154,155,511,632,334, chi phí chung. Không gán mặc định chế độ pháp định. Policy có version, ngày hiệu lực, trạng thái draft/approved/retired; ghi sổ thật bị chặn nếu chưa có policy và mapping thuế/định khoản duyệt. Lưu snapshot policy trên chứng từ. Không tự đặt thuế suất. Các bút toán sau bỏ qua thuế chỉ để kiểm thử.
| Sự kiện | Nợ | Có |
|---|---|---|
| Nhận đặt cọc khách | 111/112 | 131 |
| Bán chịu đủ điều kiện | 131 | 511 |
| Xuất bán | 632 | 155 |
| Thu nợ | 112 | 131 |
| Nhập vải mua chịu | 152 | 331 |
| Xuất sản xuất | 154 | 152 |
| Nhân công trực tiếp đã xác nhận | 154 | 334 |
| Nhập thành phẩm | 155 | 154 |
| Trả nhà cung cấp | 331 | 112 |
| Chuyển tiền nội bộ | 112 đích | 112 nguồn |
## Ghi sổ
Draft -> submitted -> approved/rejected -> posted. Rejected quay về draft; sửa sau duyệt tăng version và hủy duyệt cũ. Posted bất biến; reverse tạo bút toán ngược ở kỳ mở, giữ liên kết, đồng thời xử lý kho/công nợ/giá thành tương ứng; không chỉ đảo GL. Khóa kỳ khi các sổ phụ khớp, WIP/giá vốn chốt và không có chứng từ treo cần xử lý. Mở kỳ cần chủ duyệt, lý do, audit.
## Kho
Pool giá SKU/kho, lô lưu lượng. average=(V+giá trị nhập)/(Q+lượng nhập). Xuất x: C=round(x*V/Q); nếu xuất hết dùng toàn bộ V để không dư. Lưu Q,V, giá trước/sau và movement nguồn. Khóa hàng pool và lô theo thứ tự ổn định, kiểm tra đủ lượng. Nhập lùi ngày: dựng preview replay theo ngày nghiệp vụ và sequence, tính tác động WIP/COGS; nếu chạm kỳ khóa từ chối, kế toán xử lý điều chỉnh kỳ mở theo policy. Trả vật tư theo giá nguồn; chi phí mua bổ sung phân bổ có phê duyệt; không ghi âm giả để cân.
## Giá thành
MTO đối tượng lệnh/đơn, MTS đối tượng lô; liên kết đơn qua dòng giao. WIP cuối = WIP đầu + chi phí đủ điều kiện - giá thành hoàn thành - khoản thu hồi/điều chỉnh. Phân bổ overhead theo pool và driver được duyệt (số lượng, giờ công, giờ máy, nhân công, hệ số), kiểm tra mẫu số >0, phần dư làm tròn phân bổ xác định theo ID. Công suất bình thường, hao hụt bất thường, phương pháp WIP cần kế toán xác nhận. Nhập từng phần dùng giá tạm tính; chốt tạo điều chỉnh tồn kho/COGS theo số lượng còn tồn/đã bán, không ghi đè lịch sử. Phôi MTS xuất sang lệnh in là một chi phí đầu vào theo giá xuất kho, không cộng lại các cấu phần cũ. Báo cáo lãi gộp = doanh thu thuần - COGS; chi phí bán hàng/quản lý không mặc nhiên vốn hóa.
## Công nợ
Khoản mở theo đối tác, chứng từ, hạn, tiền tệ; ứng trước là khoản riêng chưa phân bổ. Phân bổ nhiều-nhiều, kiểm tra cùng đối tác/loại/tiền tệ và tổng <= số dư còn lại; không ghi thu tiền lần hai khi phân bổ. Tuổi nợ theo ngày đến hạn tại ngày báo cáo, tách ứng trước. Hoàn tiền/trả hàng/chiết khấu phải có chứng từ.
## Lương
Lương gộp = tổng thành phần đã duyệt; tiền còn trả = gộp - khấu trừ hợp lệ - ứng trước. Tạm ứng không ghi chi phí lương lần hai. Chấm công import raw, map mã máy, xử lý ca qua ngày, trùng và thiếu log; quản lý xác nhận trước tính. Công thức versioned, không eval tùy ý; dùng loại công thức whitelist, decimal, ngày hiệu lực. Chốt bảng lương và phân bổ nhân công một lần; điều chỉnh bằng run bổ sung. Thuế/bảo hiểm/tăng ca thực tế phải được duyệt.
