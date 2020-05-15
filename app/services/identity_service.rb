# KYC with FWD, and registration with Mambu
class IdentityService
  include EncryptionHelper

  def fwd_verify(identity)
    header = {
      'Content-Type': 'application/json',
      'x-api-key': ENV['FWD_KEY'],    }
    body1 = {
      'base64image': encode_image(identity.temp_image_front),    }
    body2 = {
      'base64image': encode_image(identity.temp_image_back),    }
    request1 = HTTParty.post("#{ENV['FWD_URL']}/Prod/verify",
                             headers: header,
                             body: body1.to_json)
    request2 = HTTParty.post("#{ENV['FWD_URL']}/Prod/verify",
                             headers: header,
                             body: body2.to_json)

    clear_images(identity)

    if request1&.parsed_response&.[]("qualityCheck")&.[]("finalDecision") && request2&.parsed_response&.[]("qualityCheck")&.[]("finalDecision")
      case request1.parsed_response["vision"]["type"]
      when "No Results"
        message = "Can't identify type of ID"
        return false, message
      when 'sg_id_front'
        type = "NRIC"
      else
        type = request1.parsed_response["vision"]["type"]
      end

      name = request1.parsed_response["vision"]["extract"]["name"]

      if ((request1.parsed_response["vision"]["extract"]["idNum"] != request2.parsed_response["vision"]["extract"]["idNum"]))
        message = "Please use the same ID for the front and back!"
        return false, message
      elsif !(name.include?(identity.first_name) && name.include?(identity.last_name) && name.include?(identity.middle_name.to_s))
        message = "Please enter your name as it is written on the ID!"
        return false, message
      end

      result = identity.update( type: type,
                                verified: true,
                                encrypted_idnum: encrypt(request1.parsed_response["vision"]["extract"]["idNum"]),
                                encrypted_dob: encrypt(request1.parsed_response["vision"]["extract"]["dob"]),
                                encrypted_name: encrypt(request1.parsed_response["vision"]["extract"]["name"]),
                                encrypted_race: encrypt(request1.parsed_response["vision"]["extract"]["race"]),
                                encrypted_country: encrypt(request1.parsed_response["vision"]["extract"]["countryOfBirth"]),
                                issue_date: encrypt(request2.parsed_response["vision"]["extract"]["issueDate"]))

    elsif request1&.parsed_response&.[]("qualityCheck")&.[]("finalDecision") # front is fine, back is not
      message = request2.parsed_response&.[]("vision")&.[]("extract")&.[]("quality")&.[]("statement") || "Error with back image"
    else
      message = request1.parsed_response&.[]("vision")&.[]("extract")&.[]("quality")&.[]("statement") || "Error with front image"
    end

    return false, message

    if result
      message = "Identity succesfully verified!"
      return true, message
    else
      flash[:danger] = "An error has occurred. Please try again."
      return false, message
    end
  end

  def create_mambu_client(identity)
    @base_url = "https://#{ENV['MAMBU_USERNAME']}:#{ENV['MAMBU_PASSWORD']}@#{ENV['MAMBU_TENANT']}"

    id_details = get_mambu_id_details

    for id_type in id_details
      if id_type["documentType"].include?(identity.type)
        @id_type = id_type
        break
      end
    end

    if @id_type.nil?
      return
    end

    idDocuments = [
      {
        "documentType": @id_type["documentType"],
        "documentId": "S111111A",#decrypt(identity.encrypted_idnum),
        "issuingAuthority": @id_type["issuingAuthority"],
        "validUntil": (Time.now + 2.years).strftime("%F"), # NRIC has no expiry?
        "identificationDocumentTemplateKey": @id_type["encodedKey"],
      }
    ]

    header = {
      'Content-Type': 'application/json'
    }

    body = {
              "client":{
                "firstName": identity.first_name,
                "lastName": identity.last_name,
                "preferredLanguage": "ENGLISH",
                #"middleName": current_user.middle_name
                "assignedBranchKey": ENV['MAMBU_KEY']
              },
              "idDocuments": idDocuments,
              "addresses": [],
              "customInformation": [
                {
                  "value": identity.account.hash_id,
                  "customFieldID": "TesLahAccountId"
                }
              ]
            }

    request = HTTParty.post("#{@base_url}/api/clients", headers: header, body: body.to_json)
    #request = HTTParty.get("#{@base_url}/api/clients?branchID=#{ENV['MAMBU_KEY']}")

    mambu_id = request.parsed_response["client"]["encodedKey"]
    identity.account.update(mambu_user_id: mambu_id)
  end

  def create_mambu_account(account)
    @base_url = "https://#{ENV['MAMBU_USERNAME']}:#{ENV['MAMBU_PASSWORD']}@#{ENV['MAMBU_TENANT']}"

    body = {
              "savingsAccount": {
                  "name": "Digital Account",
                  "accountHolderType": "CLIENT",
                  "accountHolderKey": account.mambu_id,
                  "accountState": "APPROVED",
                  "productTypeKey": "8a8e878471bf59cf0171bf6979700440",
                  "accountType": "CURRENT_ACCOUNT",
                  "currencyCode": "SGD",
                  "allowOverdraft": "true",
                  "overdraftLimit": "100",
                  "overdraftInterestSettings": {
                      "interestRate": 5
                  },
                      "interestSettings": {
                  "interestRate": "1.25"
                  }
              }
            }

    header = {
      'Content-Type': 'application/json',
    }

    request = HTTParty.post("#{@base_url}/api/savings", headers: header, body: body.to_json)
    mambu_id = request.parsed_response["savingsAccount"]["encodedKey"]
    account.update(mambu_account_id: mambu_id)
  end

  private

  def get_mambu_id_details
    request = HTTParty.get("#{@base_url}/api/settings/iddocumenttemplates")
    return request.parsed_response
  end

  # delete sensitive images from database
  def clear_images(identity)
    identity.update(temp_image_back: "", temp_image_front: "")
  end
end
