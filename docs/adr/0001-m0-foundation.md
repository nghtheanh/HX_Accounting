# ADR 0001 · Nền tảng M0

Trạng thái: Đã áp dụng cho môi trường DEMO của M0, chờ phê duyệt milestone.

## Nền tảng và tương thích

- Node.js 24.22.3 LTS, pnpm 10.34.9 và TypeScript 5.9.3. Chốt Node tại `.node-version`, pnpm tại `packageManager` và dependency qua lockfile. CI và Docker cài ở chế độ frozen. TypeScript 5.9 nằm trong dải được Prisma 7 và typescript-eslint hỗ trợ.
- Next.js 16.4.6 App Router và React/React DOM 19.3.1 cho web. Next.js 16 yêu cầu Node từ 20.9 và chạy ESLint như bước riêng.
- NestJS 11.2.12 với adapter Express, ES modules và TypeScript decorators. Dòng 11 chạy trên Node từ 20, tương thích RxJS 7.1 trở lên và được khai báo tường minh ở API.
- PostgreSQL 17.12 và Prisma Migrate 7.10.1. Node 24 đáp ứng Prisma 7. API dùng driver `pg` để thực hiện truy vấn readiness. Bổ sung Prisma Client và PostgreSQL adapter khi bắt đầu truy vấn dữ liệu nghiệp vụ.
- ESLint 10.15.0, typescript-eslint 8.74.0, Node test runner và Python 3.12 trong CI cho oracle Golden hiện có. PostgreSQL chạy thật trong CI.

Nguồn tương thích: [Node.js 24](https://nodejs.org/en/download/archive/v24), [Next.js 16](https://nextjs.org/docs/app/guides/upgrading/version-16), [NestJS](https://docs.nestjs.com/faq/versions), [Prisma 7](https://www.prisma.io/docs/orm/v7), [PostgreSQL](https://www.postgresql.org/support/versioning/).

## Ranh giới monorepo

- `apps/web` sở hữu giao diện tiếng Việt và gọi API. `apps/api` sở hữu HTTP, phân quyền và điều phối transaction. Cùng một modular monolith backend với ranh giới sở hữu bảng như đã mô tả trong kiến trúc.
- `packages/domain` sẽ chứa quy tắc và kiểu nghiệp vụ thuần, không phụ thuộc framework, transport hoặc ORM. `packages/ui` sẽ chứa thành phần giao diện dùng chung. `packages/contracts` sẽ chứa kiểu/clients dùng chung sinh từ hợp đồng đã duyệt khi có bên tiêu thụ. Workspace đã khai báo glob cho các package này.
- `contracts/` giữ SQL/OpenAPI tham chiếu. Hợp đồng health riêng phiên bản M0 nằm cùng thư mục. `prisma/` chứa migration thực thi. `tests/` giữ oracle độc lập và kiểm tra xuyên ứng dụng. Test có phụ thuộc module/API được đặt cùng API. `migration/` giữ template chuyển đổi lịch sử.
- PostgreSQL là nguồn sự thật. M1/M2 sẽ tách quyền app và migrator. Khi ghi sổ, kiểm tra quyền, policy và version, khóa kỳ/chứng từ/sổ phụ theo thứ tự ổn định, cập nhật journal, sổ phụ, audit và outbox cùng transaction. Outbox dành cho việc sau commit. S3/private storage, Redis/BullMQ và adapter bên ngoài được bổ sung theo nhu cầu đã xác nhận.

## Quyết định kỹ thuật M0

Web chỉ có trang tiếng Việt với nhãn DEMO. API cung cấp liveness và readiness; readiness kiểm tra kết nối PostgreSQL và trả 503 khi không sẵn sàng. Bootstrap tạo schema rỗng `workpilot`, giữ lịch sử Prisma ở `public`; mọi bảng nghiệp vụ mới đi qua migration và được ánh xạ tường minh vào schema ứng dụng. Bộ Compose phát hành cổng trên loopback host và chỉ dùng thông tin đăng nhập DEMO.
