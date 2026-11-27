# Milestones và cổng nghiệm thu
| M | Bàn giao | Gate |
|---|---|---|
| 0 | Repo, Docker dev, CI, lint/test, ADR | build/test chạy local |
| 1 | IAM, danh mục, policy, approval | deny-by-default, audit, policy gate |
| 2 | Ledger, kỳ, journal | balanced, reverse, lock, concurrency tests |
| 3 | Cash/bank, import/reconcile | transfer đúng, replay không trùng |
| 4 | Sales/purchase/AR/AP | partial/gộp/đặt cọc/trả hàng |
| 5 | Inventory | bình quân, lô, concurrent issue, replay preview |
| 6 | BOM/MTO/MTS/gia công | version, WIP, partial output |
| 7 | Costing | allocation, phôi không đếm đôi, chốt |
| 8 | Attendance/payroll | import trùng, tính lương và ứng trước |
| 9 | Assets/CCDC/invoice/budget/reports/alerts | reconcile reports, permission export |
| 10 | Migration | đối soát 2026, ký chênh lệch |
| 11 | Release | UAT, security/load/restore, parallel run |
Mỗi gate cần evidence test thật, kế toán ký phần nghiệp vụ, chủ phê duyệt phạm vi. Không chuyển production khi thiếu policy. Bank API thật là integration có điều kiện; adapter/mock/import đủ cho gate cơ sở.
