class SubdomainConstraint
  def self.matches? (request)
    subdomains = %w{ www admin }
    request.subdomain.present? and !request.subdomain.include?(request.subdomain)
  end
end
