class HomeController < ApplicationController
  def index
  	@groups = Group.all
  	 Institution.all.each do |institution|
	  Apartment::Tenant.switch(institution.subdomain) do
	    @groups = @groups + Group.all 
	  end
	end
	puts
  end
end
