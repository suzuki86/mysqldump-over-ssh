require 'rubygems'
require 'net/ssh'
require 'date'

host = ""
user = ""
password = ""
db_name = ""
db_user = ""
db_password = ""
target_dir = ""

datetime = DateTime.now.strftime('%Y%m%d%H%M%S')
command = "mysqldump -u" + db_user + " -p" + db_password + " " + db_name + " --default-character-set=binary"
filename = datetime + "_" + host + "_" + db_name + "_" + "mysqldump.sql"
stdout = ""

Net::SSH.start(host, user, :password => password) do |ssh|
  ssh.exec(command) do |channel, stream, data|
    stdout << data if stream == :stdout
  end
end

fh = File.open(target_dir + filename, "w")
fh.write(stdout)
fh.close
