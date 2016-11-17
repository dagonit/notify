module JsonFormatter
  def json_response
    @json_response ||= Hashie::Mash.new( JSON.parse(response.body) )
  end
end
