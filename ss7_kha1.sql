
create table book (
    book_id serial primary key,
    title varchar(255),
    author varchar(100),
    genre varchar(50),
    price decimal(10,2),
    description text,
    created_at timestamp default current_timestamp
);

-- chen du lieu gia (20 ban ghi)
insert into book (title, author, genre, price, description) values
('harry potter and the philosopher stone', 'j.k. rowling', 'fantasy', 15.50, 'a young wizard discovers magic'),
('harry potter and the chamber of secrets', 'j.k. rowling', 'fantasy', 16.00, 'dark secrets at hogwarts'),
('harry potter and the prisoner of azkaban', 'j.k. rowling', 'fantasy', 16.50, 'a dangerous escapee'),
('the hobbit', 'j.r.r. tolkien', 'fantasy', 14.20, 'a journey of a small hobbit'),
('the lord of the rings', 'j.r.r. tolkien', 'fantasy', 25.00, 'epic fantasy adventure'),
('a game of thrones', 'george r.r. martin', 'fantasy', 22.00, 'political fantasy and war'),
('a clash of kings', 'george r.r. martin', 'fantasy', 23.00, 'battle for the throne'),
('the catcher in the rye', 'j.d. salinger', 'novel', 12.00, 'classic coming of age story'),
('to kill a mockingbird', 'harper lee', 'novel', 13.50, 'justice and morality'),
('1984', 'george orwell', 'dystopian', 14.00, 'totalitarian society'),
('animal farm', 'george orwell', 'satire', 11.00, 'political satire'),
('the great gatsby', 'f. scott fitzgerald', 'novel', 13.00, 'american dream'),
('clean code', 'robert c. martin', 'technology', 30.00, 'software craftsmanship'),
('the pragmatic programmer', 'andrew hunt', 'technology', 32.00, 'practical programming advice'),
('design patterns', 'erich gamma', 'technology', 35.00, 'reusable object oriented design'),
('thinking in java', 'bruce eckel', 'technology', 28.00, 'java programming concepts'),
('learning sql', 'alan beaulieu', 'technology', 27.00, 'sql fundamentals'),
('database system concepts', 'abraham silberschatz', 'technology', 40.00, 'database theory'),
('the alchemist', 'paulo coelho', 'novel', 12.50, 'journey of self discovery'),
('inferno', 'dan brown', 'thriller', 18.00, 'mystery and symbols');

-- bat extension trigram
create extension if not exists pg_trgm;

-- tao index gin cho author (ilike)
create index idx_book_author_trgm
on book
using gin (author gin_trgm_ops);

-- tao index btree cho genre
create index idx_book_genre
on book (genre);

-- tao index full-text search cho title va description
create index idx_book_fts
on book
using gin (
    to_tsvector('english', title || ' ' || description)
);

-- tao index trigram cho title
create index idx_book_title_trgm
on book
using gin (title gin_trgm_ops);

-- truy van kiem tra truoc va sau index
explain analyze
select *
from book
where author ilike '%rowling%';

explain analyze
select *
from book
where genre = 'fantasy';

explain analyze
select *
from book
where to_tsvector('english', title || ' ' || description)
      @@ plainto_tsquery('english', 'magic wizard');

-- cluster bang theo genre
cluster book using idx_book_genre;

-- kiem tra hieu nang sau cluster
explain analyze
select *
from book
where genre = 'fantasy';
