require 'openssl'
require 'base64'

module EncryptionHelper
  # Used for general encryption/decryption using the AES standard
  # An AES 128-bit key can be expressed as a hexadecimal string with 32 characters. It will require 24 characters in base64.

  KEY = ENV['AES_ENCRYPTION_TOKEN']
  ALGORITHM = 'AES-128-ECB'

  def encrypt(msg)
    begin
      cipher = OpenSSL::Cipher.new(ALGORITHM)
      cipher.encrypt()
      cipher.key = KEY
      crypt = cipher.update(msg) + cipher.final()
      crypt_string = (Base64.encode64(crypt))
      return crypt_string
    rescue Exception => exc
      puts ("Message for the encryption log file for message #{msg} = #{exc.message}")
    end
  end

  def decrypt(msg)
    begin
      cipher = OpenSSL::Cipher.new(ALGORITHM)
      cipher.decrypt()
      cipher.key = KEY
      tempkey = Base64.decode64(msg)
      crypt = cipher.update(tempkey)
      crypt << cipher.final()
      return crypt
    rescue Exception => exc
      puts ("Message for the decryption log file for message #{msg} = #{exc.message}")
    end
  end

  def encode_image(image_link)
    Base64.encode64(File.open("app/assets/images/test_image.png", "rb").read)
  end
end
