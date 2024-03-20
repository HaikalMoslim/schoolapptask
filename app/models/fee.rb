class Fee < ApplicationRecord
    belongs_to :user
      
    def generate_checksum
        Rails.logger.info("Generating checksum for fee #{id}")
        string = "#{email}|#{name}|#{phone}||#{id}|#{name}|http://localhost:3000/fees/#{id}/paymentredirect|#{total}|7732d8b9-369f-41d1-be65-e5b1a94f6a4b"
        puts(string)
        checksum_token = "2f0cee7b563145197772caadb21554945a45ac9f43b8e6c9533326c20fcd4a7e"
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), checksum_token, string)
    end
end
