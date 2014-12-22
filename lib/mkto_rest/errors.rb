module MktoRest
  # http://developers.marketo.com/documentation/rest/error-codes/

  # Code | Description               | Comment
  # 600  | Empty access token
  EMPTY_TOKEN = 600          # so this can be internally raised when authentication hasn't been attempted
  # 601  | Access token invalid      | Unauthorized
  ACCESS_TOKEN_INVALID = 601
  # 602  | Access token expired      | Unauthorized
  ACCESS_TOKEN_EXPIRED = 602    # so a retry can be immediately attempted
  # 603  | Access denied | Authentication is successful but user doesn't have sufficient permission to call this API
  ACCESS_DENIED = 603
  # 604  | Request timed out
  REQUEST_TIMED_OUT = 604
  # 605  | HTTP Method not supported | GET is not supported for sync lead
  METHOD_NOT_SUPPORTED = 605
  # 606  | Max rate limit '%s' exceeded with in '%s' secs
  RATE_LIMIT_EXCEEDED = 606
  # 607  | Daily quota reached
  DAILY_QUOTA_REACHED = 607
  # 608  | API Temporarily Unavailable
  API_UNAVAILABLE = 608
  # 609  | Invalid JSON
  INVALID_JSON = 609
  # 610  | Requested resource not found
  RESOURCE_NOT_FOUND = 610
  # 611  | System error         | All unhandled exceptions
  SYSTEM_ERROR = 611
  # 612  | Invalid Content Type
  INVALID_CONTENT_TYPE = 612

  ERROR_MSGS = {
    EMPTY_TOKEN          => 'Empty access token',
    ACCESS_TOKEN_INVALID => 'Access token invalid',
    ACCESS_TOKEN_EXPIRED => 'Access token expired',
    ACCESS_DENIED        => 'Access denied',
    REQUEST_TIMED_OUT    => 'Request timed out',
    METHOD_NOT_SUPPORTED => 'HTTP Method not supported',
    RATE_LIMIT_EXCEEDED  => %r{Max rate limit '[^\']*' exceeded}, # with in '.*' secs
    DAILY_QUOTA_REACHED  => 'Daily quota reached',
    API_UNAVAILABLE      => 'API Temporarily Unavailable',
    INVALID_JSON         => 'Invalid JSON',
    RESOURCE_NOT_FOUND   => 'Requested resource not found',
    SYSTEM_ERROR         => 'System error',
    INVALID_CONTENT_TYPE => 'Invalid Content Type',
  }

  class Error < RuntimeError
    attr_reader :code
    def initialize(message=nil, code=nil)
      exc = super(message)
      if code
        @code = code
      else
        ERROR_MSGS.each do |a_code, a_message|
          if a_message === message
            @code = a_code
            break
          end
        end
      end
      exc
    end
  end
end
