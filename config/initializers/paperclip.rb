# Isolate var and functions definitions
begin

  # Set option only if it's in ENV variables
  # @param [Hash] path Object in which options should be merged
  # @param [Hash] hash Object to merge (keys are options in Ruby, values are ENV
  #   variables or sub-level hash)
  def set_paperclip_options(path, hash)
    path = Paperclip::Attachment.default_options if path.nil?
    hash.each do |key, value|
      if value.instance_of? String
        unless ENV[value].nil?
          if key == :storage
            path[key] = ENV[value].to_sym
          else
            path[key] = ENV[value]
          end
        end
      else
        set_paperclip_options(path[:key], value)
      end
    end
  end

  set_paperclip_options nil, storage: 'PAPERCLIP_STORAGE',
                             s3_credentials: {
                               bucket: 'PAPERCLIP_BUCKET',
                               access_key_id: 'S3_ACCESS_KEY_ID',
                               secret_access_key: 'S3_SECRET_ACCESS_KEY' }

  unless Object.const_defined?('AWS') && ENV['S3_ACCESS_KEY_ID'].nil? && ENV['S3_SECRET_ACCESS_KEY'].nil?
    AWS.config(
      access_key_id: ENV['S3_ACCESS_KEY_ID'],
      secret_access_key: ENV['S3_SECRET_ACCESS_KEY'])
  end
end
