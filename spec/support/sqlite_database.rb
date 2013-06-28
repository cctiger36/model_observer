module Support
  module SqliteDatabase
    def seed
      author1 = Author.create(:name => "Author One")
      author2 = Author.create(:name => "Author Two")

      book11 = author1.books.create(:name => "Book11")
      book12 = author1.books.create(:name => "Book12")
      book13 = author1.books.create(:name => "Book13")

      book21 = author2.books.create(:name => "Book21")
      book22 = author2.books.create(:name => "Book22")
      book23 = author2.books.create(:name => "Book23")
    end

    def setup
      ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

      ActiveRecord::Schema.define(:version => 0) do
        create_table :authors do |t|
          t.string :name
        end

        create_table :books do |t|
          t.integer :author_id
          t.string :name
        end
      end
    end

    def teardown
      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.drop_table(table)
      end
    end

    extend self
  end
end
