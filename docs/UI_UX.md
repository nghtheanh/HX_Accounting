# UI/UX desktop-first
Tiếng Việt toàn bộ label, lỗi, ngày dd/MM/yyyy, số vi-VN; mã tài khoản giữ nguyên. Tên/logo cấu hình; màu đề xuất navy #173B57, xanh #2563EB, nền #F5F7FA; font Be Vietnam Pro hoặc Inter. Không dùng logo MISA. Sidebar theo nhóm tài chính, thương mại, sản xuất, nhân sự, tổng hợp; topbar kỳ, tìm kiếm, thông báo.
Mọi phân hệ: list có lọc ngày/trạng thái/đối tượng, phân trang server, cột tùy chỉnh, export theo quyền; detail có chứng từ liên quan và audit; form có tab thông tin, dòng hàng, đính kèm, định khoản preview; keyboard tab/enter, paste Excel có preview lỗi từng dòng; autosave draft không tự ghi sổ. Disable action không có quyền nhưng backend vẫn kiểm tra.
- M01 Tổng quan: Doanh thu thuần, giá vốn, lợi nhuận gộp, tiền, nợ quá hạn; lọc kỳ và drill-down; kiểm tra UI: Dashboard khớp sổ đã ghi; nhãn tạm tính.
- M02 Tiền mặt: Phiếu thu/chi, chuyển quỹ, kiểm kê, sổ quỹ; kiểm tra UI: Chuyển quỹ không sinh doanh thu.
- M03 Ngân hàng: Nhập tay, CSV/XLSX, đối soát, adapter API đọc; kiểm tra UI: Import lặp không nhân đôi.
- M04 Bán hàng: Báo giá, đơn, size/màu, giao nhiều đợt, trả hàng, chiết khấu; kiểm tra UI: Không ghi doanh thu chỉ vì đặt cọc.
- M05 Mua hàng: Đề nghị, đặt hàng, nhận hàng, hóa đơn, trả hàng; kiểm tra UI: Nhận hàng và hóa đơn có thể khác ngày.
- M06 Phải thu: Khoản mở, hạn trả, ứng trước, phân bổ nhiều-nhiều; kiểm tra UI: Tổng chi tiết khớp tài khoản.
- M07 Phải trả: Nợ nhà cung cấp, ứng trước, đối trừ; kiểm tra UI: Không phân bổ vượt khoản mở.
- M08 Kho: SKU/lô/màu, khu logic, kiểm kê, bình quân liên hoàn; kiểm tra UI: Không tồn âm; đối soát lượng và giá trị.
- M09 Danh mục: Đối tác, SKU, size, UOM, nhóm chi, tài khoản; kiểm tra UI: Mã duy nhất; ngừng dùng thay xóa.
- M10 Tổng hợp: Chứng từ, bút toán, kỳ, kết chuyển, điều chỉnh; kiểm tra UI: Nợ=Có; kỳ khóa bất biến.
- M11 Sản xuất: MTO/MTS, lệnh/lô, cắt/may/in/QC, nhập từng phần; kiểm tra UI: Quản lý cập nhật; truy vết sản lượng.
- M12 BOM: Phiên bản định mức theo mẫu/size, hao hụt; kiểm tra UI: Lệnh giữ phiên bản được duyệt.
- M13 Giá thành: WIP, nguyên liệu, lương, gia công, overhead, chốt; kiểm tra UI: Không tính trùng phôi; đối soát WIP.
- M14 Gia công: Giao/nhận vật tư, hàng đạt/lỗi, đơn giá, công nợ; kiểm tra UI: Giao vật tư không phải bán hàng.
- M15 Nhân sự: Hồ sơ tối thiểu, nhóm, trạng thái; kiểm tra UI: Thông tin lương hạn chế truy cập.
- M16 Chấm công: Import máy chấm công, sửa có duyệt, sản lượng; kiểm tra UI: Import trùng không tăng công.
- M17 Tiền lương: Lương tháng, ngày/giờ/sản phẩm/khoán, ứng trước; kiểm tra UI: Bảng lương chốt không tự tính lại.
- M18 Tài sản: Danh mục, tăng/giảm, khấu hao; kiểm tra UI: Không khấu hao vượt giá trị phân bổ.
- M19 CCDC: Ghi nhận và phân bổ theo kỳ; kiểm tra UI: Không phân bổ trùng kỳ.
- M20 Hóa đơn: Số/ký hiệu/ngày/MST/dòng tiền/thuế/XML/PDF, đối chiếu; kiểm tra UI: Không phát hành hóa đơn; cảnh báo sai lệch.
- M21 Báo cáo: Sổ cái, cân đối phát sinh, P&L, kho, nợ, WIP, lương; kiểm tra UI: Tổng báo cáo truy về chứng từ.
- M22 Ngân sách: Theo nhóm chi/kỳ, so thực tế, vượt mức; kiểm tra UI: Vượt ngưỡng chuyển chủ duyệt.
- M23 Phê duyệt: Rule version, hạn mức theo loại chi, từ chối; kiểm tra UI: Đổi số tiền sau duyệt phải duyệt lại.
- M24 Quản trị: RBAC, audit, cấu hình, import, cảnh báo; kiểm tra UI: Không vượt quyền hoặc ghi sổ khi thiếu policy.
Dashboard: bộ lọc kỳ, chỉ số đã ghi sổ/tạm tính phân biệt, doanh thu/giá vốn/lãi gộp, dòng tiền, tuổi nợ, tồn thấp, vượt định mức; click về danh sách nguồn. Cảnh báo in-app, cấu hình ngưỡng và tần suất, dedupe theo đối tượng/kỳ; không gửi lương hay số dư qua kênh ngoài mặc định.
