class ApiDomain

  def matches?(request)
    request.host == 'api.localhost'
  end
end
