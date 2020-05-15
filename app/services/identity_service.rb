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
    request1 = HTTParty.post("https://niw1itg937.execute-api.ap-southeast-1.amazonaws.com/Prod/verify",
                             headers: header,
                             body: body1.to_json)
    request2 = HTTParty.post("https://niw1itg937.execute-api.ap-southeast-1.amazonaws.com/Prod/verify",
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

      if ((request1.parsed_response["vision"]["extract"]["idNum"] != request2.parsed_response["vision"]["extract"]["idNum"]))
        message = "Please use the same ID for the front and back!"
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

  private
  # delete sensitive images from database
  def clear_images(identity)
    identity.update(temp_image_back: "", temp_image_front: "")
  end
end
