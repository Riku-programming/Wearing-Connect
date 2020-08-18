# require 'carrierwave/storage/abstract'
# require 'carrierwave/storage/file'
# require 'carrierwave/storage/fog'
#
# CarrierWave.configure do |config|
#   if Rails.env.production?
#     config.storage = :fog
#     config.fog_provider = 'fog/aws'
#     # config.fog_public = false
#     config.fog_credentials = {
#         provider: 'AWS',
#         aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
#         aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
#         region: 'ap-northeast-1'
#     }
#     config.storage = :fog
#     config.fog_directory  = 'wearing-connect-photo' #S3のバケット名
#     config.asset_host = 'https://s3-ap-north-east-1.amazonaws.com/wearing-connect-photo'
#   else
#     config.storage :file # 開発環境:public/uploades下に保存
#     config.enable_processing = false if Rails.env.test? #test:処理をスキップ
#   end
# end
#
# CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
