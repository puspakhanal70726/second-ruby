require "sqlite3"

db = SQLite3::Database.new "./db/dev.db"

db.execute "
  create table movies (
    id INTEGER PRIMARY KEY ASC,
    name VARCHAR(255),
    writer VARCHAR(255),
    actor VARCHAR(255),
    quality VARCHAR(255)
  );
"

moives = [
  ["Puspa", "plkhanal@stevens.edu", "student"],
]

movies.each do |movies|
  db.execute(
    "INSERT INTO movies (name, writer, actor, qulaity) VALUES (?, ?, ?)", movies
  )
end
