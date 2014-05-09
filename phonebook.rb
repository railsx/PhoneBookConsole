require 'sqlite3'
puts ""
puts ""
puts ""
puts '------------------------------------'
puts '----Welcome to PhoneBook Console----'
puts '------------------------------------'
puts ""
puts ""
puts ""


begin
	vr = SQLite3::Database.new ":memory:"
	puts "Your SQLite Version: " + (vr.get_first_value 'SELECT SQLITE_VERSION()')
	puts ""
	db = SQLite3::Database.new "phonebook.db"
	db.execute "CREATE TABLE IF NOT EXISTS Contacts(Id INTEGER PRIMARY KEY, Name TEXT, Number INTEGER)"
	puts "Enter 1 to Create a Contact or"
	puts "Enter 2 to find a contacts by Number"
	puts "Enter 3 to Edit a Contact by Number"
	puts "Enter 4 to Delete a Contact by Number"
	puts "Enter 5 to Exit."
	puts ""
	puts ""
	puts "Enter Value to move further."
	puts ""
	puts ""
	a = gets.to_i

	case a
		when 1
		puts "Enter Name:"
		name = gets.to_s
		puts "Enter Number:"
		no = gets.to_i

		row = db.get_first_row "SELECT * FROM Contacts WHERE Number=?", no

		if row == nil
			db.execute "INSERT INTO Contacts(Name, Number) VALUES('#{name}', #{no})"
		else
			puts "Contact is already present."
		end

		when 2
			puts "Enter Number:"

			no = gets.to_i

			row = db.get_first_row "SELECT * FROM Contacts WHERE Number=?", no

			if row == nil	
				puts "sorry. No Contacts Found."				
			else
				puts row.join "\s"
			end

		when 3
			puts "Enter Number:"

			no = gets.to_i

			row = db.get_first_row "SELECT * FROM Contacts WHERE Number=?", no

			if row == nil
				puts "Sorry. No contacts Found."
			else
				puts "Enter Name:"
				name = gets.to_s
				puts ""
				puts "Enter Number:"
				no = gets.to_i

				db.execute "UPDATE Contacts SET Name='#{name}' WHERE Id=#{row[0]}"
				db.execute "UPDATE Contacts SET Number='#{no}' WHERE Id=#{row[0]}"
				puts ""
				puts "Contact has been Updated."
			end
		when 4
			puts "Enter Number:"

			no = gets.to_i

			row = db.get_first_row "SELECT * FROM Contacts WHERE Number=?", no


			if row == nil
				puts "Sorry. No contacts Found."
			else
				db.execute "DELETE FROM Contacts WHERE Id=#{row[0]}"
				puts ""
				puts "Contact had been deleted."
			end

		when 5

		else
			puts "please Enter a Valid value."
	end


rescue SQLite3::Exception => e

	puts "Exception occured"
	puts e

ensure
	db.close if db
end