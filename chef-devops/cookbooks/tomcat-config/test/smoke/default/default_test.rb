# # encoding: utf-8

# Inspec test for recipe modjk::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(8080)
it {should be_listening}
end

describe port(8009)
it {should be_listening}
end

describe port(22)
it {should be_listening}
end

describe directory("/opt/tomcat/webapps/sakila")
it {should exist}
end
