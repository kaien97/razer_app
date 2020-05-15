class AccountController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_verified, except: [:verify, :verification]

  respond_to :html, :js
  def create
  end

  def add
  end

  def select
  end

  def delete
  end

  def verify
  end

  def verification
    current_user.account.identity.update(verify_params)
    result, message = IdentityService.new.fwd_verify(current_user.account.identity)
    if result
      flash[:success] = message
    else
      flash[:danger] = message
    end
    redirect_to root_path
  end

  def dashboard
    @user = current_user



    if current_user.mambu_id
      #@mambu_key = current_user.mambu_id
    else
      create_mambu_account
    end

    request = HTTParty.get("https://Team121:pass3F74506E9B@razerhackathon.sandbox.mambu.com/api/clients/#{@mambu_key}")

  end

  private

  def check_if_verified
    if !current_user&.account&.verified
      redirect_to account_verify_path(current_user.hash_id)
    end
  end

  def verify_params
    params.require(:identity).permit(:temp_image_front, :temp_image_back)
  end

  def create_mambu_account

    idDocuments = [
      {
        "documentType": "NRIC",
        "documentId": "S1234567A",
        "issuingAuthority": "Police",
        "validUntil": Time.now + 2.years,
        "identificationDocumentTemplateKey": "9b0a97094b4cd73f014b5f5ef0e811d2"
      }
    ]

    body = {
              "client":{
                "firstName": "Test", #current_user.first_name,
                "lastName": "User", #current_user.last_name,
                #"middleName": current_user.middle_name
                "assignedBranchKey": ""
              },
              "idDocuments": idDocuments,
    }

    request = HTTParty.post("https://Team121:pass3F74506E9B@razerhackathon.sandbox.mambu.com/api/clients", body: body)
  end
end
