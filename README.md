## a. Loại chỉ mục hiệu quả nhất cho từng truy vấn

- **B-tree** hiệu quả nhất cho truy vấn so sánh chính xác  
  (ví dụ: `genre = 'Fantasy'`).

- **GIN + trigram** là lựa chọn tối ưu cho truy vấn  
  `ilike '%keyword%'`.

- **GIN full-text** phù hợp khi tìm kiếm theo nội dung dài  
  (`title`, `description`).

- **cluster** giúp tăng tốc truy vấn theo cột được nhóm,  
  nhưng không tự động duy trì khi có dữ liệu mới.

## b. Khi nào hash index không được khuyến khích trong postgresql?

- Hash index **chỉ hỗ trợ phép so sánh `=`**
- Không dùng được cho `range`, `order by`, `like`
- Không được sử dụng trong nhiều chiến lược của query planner
- Khó bảo trì và ít lợi thế hơn b-tree

==> Vì vậy postgresql **khuyến nghị sử dụng b-tree thay cho hash index**  
trong hầu hết các trường hợp.
