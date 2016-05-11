module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module HeadersHelpers
    def api_header(version = 1)
      request.headers['Accept'] = "application/vnd.brasilsemzika.v#{version}"
    end

    def api_response_format(format = Mime::JSON)
      request.headers['Accept'] += ",#{format}"
      request.headers['Content-Type'] = format.to_s
    end

    def api_token(token)
      api_header
      api_response_format
      request.env['HTTP_AUTHORIZATION'] = token
    end

  end
end

RSpec.configure do |config|
  config.include Request::JsonHelpers, type: :controller
  config.include Request::HeadersHelpers, type: :controller
end

