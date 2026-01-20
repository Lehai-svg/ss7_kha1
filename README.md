a. Loại chỉ mục hiệu quả nhất cho từng truy vấn.
  B-tree hiệu quả nhất cho truy vấn so sánh chính xác (genre = 'Fantasy').
  GIN + trigram là lựa chọn tối ưu cho ILIKE '%keyword%'.
  GIN full-text phù hợp khi tìm kiếm theo nội dung dài (title, description).
  CLUSTER giúp tăng tốc truy vấn theo cột được nhóm, nhưng không tự động duy trì.

b. Khi nào Hash index không được khuyến khích trong PostgreSQL?
  Hash index chỉ hỗ trợ phép so sánh = 
  Không dùng được cho range, order by, like
  Không được dùng trong nhiều chiến lược query planner
  Khó bảo trì, ít lợi thế hơn B-tree
  PostgreSQL khuyến nghị dùng B-tree thay cho Hash index trong hầu hết trường hợp.
