module MktoRest
  # http://developers.marketo.com/documentation/rest/error-codes/

  # Code | Description               | Comment
  # 600  | Empty access token
  EMPTY_TOKEN = 600          # so this can be internally raised when authentication hasn't been attempted
  # 601  | Access token invalid      | Unauthorized
  # 602  | Access token expired      | Unauthorized
  ACCESS_TOKEN_EXPIRED = 602    # so a retry can be immediately attempted
  # 603  | Access denied | Authentication is successful but user doesn't have sufficient permission to call this API
  # 604  | Request timed out
  # 605  | HTTP Method not supported | GET is not supported for sync lead
  # 606  | Max rate limit '%s' exceeded with in '%s' secs
  # 607  | Daily quota reached
  # 608  | API Temporarily Unavailable
  # 609  | Invalid JSON
  # 610  | Requested resource not found
  # 611  | System error         | All unhandled exceptions
  # 612  | Invalid Content Type

  class Error < RuntimeError
    attr_reader :code
    def initialize(message=nil, code=nil)
      exc = super(message)
      @code = code
      exc
    end
  end
end
