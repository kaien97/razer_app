# Loans and transactions with Mambu, as well as other APIs
class MambuService
  include EncryptionHelper
  def initialize
    @base_url = "https://#{ENV['MAMBU_USERNAME']}:#{ENV['MAMBU_PASSWORD']}@#{ENV['MAMBU_TENANT']}"
  end

  def transfer(sender, receiver, amount, notes = nil)
    body = {
            	"type": "TRANSFER",
              "amount": amount.to_s,
              "notes": notes || "Transfer",
              "toSavingsAccount": receiver.mambu_account_id,
              "method":"bank"
            }
    header = {
      'Content-Type': 'application/json'
    }
    request = HTTParty.post("#{@base_url}/api/savings/#{sender.mambu_account_id}/transactions", headers: header, body: body.to_json)
    if request.response.code == "201"
      return true
    else
      return false
    end
  end

  def balance(account)
    request = HTTParty.get("https://#{ENV['MAMBU_USERNAME']}:#{ENV['MAMBU_PASSWORD']}@#{ENV['MAMBU_TENANT']}/api/savings/#{account.mambu_account_id}/")
    return request["balance"]
  end
end
