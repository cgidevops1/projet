#Le user root doit exister
describe user('root') do
  it { should exist }
end

#Le user apache doit exister
describe user('apache') do
  it { should exist }
end

#Verifier que httpd est enables
describe service('httpd.service') do
  it { be_running }
end


#Le port 80 doit etre ouvert
describe port(80) do
  it { should be_listening }
end

#Verifier que le folder apache par default est present
describe directory("/var/www") do
	it { should exist }
end


