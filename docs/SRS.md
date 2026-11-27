# SRS — yêu cầu chức năng
## Phạm vi
### FR-M01
**Tổng quan** — Doanh thu thuần, giá vốn, lợi nhuận gộp, tiền, nợ quá hạn; lọc kỳ và drill-down.
- Tiêu chí nghiệm thu: Dashboard khớp sổ đã ghi; nhãn tạm tính.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M02
**Tiền mặt** — Phiếu thu/chi, chuyển quỹ, kiểm kê, sổ quỹ.
- Tiêu chí nghiệm thu: Chuyển quỹ không sinh doanh thu.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M03
**Ngân hàng** — Nhập tay, CSV/XLSX, đối soát, adapter API đọc.
- Tiêu chí nghiệm thu: Import lặp không nhân đôi.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M04
**Bán hàng** — Báo giá, đơn, size/màu, giao nhiều đợt, trả hàng, chiết khấu.
- Tiêu chí nghiệm thu: Không ghi doanh thu chỉ vì đặt cọc.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M05
**Mua hàng** — Đề nghị, đặt hàng, nhận hàng, hóa đơn, trả hàng.
- Tiêu chí nghiệm thu: Nhận hàng và hóa đơn có thể khác ngày.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M06
**Phải thu** — Khoản mở, hạn trả, ứng trước, phân bổ nhiều-nhiều.
- Tiêu chí nghiệm thu: Tổng chi tiết khớp tài khoản.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M07
**Phải trả** — Nợ nhà cung cấp, ứng trước, đối trừ.
- Tiêu chí nghiệm thu: Không phân bổ vượt khoản mở.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M08
**Kho** — SKU/lô/màu, khu logic, kiểm kê, bình quân liên hoàn.
- Tiêu chí nghiệm thu: Không tồn âm; đối soát lượng và giá trị.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M09
**Danh mục** — Đối tác, SKU, size, UOM, nhóm chi, tài khoản.
- Tiêu chí nghiệm thu: Mã duy nhất; ngừng dùng thay xóa.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M10
**Tổng hợp** — Chứng từ, bút toán, kỳ, kết chuyển, điều chỉnh.
- Tiêu chí nghiệm thu: Nợ=Có; kỳ khóa bất biến.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M11
**Sản xuất** — MTO/MTS, lệnh/lô, cắt/may/in/QC, nhập từng phần.
- Tiêu chí nghiệm thu: Quản lý cập nhật; truy vết sản lượng.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M12
**BOM** — Phiên bản định mức theo mẫu/size, hao hụt.
- Tiêu chí nghiệm thu: Lệnh giữ phiên bản được duyệt.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M13
**Giá thành** — WIP, nguyên liệu, lương, gia công, overhead, chốt.
- Tiêu chí nghiệm thu: Không tính trùng phôi; đối soát WIP.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M14
**Gia công** — Giao/nhận vật tư, hàng đạt/lỗi, đơn giá, công nợ.
- Tiêu chí nghiệm thu: Giao vật tư không phải bán hàng.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M15
**Nhân sự** — Hồ sơ tối thiểu, nhóm, trạng thái.
- Tiêu chí nghiệm thu: Thông tin lương hạn chế truy cập.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M16
**Chấm công** — Import máy chấm công, sửa có duyệt, sản lượng.
- Tiêu chí nghiệm thu: Import trùng không tăng công.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M17
**Tiền lương** — Lương tháng, ngày/giờ/sản phẩm/khoán, ứng trước.
- Tiêu chí nghiệm thu: Bảng lương chốt không tự tính lại.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M18
**Tài sản** — Danh mục, tăng/giảm, khấu hao.
- Tiêu chí nghiệm thu: Không khấu hao vượt giá trị phân bổ.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M19
**CCDC** — Ghi nhận và phân bổ theo kỳ.
- Tiêu chí nghiệm thu: Không phân bổ trùng kỳ.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M20
**Hóa đơn** — Số/ký hiệu/ngày/MST/dòng tiền/thuế/XML/PDF, đối chiếu.
- Tiêu chí nghiệm thu: Không phát hành hóa đơn; cảnh báo sai lệch.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M21
**Báo cáo** — Sổ cái, cân đối phát sinh, P&L, kho, nợ, WIP, lương.
- Tiêu chí nghiệm thu: Tổng báo cáo truy về chứng từ.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M22
**Ngân sách** — Theo nhóm chi/kỳ, so thực tế, vượt mức.
- Tiêu chí nghiệm thu: Vượt ngưỡng chuyển chủ duyệt.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M23
**Phê duyệt** — Rule version, hạn mức theo loại chi, từ chối.
- Tiêu chí nghiệm thu: Đổi số tiền sau duyệt phải duyệt lại.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
### FR-M24
**Quản trị** — RBAC, audit, cấu hình, import, cảnh báo.
- Tiêu chí nghiệm thu: Không vượt quyền hoặc ghi sổ khi thiếu policy.
- Luồng chuẩn: người có quyền lập dữ liệu, backend kiểm tra, duyệt nếu cần, ghi nhận, truy vết và báo cáo.
- Ngoại lệ: dữ liệu không hợp lệ trả lỗi rõ bằng tiếng Việt, không ghi một phần; kiểm tra quyền và phiên bản khi cập nhật.
## Phi chức năng (mục tiêu đề xuất)
30 người đồng thời; P95 API thường dưới 500ms, báo cáo chuẩn dưới 3s trên bộ dữ liệu benchmark đã ghi rõ; RPO 15 phút, RTO 4 giờ, uptime 99,9% mục tiêu không phải SLA. Kiểm thử tải và restore trước nghiệm thu. WCAG tương phản, thao tác bàn phím; xuất Excel/PDF; tiền dạng decimal, ngày nghiệp vụ tách timestamp UTC.
## Ngoài phạm vi
Thuế pháp định, phát hành hóa đơn, đa pháp nhân, AI tự hạch toán, thanh toán ngân hàng tự động, HRM đầy đủ. API ngân hàng thật phụ thuộc cấp quyền.
