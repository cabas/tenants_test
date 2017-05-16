class HomeController < ApplicationController
  def index
	#@groups = Group.all
	#Institution.all.each do |institution|
    #Apartment::Tenant.switch(institution.subdomain) do
    #@groups = @groups + Group.all 

    byebug

    
    first = ActiveRecord::Base.connection.execute("SELECT for_all_schemas('SELECT * FROM groups')")
    @groups = Group.find_by_sql("SELECT * FROM temptable")



    second = ActiveRecord::Base.connection.execute("SELECT for_all_schemas_full('SELECT * FROM groups')")
    @hashes = ActiveRecord::Base.connection.execute("SELECT * FROM temptable")
    puts @hashes.first
  end
end
