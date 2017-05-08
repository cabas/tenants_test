module ApplicationHelper

  def is_public_tenent?
    Apartment::Tenant.current == 'public'
  end

  def current_institution_message
    ins_name = current_institution_name
    "Bienvenido al dominio de #{ins_name} de esta app"
  end

  def current_institution_name
    current_tenant = Apartment::Tenant.current
    unless current_tenant == 'public'
      institution = Institution.find_by(subdomain: current_tenant)
      institution.name
    else
      "público"
    end
    
  end
end
