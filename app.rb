require "cuba"
require "cuba/safe"
require "cuba/render"
require "erb"
require "sqlite3"


Cuba.use Rack::Session::Cookie, :secret => ENV["SESSION_SECRET"] || "__a_very_long_string__"

Cuba.plugin Cuba::Safe
Cuba.plugin Cuba::Render

db = SQLite3::Database.new "./db/dev.db"

Cuba.define do
  on root do
    student_array = db.execute("SELECT * FROM movies")
    movies = student_array.map do |id, name, country, writer, actor, actress, language, quality|
      OpenStruct.new(:id => id, :name => name, :country => country, :writer => writer, :actor => actor, :actress => actress, :language => language, :quality => quality )
    end
    res.write view("index", movies: movies)
  end

  on "new" do
    res.write view("new")
  end

  on post do
    on "create" do
      name = req.params["name"]
      country = req.params["country"]
      writer = req.params["writer"]
      actor = req.params["actor"]
      actress = req.params["actress"]
      language = req.params["language"]
      quality = req.params["quality"]
      db.execute(
        "INSERT INTO movies (name, country, writer, actor, actress, language, quality) VALUES (?, ?, ?, ?, ?, ?, ?)",
        name, country, writer, actor, actress, language, quality
      )
      res.redirect "/"
    end

    on "delete/:id" do |id|
      db.execute(
        "DELETE FROM movies WHERE id=#{id}"
      )
      res.redirect "/"
    end
  end

  def not_found
    res.status = "404"
    res.headers["Content-Type"] = "text/html"

    res.write view("404")
  end
end
